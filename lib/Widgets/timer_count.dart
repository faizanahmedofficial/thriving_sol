// ignore_for_file: prefer_typing_uninitialized_variables, prefer_initializing_formals, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Widgets/custom_painters.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

counterDialog(
  BuildContext context,
  RxInt duration, {
  required var oncomplete,
  Widget? widgets,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        titlePadding: const EdgeInsets.all(0),
        contentPadding:
            const EdgeInsets.only(bottom: 10, left: 15, right: 15, top: 0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () => Get.back(), icon: const Icon(Icons.close)),
          ],
        ),
        content: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 450,
                  width: 250,
                  child: Countdowntimer(
                    secondsRemaining: duration,
                    whenTimeExpires: oncomplete,
                    customwidget: widgets ?? Container(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

// ignore: must_be_immutable
class Countdowntimer extends StatefulWidget {
  Countdowntimer({
    Key? key,
    required RxInt secondsRemaining,
    required this.whenTimeExpires,
    required this.customwidget,
  })  : secondsRemaining = secondsRemaining,
        super(key: key);
  final RxInt secondsRemaining;
  var whenTimeExpires;
  Widget customwidget;

  @override
  _CountdowntimerState createState() => _CountdowntimerState();
}

class _CountdowntimerState extends State<Countdowntimer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Duration duration;
  String status = '';

  @override
  void initState() {
    super.initState();
    print('initstate');
    duration = Duration(seconds: widget.secondsRemaining.value);
    _controller = AnimationController(vsync: this, duration: duration);
  }

  @override
  void didChangeDependencies() {
    print('didchangedependencies');
    duration = Duration(seconds: widget.secondsRemaining.value);
    _controller = AnimationController(
      vsync: this,
      duration: duration,
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get timerString {
    Duration duration = _controller.duration! * _controller.value;
    return '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: AppColors.white,
                height: _controller.value * height,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  /// circular countdown timer
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.center,
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: CustomPaint(
                                painter: CustomTimerPainter(
                                  animation: _controller,
                                  backgroundColor:
                                      AppColors.black.withOpacity(0.8),
                                  color: AppColors.white.withOpacity(0.7),
                                ),
                              ),
                            ),
                            Align(
                              alignment: FractionalOffset.center,
                              child: TextWidget(
                                text: timerString,
                                size: 20,
                                alignment: Alignment.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// play pause button
                  verticalSpace(height: 15),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return SizedBox(
                        height: 40,
                        width: width,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_controller.isAnimating) {
                              _controller.stop();
                              setState(() {
                                status = 'paused';
                              });
                            } else {
                              setState(() {
                                status = 'play';
                              });
                              _controller
                                  .reverse(
                                      from: _controller.value == 0.0
                                          ? 1.0
                                          : _controller.value)
                                  .whenComplete(widget.whenTimeExpires);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.white,
                            backgroundColor: AppColors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: TextWidget(
                            color: AppColors.white,
                            alignment: Alignment.center,
                            text: status == ''
                                ? 'Start Now!'
                                : status == 'play'
                                    ? 'Pause'
                                    : status == 'paused'
                                        ? 'Resume'
                                        : 'Stop',
                          ),
                        ),
                      );
                    },
                  ),

                  /// widget if required any
                  verticalSpace(height: 15),
                  widget.customwidget,
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
