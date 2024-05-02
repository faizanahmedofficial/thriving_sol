// ignore_for_file: use_key_in_widget_constructors, unused_element, no_leading_underscores_for_local_identifiers, library_private_types_in_public_api

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../Constants/constants.dart';
import '../Functions/functions.dart';
import '../Model/app_modal.dart';
import '../Widgets/text_widget.dart';

Stream<PositionData>? positionDataStream(AudioPlayer _player) =>
    Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
      _player.positionStream,
      _player.bufferedPositionStream,
      _player.durationStream,
      (position, bufferedPosition, duration) => PositionData(
        position,
        bufferedPosition,
        duration ?? Duration.zero,
      ),
    );

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar(
      {Key? key, required this.player, required this.title, this.child})
      : super(key: key);
  final AudioPlayer player;
  final String title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if (player.duration == Duration.zero) {
      player.stop();
    }
    return StreamBuilder<PositionData>(
      stream: positionDataStream(player),
      builder: (context, snapshot) {
        final positionData = snapshot.data;
        return SizedBox(
          width: 250,
          height: 250,
          child: SeekBar(
            duration: positionData?.duration ?? Duration.zero,
            position: positionData?.position ?? Duration.zero,
            bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
            time: !player.playing
                ? getDurationString(
                    (player.duration ?? Duration.zero).inSeconds)
                : getDurationString(
                    ((positionData?.duration ?? Duration.zero).inSeconds) -
                        ((positionData?.position ?? Duration.zero).inSeconds)),
            title: title,
            child: child,
          ),
        );
      },
    );
  }
}

// TOD: counter
class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final String time, title;
  final Widget? child;

  const SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    required this.time,
    required this.title,
    this.child,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CircularStepProgressIndicator(
      totalSteps: widget.duration.inSeconds,
      currentStep: widget.position.inSeconds,
      selectedColor: Colors.black,
      unselectedColor: Colors.blueGrey.withOpacity(0.7),
      selectedStepSize: 12,
      stepSize: 12,
      padding: 0,
      roundedCap: (_, cap) => true,
      child: widget.child ??
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                text: widget.time,
                alignment: Alignment.center,
                textAlign: TextAlign.center,
                size: 18,
              ),
              verticalSpace(height: 5),
              TextWidget(
                text: widget.title,
                alignment: Alignment.center,
                textAlign: TextAlign.center,
                size: 16,
                weight: FontWeight.bold,
              ),
            ],
          ),
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

class CustomCountdown extends StatelessWidget {
  const CustomCountdown({
    Key? key,
    required this.duration,
    required this.controller,
    this.onStart,
    this.onComplete,
    required this.caption,
    this.cheight,
    this.bottom,
    this.maxline,
  }) : super(key: key);
  final int duration;
  final CountDownController controller;
  final VoidCallback? onStart, onComplete;
  final String caption;
  final double? cheight, bottom;
  final int? maxline;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
          child: CircularCountDownTimer(
            width: width,
            height: cheight ?? height * 0.45,
            isReverse: true,
            autoStart: false,
            strokeWidth: 12.0,
            initialDuration: 0,
            isTimerTextShown: true,
            fillColor: Colors.black,
            isReverseAnimation: true,
            strokeCap: StrokeCap.round,
            ringColor: Colors.grey[300]!,
            backgroundColor: Colors.white,
            controller: controller,
            duration: duration,
            textFormat: duration <= 60
                ? CountdownTextFormat.SS
                : duration > 60 && duration < 3600
                    ? CountdownTextFormat.MM_SS
                    : CountdownTextFormat.HH_MM_SS,
            textStyle: const TextStyle(
              fontSize: 23.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: arail,
            ),
            onStart: onStart ?? () {},
            onComplete: onComplete ?? () {},
          ),
        ),
        Positioned(
          bottom: bottom ?? height * 0.2,
          child: Center(
            child: Container(
              width: width * 0.5,
              margin: const EdgeInsets.only(top: 15),
              child: TextWidget(
                text: caption,
                weight: FontWeight.bold,
                size: 20,
                alignment: Alignment.center,
                maxline: maxline ?? 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future playAlarm(AudioPlayer _player) async {
  String path = 'assets/Ding-sound-effect.mp3'; //'assets/listening/beep.mp3'
  await _player.setAsset(path);
  _player.play();
}
