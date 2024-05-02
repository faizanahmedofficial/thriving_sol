// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:schedular_project/Model/app_modal.dart';
import 'package:schedular_project/Theme/buttons_theme.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/custom_images.dart';

import '../Constants/constants.dart';
import '../Functions/functions.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/drop_down_button.dart';
import '../Widgets/spacer_widgets.dart';
import '../Widgets/text_widget.dart';
import '../app_icons.dart';

IconButton backButton([VoidCallback? back]) {
  return IconButton(
    onPressed: back ?? () => Get.back(),
    icon: const Icon(Icons.arrow_back),
  );
}

class ExerciseTitle extends StatelessWidget {
  const ExerciseTitle({Key? key, required this.title, this.onPressed})
      : super(key: key);
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextWidget(
            text: title,
            weight: FontWeight.bold,
            alignment: Alignment.center,
          ),
        ),
        IconButton(
          onPressed: onPressed ?? () {},
          icon: assetImage(AppIcons.read),
        ),
      ],
    );
  }
}

Widget roadmapText(String title, String value) {
  return RichText(
    textAlign: TextAlign.justify,
    text: TextSpan(
      text: title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: arail,
        fontSize: 14,
        color: Colors.black,
      ),
      children: [
        TextSpan(
          text: value,
          style: const TextStyle(
            fontFamily: arail,
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    ),
  ).marginOnly(bottom: 10);
}

Widget valueQuestions(String text,
    {bool fromgoal = false,
    FontWeight? weight,
    Widget? icon,
    IconData? icondata}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      icon ??
          Icon(icondata ?? Icons.comment, color: Colors.grey)
              .marginOnly(right: 10),
      SizedBox(
        width: width * 0.82,
        child: TextWidget(
          text: text,
          weight: weight ?? FontWeight.normal,
          fontStyle: fromgoal ? FontStyle.normal : FontStyle.italic,
        ),
      ),
    ],
  ).marginOnly(bottom: 10);
}

Widget valuesText(String title, String value) {
  return RichText(
    text: TextSpan(
      text: title,
      style: const TextStyle(
        fontFamily: arail,
        fontSize: 15,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.black,
      ),
      children: [
        TextSpan(
          text: value,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: arail,
            fontStyle: FontStyle.italic,
            color: Colors.black,
          ),
        ),
      ],
    ),
  ).marginOnly(bottom: 10);
}

class ListeningTitle extends StatelessWidget {
  const ListeningTitle({Key? key, required this.title, this.ontap})
      : super(key: key);
  final String title;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: headline(title)),
        IconButton(
          onPressed: ontap ?? () {},
          icon: assetImage(AppIcons.read),
        ),
      ],
    );
  }
}

class ReadingTitle extends StatelessWidget {
  const ReadingTitle({Key? key, required this.title, this.ontap})
      : super(key: key);
  final String title;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: titles(
            '$title (Reading)',
            alignment: Alignment.center,
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          onPressed: ontap ?? () {},
          icon: const Icon(Icons.play_arrow),
        ),
      ],
    );
  }
}

Widget richText2(int number, String title, String body) {
  return RichText(
    text: TextSpan(
      style: const TextStyle(color: Colors.black, fontSize: 16),
      children: [
        TextSpan(
          text: '$number)  $title',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: body)
      ],
    ),
  );
}

Widget checkboxRichText(String title, String body) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: width * 0.78,
        margin: const EdgeInsets.only(top: 10),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextSpan(text: body),
            ],
          ),
        ),
      )
    ],
  );
}

Widget textwidget(int number, String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black, fontSize: 16),
        children: [TextSpan(text: '$number) '), TextSpan(text: text)],
      ),
    ),
  );
}

Widget instructions() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textwidget(1, 'Take a slow, deep breath.'),
      textwidget(2,
          'Sit up straight, put your chin up a little bit, and put your shoulders back.'),
      textwidget(3,
          'Observe yourself as you would a loved one and ask yourself, "What is/was my stress level?"'),
    ],
  );
}

Widget richtextwidget(int number, String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black, fontSize: 16),
        children: [
          TextSpan(
            text: '$number) ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: text)
        ],
      ),
    ),
  );
}

Widget richtext(String title, String body) {
  return RichText(
    text: TextSpan(
      style: const TextStyle(color: Colors.black),
      children: [
        TextSpan(
          text: title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextSpan(text: body),
      ],
    ),
  );
}

class DateWidget extends StatelessWidget {
  const DateWidget({
    Key? key,
    required this.date,
    this.ontap,
    this.alignment,
    this.size,
    this.weight,
  }) : super(key: key);
  final String date;
  final VoidCallback? ontap;
  final Alignment? alignment;
  final double? size;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap ?? () {},
      child: TextWidget(
        text: date,
        alignment: alignment ?? Alignment.center,
        textAlign: TextAlign.left,
        size: size ?? 16,
        weight: weight ?? FontWeight.normal,
      ),
    );
  }
}

class FreeTop extends StatelessWidget {
  const FreeTop({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.seconds,
    required this.typelist,
    this.onTypeChanged,
    this.topic = '',
    this.text = false,
    this.ontopicChanged,
    this.changeDuration,
  }) : super(key: key);
  final String title, subtitle, topic;
  final int type, seconds;
  final List<AppModel> typelist;
  final void Function(dynamic)? onTypeChanged;
  final bool text;
  final void Function(String)? ontopicChanged;
  final VoidCallback? changeDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        headline('Free $title (Practice)').marginOnly(bottom: 10),
        TextWidget(
          text: subtitle,
          alignment: Alignment.center,
          fontStyle: FontStyle.italic,
        ).marginOnly(left: 35, right: 35, bottom: 40),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: text ? 'Topic' : 'Type',
                  weight: FontWeight.bold,
                  size: 16,
                ),
                horizontalSpace(width: width * 0.072),
                text
                    ? SizedBox(
                        width: width * 0.55,
                        child: TextFormField(
                          decoration: inputDecoration(),
                          onChanged: ontopicChanged,
                        ),
                      )
                    : CustomDropDownStruct(
                        width: width * 0.55,
                        child: DropdownButton(
                          value: type,
                          onChanged: onTypeChanged,
                          items: typelist
                              .map((e) => DropdownMenuItem(
                                    value: e.value,
                                    child: TextWidget(
                                      text: e.title,
                                      alignment: Alignment.centerLeft,
                                      // size: 12,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextWidget(
                    text: 'Duration', weight: FontWeight.bold, size: 16),
                InkWell(
                  onTap: changeDuration ?? () {},
                  child: Container(
                    width: width * 0.55,
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    decoration: BoxDecoration(border: Border.all()),
                    child: TextWidget(
                      text: seconds == 0
                          ? 'HH:MM:SS (Duration)'
                          : getDurationString(seconds),
                      color: seconds == 0 ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).marginOnly(bottom: 50),
      ],
    );
  }
}

class GuidedTop extends StatelessWidget {
  const GuidedTop({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onchanged,
    required this.list,
    this.choose = 'Choose Guided Audio',
    this.fromExercise = false,
    this.connectedReading,
  }) : super(key: key);
  final String title, subtitle, choose;
  final int value;
  final List<AppModel> list;
  final void Function(dynamic)? onchanged;
  final bool fromExercise;
  final VoidCallback? connectedReading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        fromExercise
            ? ListeningTitle(title: title, ontap: connectedReading)
            : headline('Guided $title (Practice)').marginOnly(bottom: 10),
        TextWidget(
          text: subtitle,
          alignment: Alignment.center,
          fontStyle: FontStyle.italic,
        ).marginOnly(left: 35, right: 35, bottom: 30),
        Center(
          child: TextWidget(
            text: choose,
            weight: FontWeight.bold,
            alignment: Alignment.centerLeft,
          ),
        ).marginOnly(left: 40),
        CustomDropDownStruct(
          child: DropdownButton(
            value: value,
            onChanged: onchanged,
            items: list
                .map((e) => DropdownMenuItem(
                      value: e.value,
                      child: SizedBox(
                        width: width * 0.65,
                        child: TextWidget(
                          text: e.title.replaceAll('Guided Audio', ''),
                          alignment: Alignment.centerLeft,
                          // size: 12,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ).marginOnly(bottom: 30),
      ],
    );
  }
}

class TopList extends StatelessWidget {
  const TopList({
    Key? key,
    required this.value,
    required this.onchanged,
    required this.list,
    this.play,
  }) : super(key: key);
  final int value;
  final void Function(dynamic)? onchanged;
  final List<AppModel> list;
  final VoidCallback? play;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PlayButton(play: play ?? () {}),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget(text: 'Next Step', weight: FontWeight.bold),
            CustomDropDownStruct(
              // width: width * 0.75,
              child: DropdownButton(
                value: value,
                onChanged: onchanged,
                items: list
                    .map((e) => DropdownMenuItem(
                          value: e.value,
                          child: SizedBox(
                            width: width * 0.6,
                            child: TextWidget(
                              text: e.title,
                              alignment: Alignment.centerLeft,
                              // size: 10,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ).marginOnly(bottom: 30),
      ],
    ).marginOnly(bottom: 50);
  }
}

class CustomBottom extends StatelessWidget {
  const CustomBottom({
    Key? key,
    required this.start,
    this.finish = 'Finished',
    this.onstart,
    this.onfinished,
    this.onVolumeChanged,
    this.slider = false,
    this.playing = false,
    this.player,
  }) : super(key: key);
  final String start, finish;
  final VoidCallback? onstart, onfinished;
  final void Function(double)? onVolumeChanged;
  final bool slider, playing;
  final AudioPlayer? player;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.volume_up_rounded),
            SizedBox(
              width: width * 0.73,
              child: slider
                  ? Slider(
                      value: 0.45,
                      onChanged: (val) {},
                      inactiveColor: Colors.grey.withOpacity(0.5),
                    )
                  : StreamBuilder<double>(
                      stream: player!.volumeStream,
                      builder: (context, snapshot) => SizedBox(
                        width: width * 0.7,
                        child: Slider(
                          min: 0.0,
                          max: 1.0,
                          divisions: 10,
                          value: player!.volume,
                          onChanged: onVolumeChanged,
                          inactiveColor: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
            ),
          ],
        ).marginOnly(left: 15, right: 15),
        playing
            ? PauseButton(
                player: player!,
                pause: onstart ?? () {},
                title: start,
              )
            : CustomElevatedButton(
                text: start,
                onPressed: onstart ?? () {},
              ).marginOnly(bottom: 40, left: 15, right: 15),
        CustomElevatedButton(
          text: finish,
          onPressed: onfinished ?? () async {},
        ).marginOnly(left: 25, right: 25)
      ],
    );
  }
}

class PauseButton extends StatelessWidget {
  const PauseButton(
      {Key? key, required this.player, this.pause, required this.title})
      : super(key: key);
  final AudioPlayer player;
  final VoidCallback? pause;
  final String title;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        if (processingState != ProcessingState.completed) {
          return CustomElevatedButton(
            text: 'Pause',
            onPressed: pause ?? () {},
          ).marginOnly(bottom: 40, left: 15, right: 15);
        } else {
          return CustomElevatedButton(
            text: title,
            onPressed: () => player.seek(Duration.zero),
          ).marginOnly(bottom: 40, left: 15, right: 15);
        }
      },
    );
  }
}

class JournalButtons extends StatelessWidget {
  const JournalButtons({
    Key? key,
    required this.first,
    required this.second,
    this.onFirst,
    this.onSecond,
  }) : super(key: key);
  final String first, second;
  final VoidCallback? onFirst, onSecond;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: width * 0.4,
            child: OutlinedButton(
              onPressed: onFirst ?? () {},
              style: outlineButton(radius: 0),
              child: TextWidget(
                text: first,
                alignment: Alignment.center,
                textAlign: TextAlign.center,
                size: 16,
              ),
            ),
          ),
          SizedBox(
            width: width * 0.4,
            child: OutlinedButton(
              onPressed: onSecond ?? () {},
              style: outlineButton(radius: 0),
              child: TextWidget(
                text: second,
                alignment: Alignment.center,
                textAlign: TextAlign.center,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
