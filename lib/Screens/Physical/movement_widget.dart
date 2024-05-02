// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/constants.dart';
import '../../Functions/functions.dart';
import '../../Model/movement_model.dart';
import '../../Theme/input_decoration.dart';
import '../../Widgets/checkboxes.dart';
import '../../Widgets/custom_images.dart';
import '../../Widgets/drop_down_button.dart';
import '../../Widgets/text_widget.dart';
import '../../Widgets/textbutton_icon.dart';
import '../../app_icons.dart';
import 'movement_home.dart';

class YJ1Widget extends StatefulWidget {
  const YJ1Widget(this._journal, {Key? key}) : super(key: key);
  final MovementWorkoutJournal _journal;

  @override
  State<YJ1Widget> createState() => _YJ1WidgetState();
}

class _YJ1WidgetState extends State<YJ1Widget> {
  final RxBool show = false.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 7, bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(border: Border.all()),
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: widget._journal.name!.capitalize!,
                        weight: FontWeight.bold,
                        size: 15,
                        maxline: 2,
                      ).marginOnly(bottom: 7),
                      TextWidget(
                        text:
                            '${getDurationString(widget._journal.seconds!)} Workout Length',
                        size: 16,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Get.to(() => const PlayWorkout(),
                      arguments: [widget._journal]),
                  icon: const Icon(Icons.play_arrow),
                  padding: EdgeInsets.zero,
                  iconSize: 40,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconTextButton(
                text: 'Make Journal Entry..',
                icon: Icons.edit,
                onPressed: () {
                  final MovementJournalEntry _entry = MovementJournalEntry(
                    start: '',
                    end: '',
                    duration: widget._journal.duration!,
                    durationSeconds: widget._journal.duration!,
                    date: widget._journal.date!,
                    id: '',
                    notes: '',
                    workouts: widget._journal.exercises,
                    type: 2,
                    userid: widget._journal.userid,
                    name: widget._journal.name,
                  );
                  Get.to(() => const BlankJournalEntry(),
                      arguments: [true, _entry]);
                },
              ),
              IconTextButton(
                text: 'Edit Routine',
                onPressed: () => Get.to(() => const NewMovementJournal(),
                    arguments: [true, widget._journal]),
                icon: Icons.article_outlined,
              ),
            ],
          ),
          CustomCheckBox(
            value: show.value,
            onChanged: (val) => show.value = val,
            title: 'Show Workout',
          ),
          if (show.value)
            Column(
              children: List.generate(
                widget._journal.exercises!.length,
                (indx) {
                  final _workout = widget._journal.exercises![indx];
                  return Column(
                    children: [
                      CustomCheckBox(
                        value: _workout.show,
                        onChanged: (val) => _workout.show = val,
                        title: _workout.name!.capitalize!,
                        width: width,
                      ),
                      // if (_workout.show!)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          _workout.exercises!.length,
                          (indx) {
                            final _exercise = _workout.exercises![indx];
                            return WExerciseWidget(
                              _exercise,
                              edit: false,
                              index: indx,
                              rindex: 0,
                              delete: false,
                            ).marginOnly(bottom: 10);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class YJ0Widget extends StatefulWidget {
  const YJ0Widget(this._exercise,
      {Key? key, this.edit, this.journal, this.play})
      : super(key: key);
  final RoutineExercise _exercise;
  final VoidCallback? edit, journal, play;

  @override
  State<YJ0Widget> createState() => _YJ0WidgetState();
}

class _YJ0WidgetState extends State<YJ0Widget> {
  final RxBool show = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  top: 7, bottom: 10, left: 10, right: 10),
              decoration: BoxDecoration(border: Border.all()),
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: widget._exercise.name!.capitalize!,
                          weight: FontWeight.bold,
                          size: 15,
                          maxline: 2,
                        ).marginOnly(bottom: 7),
                        TextWidget(
                          text:
                              '${getDurationString(widget._exercise.duration!)} Workout Length',
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: widget.play ?? () {},
                    icon: const Icon(Icons.play_arrow),
                    padding: EdgeInsets.zero,
                    iconSize: 40,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconTextButton(
                  text: 'Make Journal Entry..',
                  icon: Icons.edit,
                  onPressed: widget.journal ?? () {},
                ),
                IconTextButton(
                  text: 'Edit Routine',
                  onPressed: widget.edit ?? () {},
                  icon: Icons.article_outlined,
                ),
              ],
            ),
            CustomCheckBox(
              value: show.value,
              onChanged: (val) => show.value = val,
              title: 'Show Workout',
            ),
            if (show.value)
              Column(
                children: List.generate(
                  widget._exercise.rworkouts!.length,
                  (indx) {
                    final _workout = widget._exercise.rworkouts![indx];
                    return Column(
                      children: [
                        CustomCheckBox(
                          value: _workout.show,
                          onChanged: (val) {
                            setState(() {
                              _workout.show = val;
                            });
                          },
                          title: _workout.name!.capitalize!,
                          width: width,
                        ),
                        if (_workout.show!)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              _workout.exercises!.length,
                              (indx) {
                                final _exercise = _workout.exercises![indx];
                                return WExerciseWidget(
                                  _exercise,
                                  edit: false,
                                  index: indx,
                                  rindex: 0,
                                  delete: false,
                                ).marginOnly(bottom: 10);
                              },
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

class WExerciseWidget extends StatefulWidget {
  WExerciseWidget(
    this._exercise, {
    Key? key,
    this.onimage,
    required this.edit,
    this.delete = false,
    this.image,
    this.type = 0,
    this.addSet,
    this.deleteSet,
    required this.index,
    required this.rindex,
    this.updateDuration,
    this.fromJournal = false,
    this.assessment = true,
  }) : super(key: key);
  final WorkoutExercise _exercise;
  final VoidCallback? onimage, addSet;
  final bool edit, delete, fromJournal, assessment;
  final String? image;
  final int type, index, rindex;
  Function(int rindex, int eindex, int index)? deleteSet;
  Function(int current, int newval)? updateDuration;
  @override
  State<WExerciseWidget> createState() => _WExerciseWidgetState();
}

class _WExerciseWidgetState extends State<WExerciseWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: widget.delete ? width * 0.6 : width * 0.8,
              child: Column(
                children: [
                  TextFormField(
                    readOnly: !widget.edit,
                    initialValue: widget._exercise.name!,
                    decoration: inputDecoration(
                      hint: 'Exercise Name',
                      radius: 0,
                    ),
                    onChanged: (val) {
                      setState(() {
                        widget._exercise.name = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.1,
              child: InkWell(
                onTap: widget.onimage ?? () {},
                child: assetImage(widget.image ?? AppIcons.picture),
              ),
            ),
            if (widget.delete)
              IconTextButton(
                text: 'Sets',
                icon: Icons.add,
                onPressed: widget.addSet ?? () {},
              ).marginOnly(right: 5),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            widget._exercise.sets!.length,
            (sets) {
              final _set = widget._exercise.sets![sets];
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(text: '${_set.index! + 1}').marginOnly(
                      left: widget.delete ? width * 0.01 : width * 0.02,
                      right: 5,
                    ),
                    SizedBox(
                      width: width * 0.1,
                      child: TextFormField(
                        initialValue: _set.reps!.value!.toString(),
                        decoration: inputDecoration(hint: '1', radius: 2),
                        onChanged: !widget.edit
                            ? null
                            : (val) {
                                setState(() {
                                  _set.reps!.value = int.parse(val);
                                });
                              },
                      ),
                    ),
                    CustomDropDownStruct(
                      child: DropdownButton(
                        value: _set.reps!.type,
                        onChanged: !widget.edit
                            ? null
                            : (val) {
                                setState(() {
                                  _set.reps!.type = val;
                                });
                              },
                        items: workoutRepsList
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.value,
                                child: SizedBox(
                                  width: width * 0.15,
                                  child: TextWidget(
                                    text: e.title.split(' ').first,
                                    alignment: Alignment.centerLeft,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    if (widget.fromJournal == false)
                      SizedBox(
                        width: widget.delete ? width * 0.05 : width * 0.03,
                      ),
                    SizedBox(
                      width: width * 0.1,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: _set.duration!.value!.toString(),
                        decoration: inputDecoration(hint: '1'),
                        maxLines: 1,
                        onChanged: !widget.edit
                            ? null
                            : (val) {
                                setState(() {
                                  int value = int.parse(val);
                                  if (_set.duration!.type == 1) {
                                    widget.updateDuration!(
                                      _set.duration!.value!,
                                      value,
                                    );
                                  } else if (_set.duration!.type == 4) {
                                    widget.updateDuration!(
                                      _set.duration!.value! * 60,
                                      value * 60,
                                    );
                                  }
                                  _set.duration!.value = value;
                                });
                              },
                      ),
                    ),
                    CustomDropDownStruct(
                      child: DropdownButton(
                        value: _set.duration!.type,
                        onChanged: !widget.edit
                            ? null
                            : (val) {
                                setState(() {
                                  if (_set.duration!.type == 1 && val == 4) {
                                    widget.updateDuration!(
                                      _set.duration!.value!,
                                      _set.duration!.value! * 60,
                                    );
                                  } else if (_set.duration!.type == 4 &&
                                      val == 1) {
                                    widget.updateDuration!(
                                      _set.duration!.value! * 60,
                                      _set.duration!.value!,
                                    );
                                  }
                                  _set.duration!.type = val;
                                });
                              },
                        items: workoutDurationList
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.value,
                                child: SizedBox(
                                  width: width * 0.15,
                                  child: TextWidget(
                                    text: e.title.split(' ').first,
                                    alignment: Alignment.centerLeft,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    if (widget.fromJournal || widget.assessment)
                      SizedBox(
                        width: width * 0.1,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: _set.rest!.value!.toString(),
                          decoration: inputDecoration(hint: '1'),
                          maxLines: 1,
                          onChanged: !widget.edit
                              ? null
                              : (val) {
                                  setState(() {
                                    int value = int.parse(val);
                                    _set.rest!.value = value;
                                  });
                                },
                        ),
                      ),
                    if (widget.fromJournal || widget.assessment)
                      CustomDropDownStruct(
                        child: DropdownButton(
                          value: _set.rest!.type,
                          onChanged: !widget.edit
                              ? null
                              : (val) {
                                  setState(() {
                                    _set.rest!.type = val;
                                  });
                                },
                          items: restList
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e.value,
                                  child: SizedBox(
                                    width: width * 0.15,
                                    child: TextWidget(
                                      text: e.title.split(' ').first,
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    if (widget.delete)
                      InkWell(
                        child: const Icon(Icons.delete),
                        onTap: () {
                          widget.deleteSet!(widget.rindex, widget.index, sets);
                        },
                      ).marginOnly(left: 15),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
