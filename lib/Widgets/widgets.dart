// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../Constants/constants.dart';
import '../Functions/functions.dart';
import '../Model/app_modal.dart';
import '../Model/routine_model.dart';
import '../Theme/input_decoration.dart';
import '../app_icons.dart';
import 'checkboxes.dart';
import 'custom_images.dart';
import 'drop_down_button.dart';

import 'package:duration_picker/duration_picker.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    this.child,
    this.padding,
    this.margin,
    this.cwidth,
    this.cheight,
    this.background,
  }) : super(key: key);
  final Widget? child;
  final EdgeInsetsGeometry? padding, margin;
  final double? cwidth, cheight;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cwidth ?? width,
      height: cheight,
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: background,
        border: Border.all(),
      ),
      child: child,
    );
  }
}

class PersonalizedRoutineWidget extends StatefulWidget {
  const PersonalizedRoutineWidget(
    this._routine, {
    Key? key,
    this.deleteRoutine,
    this.startTime,
    required this.rearrange,
  }) : super(key: key);
  final Routines _routine;
  final VoidCallback? deleteRoutine, startTime;
  final bool rearrange;

  @override
  State<PersonalizedRoutineWidget> createState() =>
      _PersonalizedRoutineWidgetState();
}

class _PersonalizedRoutineWidgetState extends State<PersonalizedRoutineWidget> {
  selectBell(int value) {
    setState(() {
      widget._routine.alarm = value;
      print(widget._routine.alarm);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: width,
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              margin: const EdgeInsets.only(bottom: 0),
              decoration: BoxDecoration(
                border: Border.all(),
                color: Color(widget._routine.color!),
              ),
              child: Column(
                children: [
                  TextFormField(
                    textAlign: TextAlign.center,
                    initialValue: widget._routine.name!,
                    decoration: decoration(hint: 'Routine Name'),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Arial',
                    ),
                    onChanged: (val) {
                      setState(() {
                        widget._routine.name = val;
                      });
                    },
                  ).marginOnly(bottom: 5),
                  // TextWidget(
                  //   text: widget._routine.name!,
                  //   weight: FontWeight.bold,
                  //   size: 17,
                  //   alignment: Alignment.center,
                  // ).marginOnly(bottom: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PopupMenuButton(
                        onSelected: selectBell,
                        icon: assetImage(AppIcons.bell, width: 20),
                        itemBuilder: (context) {
                          return List.generate(
                            alarmSoundList.length,
                            (index) => PopupMenuItem(
                              value: alarmSoundList[index].value,
                              child: TextWidget(
                                text: alarmSoundList[index].title,
                              ),
                            ),
                          );
                        },
                      ),
                      InkWell(
                        onTap: widget.startTime ?? () {},
                        child: TextWidget(
                            text: '${widget._routine.starttime!} (Start time)'),
                      ),
                      assetImage(AppIcons.clock, width: 20),
                      TextWidget(
                        text: '${widget._routine.duration ?? ''} (Duration)',
                      ),
                    ],
                  ).marginOnly(left: 2, right: 2),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: widget.deleteRoutine ?? () {},
                icon: const Icon(Icons.delete),
              ),
            ),
          ],
        ),
        Container(
          height: 40,
          margin: const EdgeInsets.only(bottom: 15),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              widget._routine.days!.length,
              (index) => CustomCheckBox(
                width: 60,
                title: dayNames[index],
                value: widget._routine.days![index],
                onChanged: (val) {
                  setState(() {
                    widget._routine.days![index] = val!;
                  });
                },
              ),
            ),
          ),
        ),
        widget.rearrange
            ? ReorderableListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget._routine.elements!.length,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, indx) {
                  final RoutineElements element =
                      widget._routine.elements![indx];
                  return elementWidget(element, indx);
                },
                onReorder: (start, current) {
                  setState(() {
                    print('old $start');
                    print('new $current');
                    // These two lines are workarounds for ReorderableListView problems
                    if (current > widget._routine.elements!.length) {
                      current = widget._routine.elements!.length;
                    }
                    if (start < current) current--;
                    final item = widget._routine.elements![start];
                    widget._routine.elements!.remove(item);
                    widget._routine.elements!.insert(current, item);
                  });
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget._routine.elements!.length,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, indx) {
                  final RoutineElements element =
                      widget._routine.elements![indx];
                  return SizedBox(
                    key: UniqueKey(),
                    child: ElementWidget(
                      element,
                      manual: true,
                      delete: () {
                        setState(() {
                          widget._routine.seconds =
                              widget._routine.seconds! - element.seconds!;
                          widget._routine.duration =
                              getDurationString(widget._routine.seconds!);
                          widget._routine.elements!.removeAt(indx);
                        });
                      },
                      add: () {
                        setState(() {
                          element.seconds = element.seconds! + fiveMinutes();
                          element.duration =
                              getDurationString(element.seconds!);
                          widget._routine.seconds =
                              widget._routine.seconds! + fiveMinutes();
                          widget._routine.duration =
                              getDurationString(widget._routine.seconds!);
                        });
                      },
                      subtract: () {
                        setState(() {
                          if (element.seconds! >= fiveMinutes()) {
                            element.seconds = element.seconds! - fiveMinutes();
                            element.duration =
                                getDurationString(element.seconds!);
                            widget._routine.seconds =
                                widget._routine.seconds! - fiveMinutes();
                            widget._routine.duration =
                                getDurationString(widget._routine.seconds!);
                          } else {
                            print(element.seconds);
                          }
                        });
                      },
                      selectDuration: () async {
                        Duration? resultingDuration = await showDurationPicker(
                          context: context,
                          initialTime: Duration(seconds: element.seconds!),
                          baseUnit: BaseUnit.second,
                        );
                        print(resultingDuration!.inSeconds);
                        setState(() {
                          widget._routine.seconds =
                              widget._routine.seconds! - element.seconds!;
                          element.seconds = resultingDuration.inSeconds;
                          element.duration =
                              getDurationString(element.seconds!);
                          widget._routine.seconds =
                              widget._routine.seconds! + element.seconds!;
                          widget._routine.duration =
                              getDurationString(widget._routine.seconds!);
                        });
                      },
                    ),
                  );
                },
                // onReorder: (start, current) {
                //   if (start < current) {
                //     int end = current - 1;
                //     var startItem = widget._routine.elements![start];
                //     int i = 0;
                //     int local = start;
                //     do {
                //       widget._routine.elements![local] =
                //           widget._routine.elements![++local];
                //       i++;
                //     } while (i < end - start);
                //     widget._routine.elements![end] = startItem;
                //   } else if (start > current) {
                //     var startItem = widget._routine.elements![start];
                //     for (int i = start; i > current; i--) {
                //       widget._routine.elements![i] = widget._routine.elements![i - 1];
                //     }
                //     widget._routine.elements![current] = startItem;
                //   }
                //   setState(() {});
                // },
              ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: assetImage(AppIcons.add),
            onPressed: () {
              setState(() {
                widget._routine.elements!.add(addElements());
                // widget._routine.seconds =
                //     widget._routine.seconds! + fiveMinutes();
                // widget._routine.duration =
                //     getDurationString(widget._routine.seconds!);
              });
            },
          ),
        ),
      ],
    ).marginOnly(bottom: 20);
  }

  Widget elementWidget(RoutineElements element, int indx) {
    return SizedBox(
      key: UniqueKey(),
      child: ElementWidget(
        element,
        manual: true,
        delete: () {
          setState(() {
            widget._routine.seconds =
                widget._routine.seconds! - element.seconds!;
            widget._routine.duration =
                getDurationString(widget._routine.seconds!);
            widget._routine.elements!.removeAt(indx);
          });
        },
        add: () {
          setState(() {
            element.seconds = element.seconds! + fiveMinutes();
            element.duration = getDurationString(element.seconds!);
            widget._routine.seconds = widget._routine.seconds! + fiveMinutes();
            widget._routine.duration =
                getDurationString(widget._routine.seconds!);
          });
        },
        subtract: () {
          setState(() {
            if (element.seconds! >= fiveMinutes()) {
              element.seconds = element.seconds! - fiveMinutes();
              element.duration = getDurationString(element.seconds!);
              widget._routine.seconds =
                  widget._routine.seconds! - fiveMinutes();
              widget._routine.duration =
                  getDurationString(widget._routine.seconds!);
            } else {
              print(element.seconds);
            }
          });
        },
        selectDuration: () async {
          Duration? resultingDuration = await showDurationPicker(
            context: context,
            initialTime: Duration(seconds: element.seconds!),
            baseUnit: BaseUnit.second,
          );
          print(resultingDuration!.inSeconds);
          setState(() {
            widget._routine.seconds =
                widget._routine.seconds! - element.seconds!;
            element.seconds = resultingDuration.inSeconds;
            element.duration = getDurationString(element.seconds!);
            widget._routine.seconds =
                widget._routine.seconds! + element.seconds!;
            widget._routine.duration =
                getDurationString(widget._routine.seconds!);
          });
        },
      ),
    );
  }
}

class ManualRoutineWidget extends StatefulWidget {
  const ManualRoutineWidget(
    this._routine, {
    Key? key,
    this.selectStart,
    this.deleteRoutine,
    required this.rearrange,
  }) : super(key: key);
  final Routines _routine;
  final VoidCallback? selectStart, deleteRoutine;
  final bool rearrange;

  @override
  State<ManualRoutineWidget> createState() => _ManualRoutineWidgetState();
}

class _ManualRoutineWidgetState extends State<ManualRoutineWidget> {
  RxBool nudge = false.obs;

  selectBell(int value) {
    setState(() {
      widget._routine.alarm = value;
      print(widget._routine.alarm);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: width,
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              margin: const EdgeInsets.only(bottom: 0),
              decoration: BoxDecoration(
                border: Border.all(),
                color: Color(widget._routine.color!),
              ),
              child: Column(
                children: [
                  TextFormField(
                    textAlign: TextAlign.center,
                    initialValue: widget._routine.name!,
                    decoration: decoration(hint: 'Routine Name'),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Arial',
                    ),
                    onChanged: (val) {
                      setState(() {
                        widget._routine.name = val;
                      });
                    },
                  ).marginOnly(bottom: 5),
                  // TextWidget(
                  //   text: widget._routine.name!,
                  //   weight: FontWeight.bold,
                  //   size: 17,
                  //   alignment: Alignment.center,
                  // ).marginOnly(bottom: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PopupMenuButton(
                        onSelected: selectBell,
                        icon: assetImage(AppIcons.bell, width: 20),
                        itemBuilder: (context) {
                          return List.generate(
                            alarmSoundList.length,
                            (index) => PopupMenuItem(
                              value: alarmSoundList[index].value,
                              child: TextWidget(
                                text: alarmSoundList[index].title,
                              ),
                            ),
                          );
                        },
                      ),
                      InkWell(
                        onTap: widget.selectStart ?? () {},
                        child: TextWidget(
                          text: '${widget._routine.starttime == ''
                                  ? 'HH:MM'
                                  : widget._routine.starttime!} (Start time)',
                        ),
                      ),
                      assetImage(AppIcons.clock, width: 20),
                      TextWidget(
                        text: '${widget._routine.duration == ''
                                ? 'HH:MM:SS'
                                : widget._routine.duration!} (Duration)',
                      ),
                    ],
                  ).marginOnly(left: 2, right: 2),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: widget.deleteRoutine ?? () {},
                icon: const Icon(Icons.delete),
              ),
            ),
          ],
        ),
        Container(
          height: 40,
          margin: const EdgeInsets.only(bottom: 15),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              widget._routine.days!.length,
              (index) => CustomCheckBox(
                width: 60,
                title: dayNames[index],
                value: widget._routine.days![index],
                onChanged: (val) {
                  setState(() {
                    widget._routine.days![index] = val!;
                  });
                },
              ),
            ),
          ),
        ),
        CustomCheckBox(
          title: 'Nudges',
          value: nudge.value,
          onChanged: (val) {
            nudge.value = val;
            setState(() {});
          },
        ),
        if (nudge.value)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    assetImage(AppIcons.cue),
                    const TextWidget(text: 'Cue'),
                    SizedBox(
                      width: width * 0.65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomDropDownStruct(
                            child: DropdownButton(
                              value: widget._routine.nudges!.cue,
                              onChanged: (val) {
                                setState(() {
                                  widget._routine.nudges!.cue = val!;
                                });
                              },
                              items: cueList
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.value,
                                      child: TextWidget(
                                        text: e.title,
                                        alignment: Alignment.centerLeft,
                                        size: 11,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          if (widget._routine.nudges!.cue == 3)
                            SizedBox(
                              width: width * 0.61,
                              child: TextFormField(
                                decoration: inputDecoration(hint: 'Cue'),
                                onChanged: (val) {
                                  setState(() {
                                    widget._routine.nudges!.wcue = val;
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ).marginOnly(bottom: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    assetImage(AppIcons.chain),
                    const TextWidget(text: 'Chain'),
                    SizedBox(
                      width: width * 0.65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            // width: width * 0.83,
                            child: CustomDropDownStruct(
                              child: DropdownButton(
                                value: widget._routine.nudges!.chain,
                                onChanged: (val) {
                                  setState(() {
                                    widget._routine.nudges!.chain = val!;
                                  });
                                },
                                items: chainList
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.value,
                                        child: TextWidget(
                                          text: e.title,
                                          alignment: Alignment.centerLeft,
                                          size: 12,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                          if (widget._routine.nudges!.chain == 0)
                            SizedBox(
                              width: width * 0.61,
                              child: TextFormField(
                                decoration: inputDecoration(hint: 'Chain'),
                                onChanged: (val) {
                                  setState(() {
                                    widget._routine.nudges!.wchain = val;
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ).marginOnly(bottom: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    assetImage(AppIcons.reward),
                    const TextWidget(text: 'Reward'),
                    SizedBox(
                      width: width * 0.65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            // width: width * 0.83,
                            child: CustomDropDownStruct(
                              child: DropdownButton(
                                value: widget._routine.nudges!.reward,
                                onChanged: (val) {
                                  setState(() {
                                    widget._routine.nudges!.reward = val!;
                                  });
                                },
                                items: rewardList
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.value,
                                        child: TextWidget(
                                          text: e.title,
                                          alignment: Alignment.centerLeft,
                                          size: 12.4,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                          if (widget._routine.nudges!.reward == 8)
                            SizedBox(
                              width: width * 0.61,
                              child: TextFormField(
                                decoration: inputDecoration(hint: 'Reward'),
                                onChanged: (val) {
                                  setState(() {
                                    widget._routine.nudges!.wreward = val;
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ).marginOnly(bottom: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    assetImage(AppIcons.setup),
                    const TextWidget(text: 'Setup'),
                    SizedBox(
                      width: width * 0.65,
                      child: Column(
                        children: [
                          SizedBox(
                            width: width * 0.615,
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  widget._routine.nudges!.setup = val;
                                });
                              },
                              decoration: inputDecoration(
                                hint: 'Prepare clothes, files for work/ school',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).marginOnly(right: 5),
                  ],
                ),
              ],
            ),
          ), // Nudges
        widget.rearrange
            ? ReorderableListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: widget._routine.elements!.length,
                itemBuilder: (context, indx) {
                  final RoutineElements element =
                      widget._routine.elements![indx];
                  return SizedBox(
                    key: UniqueKey(),
                    child: ElementWidget(
                      element,
                      manual: true,
                      delete: () {
                        setState(() {
                          widget._routine.seconds =
                              widget._routine.seconds! - element.seconds!;
                          widget._routine.duration =
                              getDurationString(widget._routine.seconds!);
                          widget._routine.elements!.removeAt(indx);
                        });
                      },
                      add: () {
                        setState(() {
                          element.seconds = element.seconds! + fiveMinutes();
                          element.duration =
                              getDurationString(element.seconds!);
                          widget._routine.seconds =
                              widget._routine.seconds! + fiveMinutes();
                          widget._routine.duration =
                              getDurationString(widget._routine.seconds!);
                        });
                      },
                      subtract: () {
                        setState(() {
                          element.seconds = element.seconds! - fiveMinutes();
                          element.duration =
                              getDurationString(element.seconds!);
                          widget._routine.seconds =
                              widget._routine.seconds! - fiveMinutes();
                          widget._routine.duration =
                              getDurationString(widget._routine.seconds!);
                        });
                      },
                      selectDuration: () async {
                        Duration? resultingDuration = await showDurationPicker(
                          context: context,
                          initialTime: Duration(seconds: element.seconds!),
                          baseUnit: BaseUnit.second,
                        );
                        print(resultingDuration!.inSeconds);
                        setState(() {
                          widget._routine.seconds =
                              widget._routine.seconds! - element.seconds!;
                          element.seconds = resultingDuration.inSeconds;
                          element.duration =
                              getDurationString(element.seconds!);
                          widget._routine.seconds =
                              widget._routine.seconds! + element.seconds!;
                          widget._routine.duration =
                              getDurationString(widget._routine.seconds!);
                        });
                      },
                    ),
                  );
                },
                onReorder: (start, current) {
                  setState(() {
                    print('old $start');
                    print('new $current');
                    // These two lines are workarounds for ReorderableListView problems
                    if (current > widget._routine.elements!.length) {
                      current = widget._routine.elements!.length;
                    }
                    if (start < current) current--;
                    final item = widget._routine.elements![start];
                    widget._routine.elements!.remove(item);
                    widget._routine.elements!.insert(current, item);
                  });
                  // setState(() {});
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: widget._routine.elements!.length,
                itemBuilder: (context, indx) {
                  final RoutineElements element =
                      widget._routine.elements![indx];
                  return SizedBox(
                    key: UniqueKey(),
                    child: ElementWidget(
                      element,
                      manual: true,
                      delete: () {
                        setState(() {
                          widget._routine.seconds =
                              widget._routine.seconds! - element.seconds!;
                          widget._routine.duration =
                              getDurationString(widget._routine.seconds!);
                          widget._routine.elements!.removeAt(indx);
                        });
                      },
                      add: () {
                        setState(() {
                          element.seconds = element.seconds! + fiveMinutes();
                          element.duration =
                              getDurationString(element.seconds!);
                          widget._routine.seconds =
                              widget._routine.seconds! + fiveMinutes();
                          widget._routine.duration =
                              getDurationString(widget._routine.seconds!);
                        });
                      },
                      subtract: () {
                        setState(() {
                          element.seconds = element.seconds! - fiveMinutes();
                          element.duration =
                              getDurationString(element.seconds!);
                          widget._routine.seconds =
                              widget._routine.seconds! - fiveMinutes();
                          widget._routine.duration =
                              getDurationString(widget._routine.seconds!);
                        });
                      },
                      selectDuration: () async {
                        Duration? resultingDuration = await showDurationPicker(
                          context: context,
                          initialTime: Duration(seconds: element.seconds!),
                          baseUnit: BaseUnit.second,
                        );
                        print(resultingDuration!.inSeconds);
                        setState(() {
                          widget._routine.seconds =
                              widget._routine.seconds! - element.seconds!;
                          element.seconds = resultingDuration.inSeconds;
                          element.duration =
                              getDurationString(element.seconds!);
                          widget._routine.seconds =
                              widget._routine.seconds! + element.seconds!;
                          widget._routine.duration =
                              getDurationString(widget._routine.seconds!);
                        });
                      },
                    ),
                  );
                },
                // onReorder: (start, current) {
                // setState(() {
                //   print('old $start');
                //   print('new $current');
                //   // These two lines are workarounds for ReorderableListView problems
                //   // if (current > widget._routine.elements!.length)
                //   //   current = widget._routine.elements!.length;
                //   // if (start < current) current--;
                //   // final item = widget._routine.elements![start];
                //   // widget._routine.elements!.remove(item);
                //   // widget._routine.elements!.insert(current, item);
                // });
                // setState(() {});
                // },
              ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: assetImage(AppIcons.add),
            onPressed: () {
              setState(() {
                widget._routine.elements!.add(addElements());
              });
            },
          ),
        ),
      ],
    ).marginOnly(bottom: 20);
  }
}

class ElementWidget extends StatefulWidget {
  const ElementWidget(
    this.element, {
    Key? key,
    this.add,
    this.delete,
    this.subtract,
    this.selectDuration,
    required this.manual,
  }) : super(key: key);
  final RoutineElements element;
  final VoidCallback? add, subtract, delete, selectDuration;
  final bool manual;

  @override
  State<ElementWidget> createState() => _ElementWidgetState();
}

class _ElementWidgetState extends State<ElementWidget> {
  RxBool benefit = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                // const Icon(Icons.reorder).marginOnly(right: 10),
                CustomDropDownStruct(
                  child: DropdownButton(
                    value: widget.element.category,
                    onChanged: (val) {
                      setState(() {
                        widget.element.category = val!;
                      });
                    },
                    items: categoryList
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.value,
                            child: TextWidget(
                              text: e.title,
                              alignment: Alignment.centerLeft,
                              size: 12,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                if (widget.manual)
                  IconButton(
                    onPressed: widget.add ?? () {},
                    icon: assetImage(AppIcons.add),
                  ),
                IconButton(
                  onPressed: widget.subtract ?? () {},
                  icon: assetImage(AppIcons.subtract),
                ),
                IconButton(
                  onPressed: widget.delete ?? () {},
                  icon: const Icon(Icons.delete),
                ),
              ],
            ).marginOnly(bottom: 5),
          ),
          Row(
            children: [
              horizontalSpace(width: 31),
              InkWell(
                onTap: widget.selectDuration ?? () {},
                child: SizedBox(
                  width: width * 0.6,
                  child: TextWidget(
                    text: '${widget.element.duration == '' ||
                                widget.element.duration == null
                            ? 'HH:MM:SS'
                            : widget.element.duration!} (Duration)',
                    size: 16,
                  ),
                ),
              ).marginOnly(right: 20),
              const TextWidget(text: '+/-', size: 12),
            ],
          ).marginOnly(bottom: 15),
          TextWidget(
            text: categoryList[categoryIndex(widget.element.category!)]
                .description,
            textAlign: TextAlign.center,
            alignment: Alignment.center,
            fontStyle: FontStyle.italic,
            weight: FontWeight.bold,
          ),
          CustomCheckBox(
            value: benefit.value,
            onChanged: (val) {
              benefit.value = val;
              setState(() {});
            },
            title: 'Benefits',
          ),
          if (benefit.value)
            Column(
              children: [
                if (selectBenefits(widget.element.category!)
                    .where((element) => element.type == 0)
                    .toList()
                    .isNotEmpty)
                  SizedBox(
                    height: selectBenefits(widget.element.category!)
                                .where((element) => element.type == 0)
                                .toList()
                                .length <=
                            4
                        ? height * 0.2
                        : selectBenefits(widget.element.category!)
                                    .where((element) => element.type == 0)
                                    .toList()
                                    .length <=
                                8
                            ? height * 0.31
                            : height * 0.5,
                    child: GridView.builder(
                      shrinkWrap: false,
                      physics: const BouncingScrollPhysics(),
                      itemCount: selectBenefits(widget.element.category!)
                          .where((element) => element.type == 0)
                          .toList()
                          .length,
                      gridDelegate: gridStyle(),
                      itemBuilder: (context, index) {
                        final AppModel _model =
                            selectBenefits(widget.element.category!)
                                .where((element) => element.type == 0)
                                .toList()[index];
                        return Stack(
                          children: [
                            Column(
                              children: [
                                CustomImageWidget(
                                    image: _model.title, width: 60),
                                TextWidget(
                                  text: _model.description,
                                  size: 15,
                                  weight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  alignment: Alignment.center,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            const RotatedBox(
                              quarterTurns: 2,
                              child: CustomImageWidget(
                                image: AppIcons.arrow,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                if (selectBenefits(widget.element.category!)
                    .where((element) => element.type == 1)
                    .toList()
                    .isNotEmpty)
                  SizedBox(
                    height: selectBenefits(widget.element.category!)
                                .where((element) => element.type == 1)
                                .toList()
                                .length <=
                            4
                        ? height * 0.2
                        : selectBenefits(widget.element.category!)
                                    .where((element) => element.type == 1)
                                    .toList()
                                    .length <=
                                8
                            ? height * 0.3
                            : height * 0.4,
                    child: GridView.builder(
                      shrinkWrap: false,
                      physics: const BouncingScrollPhysics(),
                      itemCount: selectBenefits(widget.element.category!)
                          .where((element) => element.type == 1)
                          .toList()
                          .length,
                      gridDelegate: gridStyle(),
                      itemBuilder: (context, index) {
                        final AppModel _model =
                            selectBenefits(widget.element.category!)
                                .where((element) => element.type == 1)
                                .toList()[index];
                        return Stack(
                          children: [
                            Column(
                              children: [
                                CustomImageWidget(
                                    image: _model.title, width: 60),
                                TextWidget(
                                  text: _model.description,
                                  size: 15,
                                  weight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  alignment: Alignment.center,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            const CustomImageWidget(
                                image: AppIcons.arrow, color: Colors.red),
                          ],
                        );
                      },
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  gridStyle() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      childAspectRatio: 0.65,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
    );
  }
}
