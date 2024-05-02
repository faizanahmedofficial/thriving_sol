// ignore_for_file: avoid_print, prefer_final_fields, no_leading_underscores_for_local_identifiers, library_private_types_in_public_api
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
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Screens/seek_bar.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/buttons_theme.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/checkboxes.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../../Constants/colors.dart';
import '../../../Model/action_model.dart';
import '../../../Model/app_user.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../Widgets/stop_watch.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';
import '../bd_home.dart';

class ActionJournalLvl0 extends StatefulWidget {
  const ActionJournalLvl0({Key? key}) : super(key: key);

  @override
  _ActionJournalLvl0State createState() => _ActionJournalLvl0State();
}

class _ActionJournalLvl0State extends State<ActionJournalLvl0> {
  final _key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();

  RxList<TextEditingController> event = <TextEditingController>[].obs;
  RxInt indx = 0.obs;
  RxList<int> indexes = <int>[].obs;
  RxList<TextEditingController> controller = <TextEditingController>[].obs;

  TextEditingController currentDate = TextEditingController();

  RxList<AEventModel> scheduledEvents = <AEventModel>[].obs;
  RxList<bool> played = <bool>[].obs;

  void addActionEvent() {
    indexes.add(0);
    controller.add(TextEditingController(text: ('').toString()));
    TextEditingController _event = TextEditingController();
    event.add(_event);
    played.add(false);
    scheduledEvents.add(
      AEventModel(
        index: 0,
        description: '',
        completed: false,
        previous: false,
        previousid: '',
        scheduled: EventDuration(
          start: '',
          end: '',
          date: currentDate.text,
          duration: 0,
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
          // await actionRef.doc(scheduledEvents[index].previousid).delete();
        }
        indexes.removeAt(index);
        controller.removeAt(index);
        event.removeAt(index);
        // category.removeAt(index);
        played.removeAt(index);
        scheduledEvents.removeAt(index);
        Get.back();
      },
    );
  }

  void addEvents() {
    print('----Adding----');
    for (int i = 0; i < 3; i++) {
      print(indx.value);
      addActionEvent();
      indx.value = indx.value + 1;
    }
  }

  @override
  void initState() {
    setState(() {
      fetchPrevious();
      currentDate.text = formateDate(DateTime.now());
      name.text =
          'ActionJournalLevel0HonestAccounting${formatTitelDate(DateTime.now()).trim()}';

      if (edit) fetchData();
    });
    super.initState();
  }

  TextEditingController estart = TextEditingController();
  TextEditingController eEnd = TextEditingController();
  RxBool actual = false.obs;
  RxBool scheduled = true.obs;

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
                      'Action Journal Level 0 - Honest Accounting (Practice)',
                  onPressed: () => Get.to(
                    () => ReadingScreen(
                      title: 'P99- Brutally Honest',
                      link:
                          'https://docs.google.com/document/d/1SCJaZHqgJIs5CsFwSNDsLEb0E6a46fcV/',
                      linked: () => Get.back(),
                      function: () {
                        if (Get.find<BdController>().history.value.value ==
                            121) {
                          final end = DateTime.now();
                          Get.find<BdController>()
                              .updateHistory(end.difference(initial).inSeconds);
                        }
                        Get.log('closed');
                      },
                    ),
                  ),
                  // () => Get.to(() => const P99Reading()),
                ),
                verticalSpace(height: 10),
                JournalTop(
                  controller: name,
                  add: () => {clearData(), addEvents()},
                  save: () async =>
                      edit ? await updateJournal(true) : await addJournal(true),
                  drive: () => Get.off(() => const PreviousJournal()),
                ),
                play.value == 0
                    ? page1()
                    : play.value == 1
                        ? page2(currentEvent.value)
                        : Container(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: play.value == 0
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: TextWidget(
                        text: 'How are you spending your time right now?'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.8,
                          child: TextFormField(
                            controller: rightNow,
                            decoration:
                                inputDecoration(hint: 'Event Description'),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            bool check = await Wakelock.enabled;
                            if (!check) await Wakelock.enable();
                            setState(() {
                              _rightNow.value.description = rightNow.text;
                              _rightNow.value.duration =
                                  EventDuration(date: currentDate.text);
                              _rightNow.value.duration!.start =
                                  TimeOfDay.now().format(context);
                              if (_rightNow.value.duration!.duration == null) {
                                _rightNow.value.duration!.duration = 0;
                              }
                            });
                            rightnowDialog();
                          },
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    child: BottomButtons(
                      button1: 'Done',
                      button2: 'Save',
                      onPressed2: () async => await addJournal(true),
                      onPressed1: () async =>
                          edit ? await updateJournal() : await addJournal(),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget scheduledRow(int index) {
    return scheduledEvents[index].completed!
        ? const SizedBox.shrink()
        : SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.15,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller[index],
                    decoration: inputDecoration(hint: '0'),
                    onChanged: (val) {
                      setState(() {
                        int _val = int.parse(val);
                        indexes[index] = _val;
                        scheduledEvents[index].index = _val;
                        updateOrder(index);
                      });
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: width * 0.4,
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
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Tooltip(
                    message: 'Completed',
                    child: Checkbox(
                      value: scheduledEvents[index].completed,
                      onChanged: (value) {
                        setState(() {
                          scheduledEvents[index].completed = value;
                          final _event = AEventModel(
                            completed: true,
                            played: false,
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
                            description: event[index].text,
                            urgency: -1,
                            index: indexes[index],
                            actual: EventDuration(
                              start: TimeOfDay.now().format(context),
                              end: '',
                              date: currentDate.text,
                              duration: 0,
                            ),
                          );
                          addActual(index, _event);
                          _actualEvents.add(_event);

                          if (scheduledEvents[index].previous ?? false) {
                            print('previous');
                            previous[scheduledEvents[index].jindex!].scheduled![
                                    scheduledEvents[index].eventindex!] =
                                scheduledEvents[index];
                            actionRef
                                .doc(
                                    previous[scheduledEvents[index].jindex!].id)
                                .update(previous[scheduledEvents[index].jindex!]
                                    .toMap());
                          }
                        });
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.play_arrow),
                    alignment: Alignment.centerLeft,
                    onPressed: () async {
                      bool check = await Wakelock.enabled;
                      if (!check) await Wakelock.enable();
                      setState(() {
                        scheduledEvents[index].scheduled!.start =
                            TimeOfDay.now().format(context);
                      });
                      stopwatchDialog(index);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      deleteActionEvent(index);
                    });
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          );
  }

  addActual(int index, AEventModel _event) {
    if (scheduledEvents[index].previous!) {
      setState(() {
        previous[_event.jindex!].actual!.add(_event);
        actionRef
            .doc(previous[_event.jindex!].id)
            .update(previous[_event.jindex!].toMap());
      });
    }
  }

  updateOrder(int index) {
    for (int k = 0; k < indexes.length - 1; k++) {
      for (int i = 0; i < indexes.length - k - 1; i++) {
        if (indexes[i] > indexes[i + 1]) {
          TextEditingController _desc = event[i];
          event[i] = event[i + 1];
          event[i + 1] = _desc;

          final _event = scheduledEvents[i];
          scheduledEvents[i] = scheduledEvents[i + 1];
          scheduledEvents[i + 1] = _event;
          int _indexes = indexes[i];
          indexes[i] = indexes[i + 1];
          indexes[i + 1] = _indexes;
          TextEditingController _controller = controller[i];
          controller[i] = controller[i + 1];
          controller[i + 1] = _controller;
          final _played = played[i];
          played[i] = played[i + 1];
          played[i + 1] = _played;
          // swapped = 1;
        }
      }
    }
    setState(() {});
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
                    _actualEvents.add(_event);
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

  int calculateDuration(String start, TimeOfDay end) {
    final _today = DateTime.now();
    final _end =
        DateTime(_today.year, _today.month, _today.day, end.hour, end.minute);
    final _time = getTimeFromString(start);
    final _start = DateTime(
        _today.year, _today.month, _today.day, _time.hour, _time.minute);
    return _end.difference(_start).inSeconds.abs();
  }

  Widget actualRow(int index) {
    return SizedBox(
      height: 40,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          horizontalSpace(width: 30),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: width * 0.3,
              child: TextWidget(
                text: _actualEvents[index].description ?? 'Event Description',
                alignment: Alignment.centerLeft,
                maxline: 3,
              ),
            ),
          ),
          if (_actualEvents[index].played == false)
            Container(
              width: width * 0.15,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10),
              child: const TextWidget(
                alignment: Alignment.center,
                text: 'Completed',
              ),
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: width * 0.3,
              child: Tooltip(
                message: 'date',
                child: TextWidget(
                  text: _actualEvents[index].actual!.date ?? 'MM/dd/yy',
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          (_actualEvents[index].played == true)
              ? Row(
                  children: [
                    if (_actualEvents[index].actual!.start! != '')
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: width * 0.15,
                          margin: const EdgeInsets.only(left: 5.0, top: 10),
                          child: Tooltip(
                            message: 'Start Time',
                            child: TextWidget(
                              text:
                                  _actualEvents[index].actual!.start ?? 'HH:MM',
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    if (_actualEvents[index].actual!.start! != '')
                      const TextWidget(text: ' -', alignment: Alignment.center)
                          .marginOnly(right: 2, top: 2),
                    if (_actualEvents[index].actual!.end! != '')
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: width * 0.15,
                          child: Tooltip(
                            message: 'End Time',
                            child: TextWidget(
                              text: _actualEvents[index].actual!.end ?? 'HH:MM',
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, top: 10),
                        child: SizedBox(
                          width: width * 0.2,
                          child: Tooltip(
                            message: 'Duration',
                            child: TextWidget(
                              text: _actualEvents[index].actual!.duration! == 0
                                  ? 'HH:MM:SS'
                                  : getDurationString(
                                      _actualEvents[index].actual!.duration!,
                                    ),
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, top: 10),
                          child: SizedBox(
                            width: width * 0.2,
                            child: Tooltip(
                              message: 'time',
                              child: TextWidget(
                                text: _actualEvents[index].actual!.start ??
                                    'HH:MM',
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: width * 0.2,
                      //   child: const TextWidget(
                      //     text: 'Completed',
                      //     alignment: Alignment.center,
                      //   ),
                      // ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget page1() {
    return Column(
      children: [
        verticalSpace(height: 15),
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
        const TextWidget(
          text: 'When was I most productive and energetic today?',
          textAlign: TextAlign.left,
          fontStyle: FontStyle.italic,
        ),
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
            const TextWidget(text: '-'),
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
                  decoration: decoration(hint: '- HH:MM'),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            CustomCheckBox(
              value: scheduled.value,
              onChanged: (val) {
                scheduled.value = val;
                if (scheduled.value) {
                  actual.value = false;
                } else {
                  actual.value = true;
                }
              },
              title: 'Scheduled',
            ),
            CustomCheckBox(
              value: actual.value,
              onChanged: (val) {
                actual.value = val;
                if (actual.value) {
                  scheduled.value = false;
                } else {
                  scheduled.value = true;
                }
              },
              title: 'Actual',
            ),
          ],
        ),
        verticalSpace(height: 15),
        if (scheduled.value)
          const TextWidget(
            text: 'Completed?',
            alignment: Alignment.bottomRight,
          ).marginOnly(right: 50),
        Column(
          children: [
            if (scheduled.value)
              for (int i = 0; i < scheduledEvents.length; i++) scheduledRow(i),
            if (actual.value)
              for (int i = 0; i < _actualEvents.length; i++) actualRow(i)
          ],
        ),
        if (scheduled.value)
          TextButton(
            onPressed: () {
              if (indx.value == 0) {
              } else {
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

  Rx<DateTime> _start = DateTime.now().obs;
  RxString pstatus = ''.obs;
  AudioPlayer player = AudioPlayer();
  Widget page2(int index) {
    return Column(
      children: [
        verticalSpace(height: 30),
        TextWidget(
          text: scheduledEvents[index].description ?? 'Event Description',
          weight: FontWeight.bold,
          size: 17,
          alignment: Alignment.center,
        ).marginOnly(bottom: 15),
        CustomCountdown(
          controller: _countDownController,
          duration: scheduledEvents[index].scheduled!.duration ?? 0,
          caption: 'Action',
          onStart: () => {
            startCountdown.value = true,
            _start.value = DateTime.now(),
            pstatus.value = 'play',
          },
          onComplete: () {
            playAlarm(player);
            pstatus.value = 'complete';
            startCountdown.value = false;
            // completed[index] = true;
            final _end = DateTime.now();
            _actualEvents.add(
              AEventModel(
                completed: true,
                index: indexes[index],
                description: scheduledEvents[index].description,
                actual: EventDuration(
                  duration: _end.difference(_start.value).inSeconds,
                  start: TimeOfDay.fromDateTime(_start.value).format(context),
                  end: TimeOfDay(hour: _end.hour, minute: _end.minute)
                      .format(context),
                  date: currentDate.text,
                ),
              ),
            );
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
            setState(() {});
          },
          onfinished: () async {
            if (startCountdown.value) _countDownController.reset();
            startCountdown.value = false;
            pstatus.value = '';
            bool check = await Wakelock.enabled;
            if (check) await Wakelock.disable();
            setState(() {});
            // completed[index] = true;
            updatePlay(0);
          },
        ),
      ],
    );
  }

  RxString status = ''.obs;
  RxBool startCountdown = false.obs;
  final CountDownController _countDownController = CountDownController();
  TextEditingController rightNow = TextEditingController();

  void clearData() {
    play.value = 0;
    currentEvent.value = 0;
    scheduled.value = true;
    actual.value = false;
    name.clear();
    estart.clear();
    eEnd.clear();
    clearEvents();
    status.value = '';
    startCountdown.value = false;
    rightNow.clear();
    _rightNow.value = RightNowModel();
    _actualEvents.clear();
  }

  clearEvents() {
    indx.value = 0;
    event.clear();
    indexes.clear();
    controller.clear();
    scheduledEvents.clear();
    played.clear();
  }

  final bool edit = Get.arguments[0];
  final Rx<AJL0Model> _journal = AJL0Model(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  RxList<AEventModel> _actualEvents = <AEventModel>[].obs;
  DateTime initial = DateTime.now();
  setData(DateTime end) async {
    _journal.value.name = name.text;
    _journal.value.date = currentDate.text;
    _journal.value.mostEnergetic =
        EnergeticModel(start: estart.text, end: eEnd.text);
    _rightNow.value.description = rightNow.text;
    _journal.value.rightnow = _rightNow.value;
    _journal.value.scheduled = <AEventModel>[];
    _journal.value.actual = <AEventModel>[];
    for (int i = 0; i < _actualEvents.length; i++) {
      if (_actualEvents[i].previous == false) {
        _journal.value.actual!.add(_actualEvents[i]);
      }
    }
    for (int i = 0; i < scheduledEvents.length; i++) {
      if (scheduledEvents[i].previous == false) {
        scheduledEvents[i].scheduled!.date = currentDate.text;
        _journal.value.scheduled!.add(scheduledEvents[i]);
      } else {
        actionRef.doc(scheduledEvents[i].previousid).get().then((value) async {
          final AJL0Model _levl0 = AJL0Model.fromMap(value.data());
          final _index = _levl0.scheduled!.indexWhere(
              (element) => element.description == scheduledEvents[i].pdesc);
          setState(() {
            _levl0.scheduled![_index] = scheduledEvents[i];
          });
          debugPrint(_levl0.scheduled![_index].description);
          actionRef.doc(_levl0.id).update({
            "events": _levl0.scheduled!.map((e) => e.toMap()).toList(),
          });
        });
      }
      final diff = end.difference(initial).inSeconds;
      if (edit) {
        _journal.value.duration = _journal.value.duration! + diff;
      } else {
        _journal.value.duration = diff;
      }
      if (!mounted) setState(() {});
    }
  }

  fetchData() {
    _actualEvents.clear();
    clearEvents();
    _journal.value = Get.arguments[1] as AJL0Model;
    name.text = _journal.value.name!;
    currentDate.text = _journal.value.date!;
    final EnergeticModel _energetic = _journal.value.mostEnergetic!;
    estart.text = _energetic.start!;
    eEnd.text = _energetic.end!;
    _rightNow.value = _journal.value.rightnow!;
    rightNow.text = _rightNow.value.description!;
    for (int i = 0; i < _journal.value.actual!.length; i++) {
      _journal.value.actual![i].previous = false;
      _actualEvents.add(_journal.value.actual![i]);
    }
    // clearEvents();
    for (int i = 0; i < _journal.value.scheduled!.length; i++) {
      final AEventModel _event = _journal.value.scheduled![i];
      // indx.value = i;
      addActionEvent();
      event[i].text = _event.description!;
      // completed[i] = _event.completed!;
      // final EventDuration _duration = _event.scheduled!;
      // start[i].text = _duration.start!;
      // end[i].text = _duration.end!;
      // durations[i] = _duration.duration!;
      indexes[i] = _event.index!;
      controller[i].text = _event.index.toString();
      scheduledEvents[i] = _event;
      scheduledEvents[i].previous = false;
    }
    // addEvents();
    setState(() {});
  }

  RxInt play = 0.obs;
  updatePlay(int value) => play.value = value;

  RxInt currentEvent = 0.obs;
  setCurrentEvent(int value) => currentEvent.value = value;

  final Rx<RightNowModel> _rightNow = RightNowModel().obs;

  void rightnowDialog() {
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
                  text: rightNow.text,
                  stopwatch: _watch..start(),
                ),
              ).marginOnly(bottom: 30),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _watch.stop();
                    _rightNow.value.duration!.end =
                        TimeOfDay.now().format(context);
                    _rightNow.value.duration!.duration =
                        Duration(milliseconds: _watch.elapsedMilliseconds)
                            .inSeconds;
                    print(_rightNow.value.duration!.duration);
                    _actualEvents.add(
                      AEventModel(
                        played: true,
                        completed: true,
                        description: rightNow.text,
                        index: _actualEvents.length,
                        previous: false,
                        actual: EventDuration(
                          date: currentDate.text,
                          duration: _rightNow.value.duration!.duration,
                          end: _rightNow.value.duration!.end,
                          start: _rightNow.value.duration!.start,
                        ),
                      ),
                    );
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
      await setData(end);
      if (edit) _journal.value.id = generateId();
      await actionRef.doc(_journal.value.id).set(_journal.value.toMap());
      await addAccomplishment(end);
      Get.back();
      if (!fromsave) {
        if (Get.find<BdController>().history.value.value == 122) {
          Get.find<BdController>()
              .updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      customToast(message: 'Added successfully');
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
      customToast(message: 'Updated successfully');
    }
  }

  RxList<AJL0Model> previous = <AJL0Model>[].obs;
  Future fetchPrevious() async {
    if (edit) {
      fetchData();
    } else {
      await actionRef
          .where('userid', isEqualTo: Get.find<AuthServices>().userid)
          .where('type', isEqualTo: 0)
          .orderBy('created', descending: true)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          setState(() {
            for (int j = 0; j < value.docs.length; j++) {
              final doc = value.docs[j];
              final _previous = AJL0Model.fromMap(doc);
              previous.add(_previous);
              for (int i = 0; i < _previous.actual!.length; i++) {
                final _apevent = _previous.actual![i];
                _apevent.played = true;
                _apevent.previous = true;
                _apevent.previousid = _previous.id;
                _apevent.eventindex = i;
                _apevent.jindex = j;
                print(_apevent.actualEvent);
                _actualEvents.add(_apevent);
              }
              for (int i = 0; i < _previous.scheduled!.length; i++) {
                // print(indx.value);
                addActionEvent();
                final AEventModel _event = _previous.scheduled![i];
                controller[indx.value].text = _event.index.toString();
                // print('value ${controller[indx.value].text}');
                indexes[indx.value] = _event.index!;
                _event.previous = true;
                _event.previousid = _previous.id;
                _event.eventindex = i;
                _event.jindex = j;
                _event.played = false;
                // print('controller: ${controller.length}');
                event[indx.value].text = _event.description!;
                scheduledEvents[indx.value] = _event;
                scheduledEvents[indx.value].pdesc = _event.description;
                indx.value = indx.value + 1;
              }
            }

            // _actualEvents.assignAll(_actualEvents.take(5));
            // scheduledEvents.assignAll(scheduledEvents.take(5));
            // debugPrint(_actualEvents.toString());
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
              indx.value = 4;
              debugPrint(scheduledEvents.toString());
              debugPrint(indx.value.toString());
            }
            if (_actualEvents.length > 5) {
              _actualEvents = _actualEvents.take(5).toList().obs;
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
        title: 'Action Journal Level 0- Honest Accounting',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: actionRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 0)
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
              final AJL0Model model =
                  AJL0Model.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const ActionJournalLvl0(),
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
