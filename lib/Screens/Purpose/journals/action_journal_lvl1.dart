// ignore_for_file: avoid_print, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wakelock/wakelock.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Functions/time_picker.dart';
import 'package:schedular_project/Screens/seek_bar.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/buttons_theme.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/checkboxes.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/drop_down_button.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../../Constants/colors.dart';
import '../../../Global/firebase_collections.dart';
import '../../../Model/action_model.dart';
import '../../../Model/app_modal.dart';
import '../../../Model/app_user.dart';
import '../../../Model/bd_models.dart';
import '../../../Widgets/loading_dialog.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../Widgets/stop_watch.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';
import '../bd_home.dart';

class ActionJournalLvl1 extends StatefulWidget {
  const ActionJournalLvl1({Key? key}) : super(key: key);

  @override
  _ActionJournalLvl1State createState() => _ActionJournalLvl1State();
}

class _ActionJournalLvl1State extends State<ActionJournalLvl1> {
  final _key = GlobalKey<FormState>();
  bool actual = false;
  bool scheduled = true;
  TextEditingController name = TextEditingController();
  TextEditingController estart = TextEditingController();
  TextEditingController eEnd = TextEditingController();

  TextEditingController acurrent = TextEditingController();

  List<TextEditingController> event = <TextEditingController>[];
  List<AppModel> category = <AppModel>[];
  RxInt indx = 0.obs;
  RxList<int> indexes = <int>[].obs;
  RxList<TextEditingController> controller = <TextEditingController>[].obs;
  RxList<bool> played = <bool>[].obs;

  void addActionEvent() {
    indexes.add(0);
    played.add(false);
    controller.add(TextEditingController(text: ('').toString()));
    TextEditingController _event = TextEditingController();
    event.add(_event);
    category.add(AppModel('Select Category', '', value: -1, type: 0));
    scheduledEvents.add(
      AEventModel(
        index: 0,
        description: '',
        category: -1,
        catid: '',
        completed: false,
        previous: false,
        previousid: '',
        played: false,
        scheduled: EventDuration(
          date: currentDate.text,
          duration: 0,
          start: 'HH:MM',
          end: 'HH:MM',
        ),
      ),
    );
  }

  void deleteActionEvent(int index) {
    Get.defaultDialog(
      title: 'Delete Task',
      middleText:
          'Are you sure you want to delete this task? This action is permanent.',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: AppColors.white,
      titlePadding: const EdgeInsets.only(top: 10, bottom: 10),
      barrierDismissible: false,
      onConfirm: () async {
        if (scheduledEvents[index].previous == true) {
          await actionRef.doc(scheduledEvents[index].previousid).update({
            'events': FieldValue.arrayRemove([scheduledEvents[index].toMap()])
          });
        }
        indexes.removeAt(index);
        controller.removeAt(index);
        event.removeAt(index);
        category.removeAt(index);
        played.removeAt(index);
        scheduledEvents.removeAt(index);
        Get.back();
      },
    );
  }

  void addEvents() {
    for (int i = 0; i < 3; i++) {
      print(indx.value);
      addActionEvent();
      indx.value = indx.value + 1;
    }
  }

  TextEditingController currentDate = TextEditingController();

  @override
  void initState() {
    setState(() {
      fetchIdealTime();
      // addEvents();
      currentDate.text = formateDate(DateTime.now());
      name.text =
          'ActionJournalLevel1TacticalAccounting${formatTitelDate(DateTime.now()).trim()}';
      // if (edit) fetchData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(
          leading: backButton(
            () => play.value == 0 ? Get.back() : play.value = 0,
          ),
          implyLeading: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _key,
            child: Column(
              children: [
                verticalSpace(height: 10),
                ExerciseTitle(
                  title:
                      'Action Journal Level 1 - Tactical Accounting (Practice)',
                  onPressed: () => Get.to(
                    () => ReadingScreen(
                      title: 'Ideal Time Use',
                      link:
                          'https://docs.google.com/document/d/1zzGpY1ejo4qzuTphvlhnowj_Kgj7J34t/',
                      linked: () => Get.back(),
                      function: () {
                        if (Get.find<BdController>().history.value.value ==
                            123) {
                          final end = DateTime.now();
                          Get.find<BdController>()
                              .updateHistory(end.difference(initial).inSeconds);
                        }
                        Get.log('closed');
                      },
                    ),
                  ),
                  // () => Get.to(() => const IdealTImeUseReading()),
                ),
                verticalSpace(height: 10),
                JournalTop(
                  controller: name,
                  add: () => {clearData(), addEvents()},
                  save: () async =>
                      edit ? await updateJournal(true) : await addJournal(true),
                  drive: () => Get.off(() => const PreviousJournal()),
                ),
                verticalSpace(height: 15),

                ///
                play.value == 0
                    ? page1()
                    : play.value == 1
                        ? page2(currentEvent.value)
                        : Container(),
                if (play.value == 0) rightnowWidget(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: play.value != 0
            ? const SizedBox.shrink()
            : BottomButtons(
                button1: 'Done',
                button2: 'Save',
                onPressed2: () async => await addJournal(true),
                onPressed1: () async =>
                    edit ? await updateJournal() : await addJournal(),
              ),
      ),
    );
  }

  rightnowWidget() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: TextWidget(text: 'How are you spending your time right now?'),
        ),
        Container(
          padding:
              const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
          margin: const EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(border: Border.all()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 0.35,
                    child: TextFormField(
                      controller: rdesc,
                      decoration: decoration(hint: 'Event Description'),
                    ),
                  ),
                  CustomDropDownStruct(
                    // height: 40,
                    child: DropdownButton<int>(
                      value: rightNowCategory.value.type,
                      onChanged: (value) {
                        setState(() {
                          rightNowCategory.value = idealTimeList[idealTimeList
                              .indexWhere((val) => val.type == value)];
                        });
                      },
                      items: idealTimeList
                          .map((e) => DropdownMenuItem(
                                value: e.type,
                                child: SizedBox(
                                  width: width * 0.25,
                                  child: TextWidget(
                                    text: e.title,
                                    alignment: Alignment.centerLeft,
                                    maxline: 2,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    // margin: const EdgeInsets.only(top: 10),
                    width: width * 0.2,
                    child: Tooltip(
                      message: 'Start Time',
                      child: TextFormField(
                        controller: rstart,
                        readOnly: true,
                        onTap: () {
                          customTimePicker(
                            context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            rstart.text = value.format(context);
                          });
                        },
                        decoration: decoration(hint: 'HH:MM'),
                      ),
                    ),
                  ),
                  // const TextWidget(text: '-'),
                  SizedBox(
                    // margin: const EdgeInsets.only(top: 10),
                    width: width * 0.2,
                    child: Tooltip(
                      message: 'End Time',
                      child: TextFormField(
                        controller: rend,
                        readOnly: true,
                        onTap: () {
                          customTimePicker(
                            context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            rend.text = value.format(context);
                            rduration.value =
                                calculateDuration(rstart.text, value);
                            setState(() {});
                          });
                        },
                        decoration: decoration(hint: 'HH:MM'),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (rduration.value == 0) {
                        customToast(message: 'Please select a duration');
                      } else {
                        bool check = await Wakelock.enabled;
                        if (!check) await Wakelock.enable();
                        rightnowDialog();
                      }
                    },
                    icon: const Icon(Icons.play_arrow, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ).marginOnly(top: height * 0.05);
  }

  Rx<AppModel> rightNowCategory =
      AppModel('Select Category', '', value: -1, type: 0).obs;
  TextEditingController rstart = TextEditingController();
  TextEditingController rend = TextEditingController();
  RxInt rduration = 0.obs;
  TextEditingController rdesc = TextEditingController();

  DateTime pstart = DateTime.now();
  RxString pstatus = ''.obs;
  AudioPlayer player = AudioPlayer();
  Widget page2(int index) {
    return Column(
      children: [
        verticalSpace(height: 30),
        TextWidget(
          text: event[index].text.isEmpty
              ? 'Event Description'
              : event[index].text.capitalize!,
          weight: FontWeight.bold,
          size: 17,
          alignment: Alignment.center,
        ).marginOnly(bottom: 15),
        CustomCountdown(
          caption: 'Action',
          controller: _countDownController,
          duration: scheduledEvents[index].scheduled!.duration ?? 0,
          onStart: () => {
            startCountdown.value = true,
            pstart = DateTime.now(),
            pstatus.value = 'play',
            debugPrint(pstart.toString()),
            setState(() {})
          },
          onComplete: () {
            final _end = DateTime.now();
            if (pstatus.value != 'reset') {
              playAlarm(player);
              pstatus.value = 'complete';
              startCountdown.value = false;
              // completed[index] = true;
              played[index] = true;
              final _event = AEventModel(
                completed: true,
                played: true,
                index: indexes[index],
                description: event[index].text,
                category: category[index].value,
                catid: category[index].description,
                previous: scheduledEvents[index].previous,
                previousid: scheduledEvents[index].previousid,
                jindex: scheduledEvents[index].jindex ?? 0,
                eventindex: scheduledEvents[index].previous!
                    ? previous
                            .where((p0) =>
                                p0.id == scheduledEvents[index].previousid)
                            .length +
                        1
                    : 0,
                actual: EventDuration(
                  date: currentDate.text,
                  duration: _end.difference(pstart).inSeconds,
                  start: TimeOfDay.fromDateTime(pstart).format(context),
                  end: TimeOfDay.fromDateTime(_end).format(context),
                ),
              );
              addActual(index, _event);
              actualEvents.add(_event);
            }
          },
        ),
        CustomBottom(
          start: pstatus.value == 'play'
              ? 'Pause'
              : pstatus.value == 'pause'
                  ? 'Resume'
                  : 'Take Action Now!',
          player: player,
          onVolumeChanged: (val) {
            setState(() {
              player.setVolume(val);
            });
          },
          onstart: () async {
            debugPrint(_countDownController.getTime());
            bool check = await Wakelock.enabled;
            if (!check) await Wakelock.enable();
            if (!startCountdown.value && pstatus.value == '') {
              _countDownController.restart();
              pstatus.value = 'play';
            } else if (pstatus.value == 'play') {
              _countDownController.pause();
              pstatus.value = 'pause';
            } else if (pstatus.value == 'pause') {
              _countDownController.resume();
              pstatus.value = 'play';
            } else {
              _countDownController.restart();
              pstatus.value = 'play';
            }
          },
          onfinished: () async {
            debugPrint(_countDownController.getTime());
            if (startCountdown.value && pstatus.value != 'complete') {
              final _end = DateTime.now();
              final _event = AEventModel(
                completed: true,
                played: true,
                index: indexes[index],
                description: event[index].text,
                category: category[index].value,
                catid: category[index].description,
                previous: scheduledEvents[index].previous,
                previousid: scheduledEvents[index].previousid,
                jindex: scheduledEvents[index].jindex ?? 0,
                eventindex: scheduledEvents[index].previous!
                    ? previous
                            .where((p0) =>
                                p0.id == scheduledEvents[index].previousid)
                            .length +
                        1
                    : 0,
                actual: EventDuration(
                  date: currentDate.text,
                  duration: _end.difference(pstart).inSeconds,
                  start: TimeOfDay.fromDateTime(pstart).format(context),
                  end: TimeOfDay.fromDateTime(_end).format(context),
                ),
              );
              addActual(index, _event);
              actualEvents.add(_event);
            } else if (startCountdown.value) {
              pstatus.value = 'reset';
              _countDownController.reset();
            }
            startCountdown.value = false;
            pstatus.value = '';
            // completed[index] = true;
            bool check = await Wakelock.enabled;
            if (check) await Wakelock.disable();
            setState(() {});
            updatePlay(0);
          },
        ),
      ],
    );
  }

  addActual(int index, AEventModel _event) {
    setState(() {
      if (scheduledEvents[index].previous!) {
        previous[scheduledEvents[index].jindex!].actual!.add(_event);
        actionRef
            .doc(scheduledEvents[index].previousid!)
            .update(previous[scheduledEvents[index].jindex!].toMap());
      }
    });
  }

  Widget page1() {
    return Column(
      children: [
        TextFormField(
          readOnly: true,
          controller: currentDate,
          onTap: () {
            customDatePicker(context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100))
                .then((value) {
              setState(() {
                currentDate.text = formateDate(value);
              });
            });
          },
          decoration: decoration(),
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text: 'When was I most productive and energetic today?',
          fontStyle: FontStyle.italic,
        ),
        verticalSpace(height: 5),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: SizedBox(
                width: width * 0.35,
                child: Tooltip(
                  message: 'Start Time',
                  child: TextFormField(
                    controller: estart,
                    readOnly: true,
                    onTap: () {
                      customTimePicker(
                        context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        estart.text = value.format(context);
                      });
                    },
                    decoration: decoration(hint: 'HH:MM'),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.35,
              child: Tooltip(
                message: 'End Time',
                child: TextFormField(
                  controller: eEnd,
                  readOnly: true,
                  onTap: () {
                    customTimePicker(
                      context,
                      initialTime: TimeOfDay.now(),
                    ).then((value) {
                      eEnd.text = value.format(context);
                    });
                  },
                  decoration: decoration(hint: ' HH:MM'),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            CustomCheckBox(
              value: scheduled,
              onChanged: (value) {
                setState(() {
                  scheduled = value;
                  if (scheduled) {
                    actual = false;
                  } else {
                    actual = true;
                  }
                });
              },
              title: 'Scheduled',
              textAlignment: Alignment.centerLeft,
            ),
            CustomCheckBox(
              value: actual,
              onChanged: (value) {
                setState(() {
                  actual = value;
                  if (actual) {
                    scheduled = false;
                  } else {
                    scheduled = true;
                  }
                });
              },
              title: 'Actual',
              textAlignment: Alignment.centerLeft,
            ),
          ],
        ),
        if (scheduled)
          const TextWidget(
            text: 'Completed?',
            alignment: Alignment.centerRight,
          ).marginOnly(right: 30),
        Column(
          children: [
            if (scheduled)
              for (int i = 0; i < scheduledEvents.length; i++)
                scheduledWidget(i),
            if (actual)
              for (int i = 0; i < actualEvents.length; i++) actualWidget(i),
          ],
        ),
        if (scheduled)
          TextButton(
            onPressed: () {
              if (indx.value != 0) {
                indx.value = indx.value + 1;
              }
              addActionEvent();
              setState(() {});
            },
            child: const TextWidget(text: 'Add Event...'),
          ),
      ],
    );
  }

  void rightnowDialog() {
    CountDownController _controller = CountDownController();
    RxString _status = ''.obs;
    Rx<DateTime> _start = DateTime.now().obs;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Obx(
          () => AlertDialog(
            elevation: 5.0,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: width,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: CustomCountdown(
                    controller: _controller,
                    duration: rduration.value,
                    caption: rightNowCategory.value.title,
                    onStart: () {
                      _start.value = DateTime.now();
                      _status.value = 'play';
                    },
                    onComplete: () async {
                      playAlarm(player);
                      _status.value = 'completed';
                      final _end = DateTime.now();
                      final _pstart = DateTime(_end.year, _end.month, _end.day,
                          _start.value.hour, _start.value.minute);
                      actualEvents.add(
                        AEventModel(
                          played: true,
                          index: actualEvents.length,
                          category: rightNowCategory.value.value,
                          catid: rightNowCategory.value.description,
                          completed: true,
                          previous: false,
                          description: rdesc.text,
                          actual: EventDuration(
                            date: currentDate.text,
                            end: TimeOfDay.fromDateTime(_end).format(context),
                            start: TimeOfDay.fromDateTime(_start.value)
                                .format(context),
                            duration: _end.difference(_pstart).inSeconds,
                          ),
                        ),
                      );
                      Get.back();
                      bool check = await Wakelock.enabled;
                      if (check) await Wakelock.disable();
                      setState(() {});
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_status.value == '') {
                      _controller.start();
                      _status.value = 'play';
                    } else if (_status.value == 'play') {
                      _controller.pause();
                      _status.value = 'pause';
                    } else if (_status.value == 'pause') {
                      _controller.resume();
                      _status.value = 'play';
                    } else {
                      _controller.restart();
                      _status.value = 'play';
                    }
                  },
                  style: elevatedButton(),
                  child: TextWidget(
                    text: _status.value == 'play'
                        ? 'Pause'
                        : _status.value == 'pause'
                            ? 'Resume'
                            : 'Play',
                    color: Colors.white,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            title: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.cancel_outlined),
                onPressed: () => Get.back(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget scheduledWidget(int index) {
    return scheduledEvents[index].completed!
        ? const SizedBox.shrink()
        : SizedBox(
            height: 80,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
                // const Icon(Icons.reorder, color: Colors.black54),
                Container(
                  width: width * 0.1,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller[index],
                    decoration: inputDecoration(hint: '0'),
                    onChanged: (val) {
                      setState(() {
                        int _val = int.parse(val);
                        scheduledEvents[index].index = _val;
                        indexes[index] = _val;
                        updateOrder(index);
                      });
                    },
                  ),
                ),
                Container(
                  width: width * 0.35,
                  margin: const EdgeInsets.only(top: 10, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width * 0.35,
                        child: TextFormField(
                          controller: event[index],
                          decoration: decoration(hint: 'Event Description'),
                          onChanged: (val) {
                            setState(() {
                              scheduledEvents[index].description = val;
                            });
                          },
                        ),
                      ),
                      CustomDropDownStruct(
                        // height: 40,
                        child: DropdownButton<int>(
                          value: category[index].type,
                          onChanged: (val) {
                            setState(() {
                              category[index] =
                                  idealTimeList[idealTimeIndex(val!)];
                              scheduledEvents[index].catid =
                                  category[index].description;
                              scheduledEvents[index].category =
                                  category[index].value;
                            });
                          },
                          items: idealTimeList
                              .map((e) => DropdownMenuItem(
                                    value: e.type,
                                    child: SizedBox(
                                      width: width * 0.25,
                                      child: TextWidget(
                                        text: e.title,
                                        alignment: Alignment.centerLeft,
                                        maxline: 2,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width * 0.12,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 30),
                  child: InkWell(
                    child: TextWidget(
                      text: scheduledEvents[index].scheduled!.start ?? 'HH:MM',
                      alignment: Alignment.center,
                    ),
                    onTap: () {
                      customTimePicker(
                        context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        scheduledEvents[index].scheduled!.start =
                            value.format(context);
                        setState(() {});
                      });
                    },
                  ),
                ),
                const TextWidget(text: '-', alignment: Alignment.center)
                    .marginOnly(top: 30),
                Container(
                  alignment: Alignment.center,
                  width: width * 0.12,
                  margin: const EdgeInsets.only(top: 30),
                  child: InkWell(
                    child: TextWidget(
                      text: scheduledEvents[index].scheduled!.end ?? 'HH:MM',
                      alignment: Alignment.center,
                    ),
                    onTap: () {
                      customTimePicker(
                        context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        scheduledEvents[index].scheduled!.end =
                            value.format(context);
                        scheduledEvents[index].scheduled!.duration =
                            calculateDuration(
                          scheduledEvents[index].scheduled!.start!,
                          value,
                        );
                        setState(() {});
                      });
                    },
                  ),
                ),
                Tooltip(
                  message: 'Completed',
                  child: Checkbox(
                    value: scheduledEvents[index].completed,
                    onChanged: (value) {
                      setState(() {
                        scheduledEvents[index].completed = value!;
                        if (scheduledEvents[index].previous!) {
                          previous[scheduledEvents[index].jindex!]
                                  .events![scheduledEvents[index].eventindex!] =
                              scheduledEvents[index];
                          actionRef
                              .doc(scheduledEvents[index].previousid)
                              .update(previous[scheduledEvents[index].jindex!]
                                  .toMap());
                        }
                        // if (!played[index]) {
                        final _event = AEventModel(
                          completed: true,
                          played: false,
                          index: indexes[index],
                          intcatype: category[index].type,
                          description: event[index].text,
                          category: scheduledEvents[index].category,
                          catid: scheduledEvents[index].catid,
                          actual: EventDuration(
                            start: TimeOfDay.now().format(context),
                            end: '',
                            date: currentDate.text,
                            duration:
                                scheduledEvents[index].scheduled!.duration,
                          ),
                          previous: scheduledEvents[index].previous,
                          previousid: scheduledEvents[index].previousid,
                          eventindex: scheduledEvents[index].previous!
                              ? scheduledEvents
                                      .where((element) =>
                                          element.previous! &&
                                          element.previousid != '')
                                      .toList()
                                      .length +
                                  1
                              : index,
                          jindex: scheduledEvents[index].previous!
                              ? scheduledEvents[index].jindex!
                              : 0,
                        );
                        addActual(index, _event);
                        actualEvents.add(_event);
                        // }
                      });
                    },
                  ),
                ).marginOnly(top: 30),
                IconButton(
                  onPressed: () {
                    if (scheduledEvents[index].scheduled!.duration == 0) {
                      // customToast(message: 'Please select a duration first');
                      setState(() {
                        scheduledEvents[index].scheduled!.start =
                            TimeOfDay.now().format(context);
                      });
                      stopwatchDialog(index);
                    } else {
                      played[index] = true;
                      setCurrentEvent(index);
                      updatePlay(1);
                    }
                  },
                  icon: const Icon(Icons.play_arrow, color: Colors.black),
                  tooltip: 'Play',
                ).marginOnly(top: 30),
                IconButton(
                  onPressed: () {
                    setState(() {
                      deleteActionEvent(index);
                    });
                  },
                  icon: const Icon(Icons.delete),
                ).marginOnly(top: 30),
              ],
            ),
          );
  }

  stopwatchDialog(int index) {
    Stopwatch _watch = Stopwatch();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5.0,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                child: StopWatch(
                  text: scheduledEvents[index].description ?? '',
                  stopwatch: _watch..start(),
                ),
              ).marginOnly(bottom: 30),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _watch.stop();
                    scheduledEvents[index].scheduled!.end =
                        TimeOfDay.now().format(context);
                    scheduledEvents[index].scheduled!.duration =
                        Duration(milliseconds: _watch.elapsedMilliseconds)
                            .inSeconds;
                    played[index] = true;
                    final _event = AEventModel(
                      played: true,
                      completed: true,
                      description: scheduledEvents[index].description,
                      index: indexes[index],
                      category: category[index].value,
                      catid: category[index].description,
                      previous: scheduledEvents[index].previous,
                      previousid: scheduledEvents[index].previousid,
                      eventindex: scheduledEvents[index].previous!
                          ? scheduledEvents
                                  .where((element) =>
                                      element.previous! &&
                                      element.previousid != '')
                                  .toList()
                                  .length +
                              1
                          : index,
                      jindex: scheduledEvents[index].previous!
                          ? scheduledEvents[index].jindex!
                          : 0,
                      actual: EventDuration(
                        date: currentDate.text,
                        duration: scheduledEvents[index].scheduled!.duration,
                        end: scheduledEvents[index].scheduled!.end,
                        start: scheduledEvents[index].scheduled!.start,
                      ),
                    );
                    addActual(index, _event);
                    actualEvents.add(_event);
                  });
                  bool check = await Wakelock.enabled;
                  if (check) await Wakelock.disable();
                  setState(() {});
                  Get.back();
                },
                style: elevatedButton(),
                child: const TextWidget(
                  text: 'Stop',
                  color: Colors.white,
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          title: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.cancel_outlined),
              onPressed: () => Get.back(),
            ),
          ),
        );
      },
    );
  }

  updateOrder(int index) {
    for (int k = 0; k < indexes.length - 1; k++) {
      for (int i = 0; i < indexes.length - k - 1; i++) {
        if (indexes[i] > indexes[i + 1]) {
          TextEditingController _event = event[i];
          event[i] = event[i + 1];
          event[i + 1] = _event;

          int _indexes = indexes[i];
          indexes[i] = indexes[i + 1];
          indexes[i + 1] = _indexes;
          TextEditingController _controller = controller[i];
          controller[i] = controller[i + 1];
          controller[i + 1] = _controller;
          final _category = category[i];
          category[i] = category[i + 1];
          category[i + 1] = _category;
          final _scheduled = scheduledEvents[i];
          scheduledEvents[i] = scheduledEvents[i + 1];
          scheduledEvents[i + 1] = _scheduled;
          final _played = played[i];
          played[i] = played[i + 1];
          played[i + 1] = _played;
          // swapped = 1;
        }
        // if (swapped == 1) break;
      }
    }
    setState(() {});
  }

  Widget actualWidget(int index) {
    return SizedBox(
      height: 80,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          // horizontalSpace(width: 50),
          Container(
            width: width * 0.35,
            margin: const EdgeInsets.only(top: 10, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.35,
                  child: TextWidget(
                    text: actualEvents[index].description!,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                CustomDropDownStruct(
                  child: DropdownButton<int>(
                    onChanged: null,
                    // value: actualEvents[index].intcatype,
                    value: idealTimeType(
                      actualEvents[index].category ?? -1,
                      actualEvents[index].catid ?? '',
                    ),
                    items: idealTimeList
                        .map((e) => DropdownMenuItem(
                              value: e.type,
                              child: SizedBox(
                                width: width * 0.25,
                                child: TextWidget(
                                  text: e.title,
                                  alignment: Alignment.centerLeft,
                                  maxline: 2,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          if (actualEvents[index].played == false)
            Container(
              width: width * 0.15,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10),
              child: const TextWidget(
                alignment: Alignment.center,
                text: 'Completed',
              ),
            ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: width * 0.15,
            alignment: Alignment.center,
            child: TextWidget(
              text: actualEvents[index].actual!.date ?? 'MM/dd/yy',
              alignment: Alignment.center,
            ),
          ),
          (actualEvents[index].played == true)
              ? Row(
                  children: [
                    if (actualEvents[index].actual!.start != '')
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: width * 0.15,
                          margin: const EdgeInsets.only(left: 5.0, top: 10),
                          child: Tooltip(
                            message: 'Start Time',
                            child: TextWidget(
                              text: actualEvents[index].actual!.start! == ''
                                  ? 'HH:MM'
                                  : actualEvents[index].actual!.start!,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    if (actualEvents[index].actual!.start != '')
                      const TextWidget(text: '-', alignment: Alignment.center)
                          .marginOnly(top: 10),
                    if (actualEvents[index].actual!.end != '')
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: width * 0.15,
                          child: Tooltip(
                            message: 'End Time',
                            child: TextWidget(
                              text: actualEvents[index].actual!.end! == ''
                                  ? 'HH:MM'
                                  : actualEvents[index].actual!.end!,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: width * 0.15,
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Tooltip(
                          message: 'Duration',
                          child: TextWidget(
                            text: actualEvents[index].actual!.duration == 0
                                ? 'HH:MM:SS'
                                : getDurationString(
                                    actualEvents[index].actual!.duration ?? 0),
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Container(
                      width: width * 0.15,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 10),
                      child: Tooltip(
                        message: 'Duration',
                        child: TextWidget(
                          alignment: Alignment.center,
                          text: actualEvents[index].actual!.start ?? 'HH:MM',
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  int calculateDuration(String start, TimeOfDay end) {
    final _today = DateTime.now();
    final _end =
        DateTime(_today.year, _today.month, _today.day, end.hour, end.minute);
    final _time = getTimeFromString(start);
    print(_time);
    final _start = DateTime(
        _today.year, _today.month, _today.day, _time.hour, _time.minute);
    return _end.difference(_start).inSeconds.abs();
  }

  RxList<AppModel> idealTimeList =
      <AppModel>[AppModel('Select Category', '', value: -1, type: 0)].obs;
  RxInt idealIndex = 0.obs;
  int idealTimeIndex(int value) =>
      idealTimeList.indexWhere((element) => element.type == value);
  int idealTimeType(int value, String id) => idealTimeList
      .where((element) => element.description == id && element.value == value)
      .toList()
      .first
      .type!;
  Future fetchIdealTime() async {
    await bdRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 2)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (int i = 0; i < value.docs.length; i++) {
          var doc = IdealTimeModel.fromMap(value.docs[i]);
          for (int j = 0; j < doc.categories!.length; j++) {
            final category = doc.categories![j];
            if (category.category != '') {
              idealIndex.value = idealIndex.value + 1;
              idealTimeList.add(
                AppModel(
                  category.category!.capitalize!,
                  doc.id!,
                  value: j,
                  type: idealIndex.value,
                ),
              );
            }
          }
        }
        setState(() {});
      }
    }).whenComplete(() async => await fetchPrevious());
    setState(() {});
  }

  RxInt play = 0.obs;
  updatePlay(int value) => play.value = value;

  RxInt currentEvent = 0.obs;
  setCurrentEvent(int value) => currentEvent.value = value;

  RxString status = ''.obs;
  RxBool startCountdown = false.obs;
  final CountDownController _countDownController = CountDownController();

  void clearEvent() {
    indx.value = 0;
    category.clear();
    event.clear();
    played.clear();
  }

  void clearData() {
    setState(() {
      play.value = 0;
      currentEvent.value = 0;
      scheduled = false;
      actual = false;
    });
    name.clear();
    estart.clear();
    eEnd.clear();
    acurrent.clear();
    rightNowCategory.value =
        AppModel('Select Category', '', value: -1, type: 0);
    rstart.clear();
    rend.clear();
    rduration.value = 0;
    status.value = '';
    startCountdown.value = false;
    rdesc.clear();
    actualEvents.clear();
  }

  final bool edit = Get.arguments[0];
  final Rx<AJL1Model> _journal = AJL1Model(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  RxList<AEventModel> actualEvents = <AEventModel>[].obs;
  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _journal.value.name = name.text;
    _journal.value.date = currentDate.text;
    _journal.value.energetic = EnergeticModel(
      end: eEnd.text,
      start: estart.text,
    );
    _journal.value.rightnow = RightNowModel(
      description: rdesc.text,
      category: rightNowCategory.value.value,
      catid: rightNowCategory.value.description,
      duration: EventDuration(
        start: rstart.text,
        end: rend.text,
        duration: rduration.value,
        date: currentDate.text,
      ),
    );
    _journal.value.events = <AEventModel>[];
    for (int i = 0; i < scheduledEvents.length; i++) {
      if (scheduledEvents[i].previous == false) {
        _journal.value.events!.add(scheduledEvents[i]);
      } else {
        actionRef.doc(scheduledEvents[i].previousid).get().then((value) async {
          final AJL1Model _levl0 = AJL1Model.fromMap(value.data());
          final _index = _levl0.events!.indexWhere(
              (element) => element.description == scheduledEvents[i].pdesc);
          setState(() {
            _levl0.events![_index] = scheduledEvents[i];
          });
          debugPrint(_levl0.events![_index].description);
           actionRef.doc(_levl0.id).update({
            "events": _levl0.events!.map((e) => e.toMap()).toList(),
          });
        });
      }
    }
    _journal.value.actual = <AEventModel>[];
    for (int i = 0; i < actualEvents.length; i++) {
      if (actualEvents[i].previous == false) {
        _journal.value.actual!.add(actualEvents[i]);
      }
    }
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _journal.value.duration = _journal.value.duration! + diff;
    } else {
      _journal.value.duration = diff;
    }
    setState(() {});
  }

  fetchData() {
    clearEvent();
    actualEvents.clear();
    _journal.value = Get.arguments[1] as AJL1Model;
    name.text = _journal.value.name!;
    currentDate.text = _journal.value.date!;
    final EnergeticModel _energetic = _journal.value.energetic!;
    estart.text = _energetic.start!;
    eEnd.text = _energetic.end!;
    final RightNowModel _rightnow = _journal.value.rightnow!;
    final rideal = idealTimeList[idealTimeList.indexWhere((element) =>
        element.value == _rightnow.category &&
        element.description == _rightnow.catid)];
    rightNowCategory.value = rideal;
    rdesc.text = _rightnow.description!;
    final EventDuration _rDuration = _rightnow.duration!;
    rstart.text = _rDuration.start!;
    rend.text = _rDuration.end!;
    rduration.value = _rDuration.duration!;
    // actualEvents.clear();
    // actualEvents = _journal.value.actual!.obs;
    for (int i = 0; i < _journal.value.actual!.length; i++) {
      _journal.value.actual![i].previous = false;
      actualEvents.add(_journal.value.actual![i]);
    }
    // clearEvent();
    for (int i = 0; i < _journal.value.events!.length; i++) {
      final AEventModel _event = _journal.value.events![i];
      addActionEvent();
      final ideal = idealTimeList[idealTimeList.indexWhere((element) =>
          element.value == _event.category &&
          element.description == _event.catid)];
      category[i] = AppModel(
        ideal.title,
        ideal.description,
        value: ideal.value,
        type: ideal.type,
      );
      // completed[i] = _event.completed!;
      // final EventDuration _duration = _event.scheduled!;
      // start[i].text = _duration.start!;
      // end[i].text = _duration.end!;
      // durations[i] = _duration.duration!;
      // scheduled = _event.scheduledEvent!;
      // actual = _event.actualEvent!;
      event[i].text = _event.description!;
      indexes[i] = _event.index!;
      controller[i].text = _event.index!.toString();
      scheduledEvents[i] = _event;
      scheduledEvents[i].previous = false;
    }
    // addEvents();
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == bd);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: name.text,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _journal.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      loadingDialog(context);
      final end = DateTime.now();
      setData(end);
      if (edit) _journal.value.id = generateId();
      await actionRef.doc(_journal.value.id).set(_journal.value.toMap());
      await addAccomplishment(end);
      Get.back();
      if (!fromsave) {
        if (Get.find<BdController>().history.value.value == 125) {
          Get.find<BdController>()
              .updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      customToast(message: 'Added sucessfully');
    }
  }

  Future updateJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      loadingDialog(context);
      final end = DateTime.now();
      setData(end);
      await actionRef.doc(_journal.value.id).update(_journal.value.toMap());
      Get.back();
      if (!fromsave) Get.back();
      customToast(message: 'Updated sucessfully');
    }
  }

  RxList<AJL1Model> previous = <AJL1Model>[].obs;
  RxList<AEventModel> scheduledEvents = <AEventModel>[].obs;
  Future fetchPrevious() async {
    if (edit) {
      fetchData();
    } else {
      await actionRef
          .where('userid', isEqualTo: Get.find<AuthServices>().userid)
          .where('type', isEqualTo: 1)
          .orderBy('created', descending: true)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          setState(() {
            for (int j = 0; j < value.docs.length; j++) {
              final doc = value.docs[j];
              final _previous = AJL1Model.fromMap(doc);
              previous.add(_previous);
              for (int i = 0; i < _previous.actual!.length; i++) {
                final _apevent = _previous.actual![i];
                _apevent.previous = true;
                _apevent.previousid = _previous.id;
                _apevent.eventindex = i;
                _apevent.jindex = j;
                _apevent.played = true;
                print(_apevent.played);
                actualEvents.add(_apevent);
              }
              for (int i = 0; i < _previous.events!.length; i++) {
                print(indx.value);
                addActionEvent();
                final AEventModel _event = _previous.events![i];
                controller[indx.value].text = _event.index.toString();
                print('value ${controller[indx.value].text}');
                indexes[indx.value] = _event.index!;
                _event.previous = true;
                _event.previousid = _previous.id;
                _event.eventindex = i;
                _event.jindex = j;
                print('controller: ${controller.length}');
                event[indx.value].text = _event.description!;
                final ideal = idealTimeList[idealTimeList.indexWhere(
                    (element) =>
                        element.value == _event.category &&
                        element.description == _event.catid)];
                category[indx.value] = AppModel(
                  ideal.title,
                  ideal.description,
                  value: ideal.value,
                  type: ideal.type,
                );
                print('category: ${category[indx.value].type}');
                scheduledEvents[indx.value] = _event;
                scheduledEvents[indx.value].pdesc = _event.description;
                indx.value = indx.value + 1;
              }
            }
          });
          setState(() {
            print('Total: ${scheduledEvents.length}');
            if (scheduledEvents.length > 5) {
              final list = scheduledEvents.take(5).toList().obs;
              debugPrint(list.toString());
              scheduledEvents.clear();
              debugPrint('cleared: $scheduledEvents');
              scheduledEvents.assignAll(list);
              indexes.assignAll(indexes.take(5).toList());
              controller = controller.take(5).toList().obs;
              event.assignAll(event.take(5).toList());
              played.assignAll(played.take(5).toList());
              category.assignAll(category.take(5).toList());
              indx.value = 4;
              debugPrint(scheduledEvents.toString());
              debugPrint(indx.value.toString());
            }
            if (actualEvents.length > 5) {
              actualEvents = actualEvents.take(5).toList().obs;
            }
          });
        }
      }).whenComplete(() => {});
    }
  }
}

class PreviousJournal extends StatelessWidget {
  const PreviousJournal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Action Journal Level 1- Tactical Accounting',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: actionRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 1)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data.docs.isEmpty) {
            return CircularLoadingWidget(
              height: height,
              onCompleteText: 'Nothing to show...',
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              final AJL1Model model =
                  AJL1Model.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const ActionJournalLvl1(),
                      arguments: [true, model]),
                  title: TextWidget(
                    text: model.name!,
                    weight: FontWeight.bold,
                    size: 15,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
