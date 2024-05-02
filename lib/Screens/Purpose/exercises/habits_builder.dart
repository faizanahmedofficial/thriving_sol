// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, library_private_types_in_public_api

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Controller/user_controller.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Functions/time_picker.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/visualization_model.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/buttons_theme.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/checkboxRows.dart';
import 'package:schedular_project/Widgets/checkboxes.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../../Functions/text_to_speech_converter.dart';
import '../../../Model/app_user.dart';
import '../../../Model/bd_models.dart';
import '../../../Widgets/custom_toast.dart';
import '../../../Widgets/drop_down_button.dart';
import '../../../Widgets/loading_dialog.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';
import '../bd_home.dart';

class HabitController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController desired = TextEditingController();
  TextEditingController currentTime = TextEditingController();

  /// motivated
  TextEditingController goal = TextEditingController();
  TextEditingController value = TextEditingController();
  TextEditingController deepest = TextEditingController();

  /// make it
  TextEditingController chain = TextEditingController();
  TextEditingController start = TextEditingController();
  RxInt duration = 0.obs;
  TextEditingController durationcontroller = TextEditingController();

  /// frequency
  RxBool calendar = false.obs;
  RxBool vcalendar = false.obs;

  /// obvious
  TextEditingController environment = TextEditingController();
  TextEditingController visual = TextEditingController();
  RxInt alarm = 0.obs;
  TextEditingController sensory = TextEditingController();

  /// easier
  TextEditingController simplification = TextEditingController();
  TextEditingController defaultop = TextEditingController();
  TextEditingController babysteps = TextEditingController();
  TextEditingController contingency = TextEditingController();

  /// enjoyable
  TextEditingController reward = TextEditingController();
  TextEditingController celebration = TextEditingController();

  /// accountability
  TextEditingController accountability = TextEditingController();
  TextEditingController script = TextEditingController();
  TextEditingController common = TextEditingController();
  TextEditingController frequency = TextEditingController();

  List<String> titles = <String>['M', 'T', 'W', 'Th', 'F', 'Sa', 'Su'];
  List<bool> values = <bool>[false, false, false, false, false, false, false];
  TimeOfDay chainstart = TimeOfDay.now();

  addToCalendar({required DateTime now}) {
    DateTime _next = DateTime.now().add(const Duration(hours: 1));
    Add2Calendar.addEvent2Cal(
        Event(title: name.text, startDate: DateTime.now(), endDate: _next));
  }

  clearData() {
    index.value = 0;
    Get.find<UserController>().link.value = '';
    calendar.value = false;
    vcalendar.value = false;
    script.clear();
    name.clear();
    environment.clear();
    visual.clear();
    start.clear();
    chain.clear();
    frequency.clear();
    defaultop.clear();
    deepest.clear();
    common.clear();
    alarm.value = 0;
    simplification.clear();
    contingency.clear();
    babysteps.clear();
    duration.value = 0;
    desired.clear();
    reward.clear();
    celebration.clear();
    accountability.clear();
    sensory.clear();
    value.clear();
    goal.clear();
    sight = false.obs;
    hearing = false.obs;
    touch = false.obs;
    music = false.obs;
    taste = false.obs;
    smell = false.obs;
    vperspective = false.obs;
    vangle = false.obs;
    _emotional.value = false;
    durationcontroller.clear();
  }

  Future<bool> setScript() async {
    script.text =
        'I see myself in ${environment.text} after finishing ${chain.text} at ${start.text} and encounter ${visual.text}, ${alarmSoundList[alarmIndex(alarm.value)].title}, and ${sensory.text} creating an aching need to spring into action. I have prepared further by ${defaultop.text} and ${simplification.text}. I recall ${deepest.text} and know without a doubt, I\'m doing the right thing. ${common.text} will try to thrawt me, but I will overcome by ${contingency.text}.\nI will start by ${babysteps.text} I ${desired.text} for ${duration.value ~/ 60} minutes every ${setFrequency()}. I celebrate by ${celebration.text}. I know I\'m moving closer to acheiving my goal(s) of ${goal.text}. I ${reward.text} and rejoice.';
    return true;
  }

  String setFrequency() {
    if (values.every((element) => element == true)) {
      return 'everyday';
    } else if (values.every((element) => element == false)) {
      return '';
    } else {
      String _text = '';
      if (values[0]) _text = '${_text}Monday';
      if (values[1]) {
        if (values[0]) _text = '$_text, ';
        _text = '${_text}Tuesday';
      }
      if (values[2]) {
        if (values[0] || values[1]) _text = '$_text, ';
        _text = '${_text}Wednesday';
      }
      if (values[3]) {
        if (values[0] || values[1] || values[2]) _text = '$_text, ';
        _text = '${_text}Thursday';
      }
      if (values[4]) {
        if (values[0] || values[1] || values[2] || values[3]) {
          _text = '$_text, ';
        }
        _text = '${_text}Friday';
      }
      if (values[5]) {
        if (values[0] || values[1] || values[2] || values[3] || values[4]) {
          _text = '$_text, ';
        }
        _text = '${_text}Saturday';
      }
      if (values[6]) {
        if (values[0] || values[1] || values[2] || values[3] || values[5]) {
          _text = '${_text}and ';
        }
        _text = '${_text}Sunday';
      }

      return _text;
    }
  }

  @override
  void onInit() {
    name.text = 'Habit Builder.${formatTitelDate(DateTime.now()).trim()}';
    currentTime.text = formateDate(DateTime.now());
    if (edit) fetchData();
    super.onInit();
  }

  @override
  void onClose() {
    Get.find<UserController>().link.value = '';
    Get.find<UserController>().file.value = '';
    super.onClose();
  }

  final page1 = GlobalKey<FormState>();

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;

  RxBool sight = false.obs;
  RxBool hearing = false.obs;
  RxBool touch = false.obs;
  RxBool music = false.obs;
  RxBool taste = false.obs;
  RxBool smell = false.obs;
  RxBool vperspective = false.obs;
  RxBool vangle = false.obs;
  final RxBool _emotional = false.obs;

  final bool edit = Get.arguments[0];
  final Rx<HabitModel> _habit = HabitModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;
  DateTime initial = DateTime.now();
  setData(DateTime end) async {
    _habit.value.audio = Get.find<UserController>().link.value;
    _habit.value.name = name.text;
    _habit.value.date = currentTime.text;
    _habit.value.habitToCalendar = calendar.value;
    _habit.value.script = script.text;
    _habit.value.days = values;
    _habit.value.desiredActivity = desired.text;
    _habit.value.motivated = GetMotivated(
      goal: goal.text,
      value: value.text,
      deepestWhy: deepest.text,
    );
    _habit.value.realistic = MakeRealistic(
      chain: chain.text,
      startTime: start.text,
      seconds: duration.value,
      duration: getDurationString(duration.value),
    );
    _habit.value.obvious = MakeObvious(
      environment: environment.text,
      visualCue: visual.text,
      alarm: alarm.value,
      sensorycue: sensory.text,
    );
    _habit.value.easier = MakeEasier(
      simplification: simplification.text,
      defaultOption: defaultop.text,
      babyStep: babysteps.text,
      contingency: contingency.text,
    );
    _habit.value.enjoyable = MakeEnjoyable(
      shortTerm: reward.text,
      celebration: celebration.text,
      accountability: accountability.text,
    );
    _habit.value.checks = CheckModel(
      sight: sight.value,
      hearing: hearing.value,
      touch: touch.value,
      music: music.value,
      taste: taste.value,
      smell: smell.value,
      vperspective: vperspective.value,
      viewAngle: vangle.value,
      emotional: _emotional.value,
    );
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _habit.value.duration = _habit.value.duration! + diff;
    } else {
      _habit.value.duration = diff;
    }
  }

  fetchData() {
    _habit.value = Get.arguments[1];
    name.text = _habit.value.name!;
    currentTime.text = _habit.value.date!;
    calendar.value = _habit.value.habitToCalendar!;
    script.text = _habit.value.script!;
    values = _habit.value.days!;
    desired.text = _habit.value.desiredActivity!;
    final GetMotivated _motivated = _habit.value.motivated!;
    goal.text = _motivated.goal!;
    value.text = _motivated.value!;
    deepest.text = _motivated.deepestWhy!;
    final MakeRealistic _realistic = _habit.value.realistic!;
    chain.text = _realistic.chain!;
    start.text = _realistic.startTime!;
    duration.value = _realistic.seconds!;
    durationcontroller.text = getDurationString(duration.value);
    final MakeObvious _obvious = _habit.value.obvious!;
    environment.text = _obvious.environment!;
    visual.text = _obvious.visualCue!;
    alarm.value = _obvious.alarm!;
    sensory.text = _obvious.sensorycue!;
    final MakeEasier _easier = _habit.value.easier!;
    simplification.text = _easier.simplification!;
    defaultop.text = _easier.defaultOption!;
    babysteps.text = _easier.babyStep!;
    contingency.text = _easier.contingency!;
    final MakeEnjoyable _enjoyable = _habit.value.enjoyable!;
    reward.text = _enjoyable.shortTerm!;
    celebration.text = _enjoyable.celebration!;
    accountability.text = _enjoyable.accountability!;
    final CheckModel _check = _habit.value.checks!;
    sight.value = _check.sight!;
    hearing.value = _check.hearing!;
    touch.value = _check.touch!;
    music.value = _check.music!;
    taste.value = _check.taste!;
    smell.value = _check.smell!;
    vperspective.value = _check.vperspective!;
    vangle.value = _check.viewAngle!;
    _emotional.value = _check.emotional!;
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
        id: _habit.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future<bool> uploadScripts() async {
    loadingDialog(Get.context!);
    await convertToAudio(
      script.text,
      filename: name.text,
      firebasepath: 'Habits/Audio/${Get.find<AuthServices>().userid}',
      loader: false,
    );
    return true;
  }

  Future addJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    page1.currentState!.save();
    if (page1.currentState!.validate()) {
      // loadingDialog(Get.context!);
      final end = DateTime.now();
      setData(end);

      if (edit) _habit.value.id = generateId();
      await bdRef.doc(_habit.value.id).set(_habit.value.toMap());
      await addAccomplishment(end);
      Get.back();
      if (!fromsave) {
        if (Get.find<BdController>().history.value.value == 118) {
          Get.find<BdController>()
              .updateHistory(end.difference(initial).inSeconds);
        }
        if (Get.find<UserController>().file.value != '') {
          final params = SaveFileDialogParams(
            sourceFilePath: Get.find<UserController>().file.value,
          );
          await FlutterFileDialog.saveFile(params: params);
        }
        Get.back();
      }
      Get.find<UserController>().link.value = '';
      Get.find<UserController>().file.value = '';
      if (calendar.value) addToCalendar(now: DateTime.now());
      customToast(message: 'Added sucessfully');
    }
  }

  Future updateJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    page1.currentState!.save();
    if (page1.currentState!.validate()) {
      loadingDialog(Get.context!);
      final end = DateTime.now();
      setData(end);
      if (calendar.value) addToCalendar(now: DateTime.now());
      await bdRef.doc(_habit.value.id).update(_habit.value.toMap());
      Get.back();
      if (!fromsave) Get.back();
      customToast(message: 'Updated sucessfully');
    }
  }

  previousIndex() => index.value = index.value - 1;
}

class HabitsBuilder extends StatefulWidget {
  const HabitsBuilder({Key? key}) : super(key: key);

  @override
  _HabitsBuilderState createState() => _HabitsBuilderState();
}

class _HabitsBuilderState extends State<HabitsBuilder> {
  final HabitController _habit = Get.put(HabitController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(
          leading: backButton(
            () => _habit.index.value == 0 ? Get.back() : _habit.previousIndex(),
          ),
          implyLeading: true,
        ),
        bottomNavigationBar: _habit.index.value == 0 || _habit.index.value == 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => _habit.updateIndex(),
                    icon: const Icon(Icons.last_page, color: AppColors.black),
                  ),
                ],
              )
            : _habit.index.value == 2
                ? BottomButtons(
                    button1: 'Cancel',
                    onPressed1: () => _habit.index.value != 0
                        ? _habit.previousIndex()
                        : Get.back(),
                    button2: 'Save',
                    onPressed2: () async => _habit.edit
                        ? await _habit.updateJournal(true)
                        : await _habit.addJournal(true),
                    button3: 'Continue',
                    onPressed3: () =>
                        {_habit.setScript(), _habit.updateIndex()},
                  )
                : _habit.index.value == 3
                    ? Container(
                        height: 70,
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.32,
                              child: OutlinedButton(
                                onPressed: () async => _habit.edit
                                    ? await _habit.updateJournal(true)
                                    : await _habit.addJournal(true),
                                style: outlineButton(),
                                child: const TextWidget(
                                  text: 'Save',
                                  alignment: Alignment.center,
                                  size: 16,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.6,
                              child: OutlinedButton(
                                onPressed: () async {
                                  _habit.page1.currentState!.save();
                                  if (_habit.page1.currentState!.validate()) {
                                    _habit.uploadScripts().then((value) async {
                                      if (value) {
                                        print('success');
                                        _habit.edit
                                            ? await _habit.updateJournal()
                                            : await _habit.addJournal();
                                      } else {
                                        Get.back();
                                      }
                                    });
                                  }
                                },
                                style: outlineButton(),
                                child: const TextWidget(
                                  text: 'Create Audio File and Finish!',
                                  alignment: Alignment.center,
                                  // size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _habit.page1,
            child: Column(
              children: [
                verticalSpace(height: 10),
                ExerciseTitle(
                  title: 'Habits Builder (Practice)',
                  onPressed: () => Get.to(
                    () => ReadingScreen(
                      title: 'BD101- Habits & Behavioral Design',
                      link:
                          'https://docs.google.com/document/d/1WKopjoxtn5Bc8KueOEPt0C4xQ02T3zAm/',
                      linked: () => Get.back(),
                      function: () {
                        if (Get.find<BdController>().history.value.value ==
                            116) {
                          final end = DateTime.now();
                          Get.find<BdController>().updateHistory(
                              end.difference(_habit.initial).inDays);
                        }
                        Get.log('closed');
                      },
                    ),
                  ),
                ),
                verticalSpace(height: 10),
                JournalTop(
                  controller: _habit.name,
                  label: 'Name',
                  add: () => _habit.clearData(),
                  save: () async => _habit.edit
                      ? await _habit.updateJournal(true)
                      : await _habit.addJournal(true),
                  drive: () => Get.off(() => const PreviousHabits()),
                ),
                verticalSpace(height: 15),
                _habit.index.value == 0
                    ? page1()
                    : _habit.index.value == 1
                        ? page2()
                        : _habit.index.value == 2
                            ? page3()
                            : _habit.index.value == 3
                                ? page4()
                                : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget page4() {
    return Column(
      children: [
        const TextWidget(
          text: 'Automatic Visualization Script',
          weight: FontWeight.bold,
          alignment: Alignment.center,
        ).marginOnly(bottom: 15),
        subtitle(
          'Write your highly detailed script in the space provided.  Think about the minor details like your viewing angle. Remember to evoke powerful emotions, feel all five senses, and associate positive emotions with wanted behaviors. Run through your script in your head at least once, but preferably 3 times after you complete it.',
        ).marginOnly(bottom: 15),
        TextFormField(
          maxLines: 15,
          controller: _habit.script,
          // readOnly: true,
          decoration: inputDecoration(),
        ),
        verticalSpace(height: 20),
        const TextWidget(
          text: 'Visualization Checklist',
          weight: FontWeight.bold,
          size: 16,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCheckBox(
                  value: _habit.sight.value,
                  onChanged: (value) {
                    setState(() {
                      _habit.sight.value = value;
                    });
                  },
                  title: 'Visual (sight)',
                  width: Get.width * 0.45,
                ),
                CustomCheckBox(
                  value: _habit.hearing.value,
                  onChanged: (value) {
                    setState(() {
                      _habit.hearing.value = value;
                    });
                  },
                  title: 'Auditory (hearing)',
                  width: Get.width * 0.45,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCheckBox(
                  value: _habit.touch.value,
                  onChanged: (value) {
                    setState(() {
                      _habit.touch.value = value;
                    });
                  },
                  title: 'Tactile (touch)',
                  width: Get.width * 0.4,
                ),
                CustomCheckBox(
                  value: _habit.music.value,
                  onChanged: (value) {
                    setState(() {
                      _habit.music.value = value;
                    });
                  },
                  title: 'Kinesthetic (music)',
                  width: Get.width * 0.5,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCheckBox(
                  value: _habit.taste.value,
                  onChanged: (value) {
                    setState(() {
                      _habit.taste.value = value;
                    });
                  },
                  title: 'Gustatory (taste)',
                  width: Get.width * 0.45,
                ),
                CustomCheckBox(
                  value: _habit.smell.value,
                  onChanged: (value) {
                    setState(() {
                      _habit.smell.value = value;
                    });
                  },
                  title: 'Olfactory (smell)',
                  width: Get.width * 0.45,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCheckBox(
                  value: _habit.vperspective.value,
                  onChanged: (value) {
                    setState(() {
                      _habit.vperspective.value = value;
                    });
                  },
                  title: 'Visual perspective',
                  width: Get.width * 0.5,
                ),
                CustomCheckBox(
                  value: _habit.vangle.value,
                  onChanged: (value) {
                    setState(() {
                      _habit.vangle.value = value;
                    });
                  },
                  title: 'Viewing Angle',
                  width: Get.width * 0.4,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomCheckBox(
                  value: _habit._emotional.value,
                  onChanged: (value) {
                    setState(() {
                      _habit._emotional.value = value;
                    });
                  },
                  title: 'Emotional',
                  width: Get.width * 0.45,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget page3() {
    return Column(
      children: [
        const TextWidget(
          text: 'Make it Enjoyable',
          alignment: Alignment.center,
          weight: FontWeight.bold,
        ),
        verticalSpace(height: 5),
        const TextWidget(
            text:
                'Short-Term Reward (What am I looking forward to receiving after I finish this activity?)'),
        TextFormField(
          controller: _habit.reward,
          decoration: inputDecoration(hint: 'Short Term Reward'),
        ),

        ///
        verticalSpace(height: 5),
        const TextWidget(
          text:
              'Celebration (How will I celebrate after completing this task?)',
        ),
        TextFormField(
          controller: _habit.celebration,
          decoration: inputDecoration(hint: 'Celebration'),
        ),

        ///
        verticalSpace(height: 10),
        const TextWidget(
          text: 'Make it Enjoyable',
          weight: FontWeight.bold,
          alignment: Alignment.center,
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text:
              'Accountability Buddy/ Group (Who or what group can I reach out to for accountability and mutual support?)',
        ),
        TextFormField(
          controller: _habit.accountability,
          decoration: inputDecoration(hint: 'Accountability Buddy/Group'),
        ),
        verticalSpace(height: 10),

        ///
      ],
    );
  }

  Widget page2() {
    return Column(
      children: [
        const TextWidget(
          text: 'Make it Obvious',
          alignment: Alignment.center,
          weight: FontWeight.bold,
        ),
        verticalSpace(height: 5),
        const TextWidget(
            text:
                'Environment (What specific setting am I providing to be a space for this activity?)'),
        TextFormField(
          controller: _habit.environment,
          decoration: inputDecoration(hint: 'Environment'),
        ),

        ///
        verticalSpace(height: 5),
        const TextWidget(
          text:
              'Visual Cue (What visual cue will remind me to start my activity?)',
        ),
        TextFormField(
          controller: _habit.visual,
          decoration: inputDecoration(hint: 'Visual Cue'),
        ),

        ///
        verticalSpace(height: 5),
        const TextWidget(
          text: 'Audio Cue (What sound will remind me to start my activity?)',
        ),
        SizedBox(
          width: Get.width,
          child: Obx(
            () => CustomDropDownStruct(
              //? TDO: Alarm Sound Cue
              child: DropdownButton(
                value: _habit.alarm.value,
                onChanged: (val) {
                  _habit.alarm.value = val;
                },
                hint: const TextWidget(
                  text: 'Alarm Sound #1',
                  alignment: Alignment.center,
                ),
                items: alarmSoundList
                    .map(
                      (e) => DropdownMenuItem(
                          value: e.value,
                          child: TextWidget(
                            text: e.title,
                            alignment: Alignment.centerLeft,
                          )),
                    )
                    .toList(),
              ),
            ),
          ),
        ),

        ///
        verticalSpace(height: 5),
        const TextWidget(
          text:
              'Other Sensory Cue (What other sensory cues will remind me to start my activity?)',
        ),
        TextFormField(
          controller: _habit.sensory,
          decoration: inputDecoration(hint: 'Other Sensory Cue'),
        ),

        ///
        verticalSpace(height: 10),
        const TextWidget(
          text: 'Make it Easier',
          weight: FontWeight.bold,
          alignment: Alignment.center,
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text:
              'Simplification (How did I make it easier to do this activity? How did I make it easier NOT to do alternative activities?)',
        ),
        TextFormField(
          controller: _habit.simplification,
          decoration: inputDecoration(hint: 'Simplification'),
        ),
        verticalSpace(height: 5),

        ///
        const TextWidget(
          text:
              'Default Option (How did I make doing this activity inevitable?)',
        ),
        TextFormField(
          controller: _habit.defaultop,
          decoration: inputDecoration(hint: 'Default Option'),
        ),
        verticalSpace(height: 5),

        ///
        const TextWidget(
          text:
              'Baby Step (What tiny time or result commitment can I make to guarantee I show up?)',
        ),
        TextFormField(
          controller: _habit.babysteps,
          decoration: inputDecoration(hint: 'Baby Step'),
        ),
        verticalSpace(height: 5),

        ///
        const TextWidget(
          text:
              'Contingency Plan (Plan to overcome common obstacles in the way of performing your desired activity)',
        ),
        TextFormField(
          controller: _habit.contingency,
          decoration: inputDecoration(hint: 'Contingency Plan'),
        ),
        verticalSpace(height: 5),
      ],
    );
  }

  Widget page1() {
    return Column(
      children: [
        ///
        const TextWidget(
          text:
              'Design an activity to become a habit or to drastically increase the likelihood of carrying out the activity.',
          alignment: Alignment.center,
        ),
        verticalSpace(height: 5),
        const TextWidget(
            text:
                'Desired Activity to Perform (What habit or activity do I want to engage in?)'),
        TextFormField(
          controller: _habit.desired,
          decoration: inputDecoration(hint: 'Habit'),
        ),

        /// Motivated
        verticalSpace(height: 15),
        const TextWidget(
          text: 'Get Motivated',
          weight: FontWeight.bold,
          alignment: Alignment.center,
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text:
              'Linked Goal (Do I have a specific goal linked to this task? Which goal?)',
        ),
        TextFormField(
          controller: _habit.goal,
          decoration: inputDecoration(hint: 'Linked Goal'),
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text:
              'Linked Value (Is this task in line with my values? Which values?)',
        ),
        TextFormField(
          controller: _habit.value,
          decoration: inputDecoration(hint: 'Linked Values'),
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text:
              'Deepest Why (What is my deepest reason for doing this activity?)',
        ),
        TextFormField(
          controller: _habit.deepest,
          decoration: inputDecoration(hint: 'Deepest Why'),
        ),

        ///
        verticalSpace(height: 15),
        const TextWidget(
          text: 'Make It Realistic',
          weight: FontWeight.bold,
          alignment: Alignment.center,
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text:
              'Chain (What activity or habit will occur directly before this activity?)',
        ),
        TextFormField(
          controller: _habit.chain,
          decoration: inputDecoration(hint: 'Chain'),
        ),
        verticalSpace(height: 5),

        ///
        const TextWidget(
          text:
              'Temporal Cue (What time will I start this activity? Try to keep this time consistent.)',
        ),
        TextFormField(
          readOnly: true,
          controller: _habit.start,
          decoration: inputDecoration(hint: 'Start Time (HH:MM:SS)'),
          onTap: () {
            customTimePicker(
              context,
              initialTime: TimeOfDay.now(),
            ).then((value) {
              setState(() {
                _habit.chainstart = value;
              });
              String minutes = value.minute < 10
                  ? '0${value.minute}'
                  : value.minute.toString();
              _habit.start.text = '${value.hour}:$minutes:00';
            });
          },
        ),
        verticalSpace(height: 5),

        ///
        const TextWidget(
          text: 'Duration (How long will I perform this activity?)',
        ),
        TextFormField(
          // inputFormatters: [CustomInputFormatter()],
          keyboardType: TextInputType.number,
          controller: _habit.durationcontroller,
          readOnly: true,
          decoration: inputDecoration(hint: 'Duration (HH:MM:SS)'),
          onTap: () async {
            await customDurationPicker(baseunit: BaseUnit.minute)
                .then((value) async {
              _habit.duration.value = value!.inSeconds;
              _habit.durationcontroller.text =
                  getDurationString(_habit.duration.value);
            });
          },
        ),
        verticalSpace(height: 5),

        ///frequency
        const TextWidget(
            text: 'Frequency (How often will I perform this activity?)'),
        CheckBoxRows(
          titles: _habit.titles,
          values: _habit.values,
          size: 60,
          titleAlignment: Alignment.center,
        ),
        verticalSpace(height: 5),

        ///
        CustomCheckBox(
          value: _habit.calendar.value,
          onChanged: (value) {
            setState(() {
              _habit.calendar.value = value;
            });
          },
          title: 'Add Habit to Calender?',
          width: Get.width,
        ),
      ],
    );
  }
}

class PreviousHabits extends StatelessWidget {
  const PreviousHabits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Habits Builder',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: bdRef
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
              final HabitModel model =
                  HabitModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const HabitsBuilder(),
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

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != text.length) {
        buffer.write(
            ':'); // Replace this with anything you want to put after each 4 numbers
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
