// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, avoid_renaming_method_parameters, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import 'custom_painters.dart';

class CustomStopwatch extends StatefulWidget {
  final String text;
  final bool fromEvent;
  final event;
  final void Function()? onstop;
  final Stopwatch stopwatch;
  final AnimationController? controller;
  const CustomStopwatch({
    Key? key,
    required this.text,
    this.fromEvent = false,
    this.event,
    this.onstop,
    required this.stopwatch,
    required this.controller,
  }) : super(key: key);
  @override
  _CustomStopwatchState createState() => _CustomStopwatchState();
}

class _CustomStopwatchState extends State<CustomStopwatch> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _stopwatch = widget.stopwatch;
    _animationController = widget.controller!;
    // re-render screen every 30ms
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      _timer.tick;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void handleStartStop() {
    if (_stopwatch.isRunning) {
      loading = true;
      _stopwatch.stop();
      widget.onstop!();
    } else {
      _stopwatch.start();
    }
    setState(() {});
  }

  String startTime = '';
  late String stopTime;
  bool loading = false;

  void resetStopwatch() {
    _stopwatch.reset();
    setState(() {});
  }

  /// TOD: circular progress
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: CustomPaint(
                        painter: CustomTimerPainter(
                          animation: _animationController,
                          backgroundColor: AppColors.black.withOpacity(0.8),
                          color: AppColors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            text: formatTime(_stopwatch.elapsedMilliseconds),
                            size: 20,
                            alignment: Alignment.center,
                          ),
                          TextWidget(
                            text: widget.text,
                            size: 17,
                            alignment: Alignment.center,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // TextWidget(
          //   text: formatTime(_stopwatch.elapsedMilliseconds),
          //   size: 30,
          //   alignment: Alignment.center,
          // ),
          verticalSpace(height: 20),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     !loading
          //         ? ElevatedButton(
          //             onPressed: () {
          //               setState(() {
          //                 if (_stopwatch.isRunning) {
          //                   stopTime = TimeOfDay.now().format(context);
          //                   print(stopTime);
          //                 } else if (startTime.isEmpty || startTime == '') {
          //                   startTime = TimeOfDay.now().format(context);
          //                   print(startTime);
          //                 }
          //               });
          //               handleStartStop();
          //             },
          //             child: TextWidget(
          //               text: _stopwatch.isRunning ? 'Done' : 'Start',
          //               alignment: Alignment.center,
          //               color: AppColors.white,
          //             ),
          //             style: elevatedButton(),
          //           )
          //         : progressIndicator(),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class StopWatch extends StatefulWidget {
  final String text;
  final bool fromEvent;
  final event;
  final void Function()? onstop;
  final Stopwatch stopwatch;
  const StopWatch({
    Key? key,
    required this.text,
    this.fromEvent = false,
    this.event,
    this.onstop,
    required this.stopwatch,
  }) : super(key: key);
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = widget.stopwatch;
    // re-render screen every 30ms
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      _timer.tick;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: formatTime(_stopwatch.elapsedMilliseconds),
                  size: 20,
                  alignment: Alignment.center,
                ),
                TextWidget(
                  text: widget.text,
                  size: 17,
                  alignment: Alignment.center,
                  weight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
