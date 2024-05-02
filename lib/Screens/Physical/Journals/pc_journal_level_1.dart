// ignore_for_file: avoid_print, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/exercise_tracker.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/exercise_models.dart';
import 'package:schedular_project/Screens/custom_bottom.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';
import 'package:wakelock/wakelock.dart';
import 'dart:math' as math;

import '../../../Model/app_user.dart';
import '../../../Model/sexual_model.dart';
import '../../../Services/auth_services.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../readings.dart';
import '../../seek_bar.dart';
import '../sexual_home.dart';

class PCJournalLvl1 extends StatefulWidget {
  const PCJournalLvl1({Key? key}) : super(key: key);

  @override
  _PCJournalLvl1State createState() => _PCJournalLvl1State();
}

class _PCJournalLvl1State extends State<PCJournalLvl1> {
  final _key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController goal = TextEditingController();
  bool findPc = false;
  TextEditingController currentTime = TextEditingController();

  final AudioPlayer _player = AudioPlayer();

  Future fetchPreviousJournal() async {
    await sexualRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 1)
        .orderBy('created', descending: true)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          _journal.value = PCJ1Model.fromMap(doc);
          goal.text = _journal.value.goal!.toString();
          if (_journal.value.level == 50) {
            level.value = 1;
            exercise.value = 1;
            eset.value = 1;
          } else {
            if (_journal.value.exercise == 10) {
              level.value = _journal.value.level! + 1;
              exercise.value = 1;
              eset.value = 1;
            } else {
              exercise.value = _journal.value.exercise! + 1;
              // if (_journal.value.eset == 8) {
              eset.value = 1;
              // } else {
              //   eset.value = _journal.value.eset! + 1;
              // }
              level.value = _journal.value.level!;
            }
          }

          total.value = _journal.value.total!;
          totalRest.value = _journal.value.rest!;
          _setDurations();
        }
      }
    });
  }

  Future enableWakelock() async {
    bool check = await Wakelock.enabled;
    if (!check) await Wakelock.enable();
  }

  Future disableWakelock() async {
    bool check = await Wakelock.enabled;
    if (check) await Wakelock.disable();
  }

  @override
  void initState() {
    setState(() {
      enableWakelock();
      name.text = 'PCJournalLevel1StrengthingYourPC${formatTitelDate(DateTime.now()).trim()}';
      currentTime.text = formateDate(DateTime.now());
      fetchPreviousJournal();
      _setDurations();
      if (edit) fetchData();
    });
    super.initState();
  }

  @override
  void dispose() {
    disableWakelock();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _key,
            child: Column(
              children: [
                verticalSpace(height: 10),
                ExerciseTitle(
                  title: 'PC Journal Level 1 - Strengthing your PC (Practice)',
                  onPressed: () => Get.to(
                    () => ReadingScreen(
                      title: 'PC99- Why and What?',
                      link:
                          'https://docs.google.com/document/d/1IZLDgamPSi1r5sqMh1wz9CcmlZydKBeX/',
                      linked: () => Get.back(),
                      function: () {
                        if (Get.find<SexualController>().history.value.value ==
                            139) {
                          final end = DateTime.now();
                          Get.find<SexualController>()
                              .updateHistory(end.difference(initial).inSeconds);
                        }
                        Get.log('closed');
                      },
                    ),
                  ),
                  // () => Get.to(() => const PC99Reading()),
                ),
                verticalSpace(height: 10),
                JournalTop(
                  controller: name,
                  label: 'Name',
                  add: () => clearData(),
                  save: () async =>
                      edit ? await updateJournal(true) : await addJournal(true),
                  drive: () => Get.off(() => const PreviousJournal()),
                ),
                verticalSpace(height: 15),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10),
                  child: TextWidget(
                    text:
                        'Perform Kegels of increasing difficulty to develop your pubococcygeus (PC) muscle strength at a healthy rate.',
                    weight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    alignment: Alignment.center,
                    textAlign: TextAlign.center,
                  ),
                ),
                verticalSpace(height: 10),
                TextFormField(
                  controller: currentTime,
                  readOnly: true,
                  onTap: () {
                    customDatePicker(
                      context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    ).then((value) {
                      setState(() {
                        currentTime.text = formateDate(value);
                      });
                    });
                  },
                  decoration: inputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusBorder: InputBorder.none,
                  ),
                ),

                /// goal
                verticalSpace(height: 15),
                Row(
                  children: [
                    const TextWidget(text: 'Goal:'),
                    horizontalSpace(width: 5),
                    SizedBox(
                      width: Get.width * 0.15,
                      child: TextFormField(
                        controller: goal,
                        keyboardType: TextInputType.number,
                        decoration: inputDecoration(hint: '3'),
                      ),
                    ),
                    horizontalSpace(width: 5),
                    const TextWidget(text: 'Workouts per day'),
                  ],
                ),

                /// tracker
                verticalSpace(height: Get.height * 0.1),
                ExerciseTracker(
                  exName: 'Begin Exercise',
                  exLevel: 'Exercise ${exercise.value + 1}',
                  level: 'Level ${level.value + 1}',
                  onPressed: () => _exerciseDialog(),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomButtons(
            button1: 'Done',
            button2: 'Save',
            onPressed2: () async => await addJournal(true),
            onPressed1: () async =>
                edit ? await updateJournal() : await addJournal(),
          ),
        ),
      ),
    );
  }

  void clearData() {
    setState(() {
      findPc = false;
      exercise.value = 0;
      level.value = 0;
      eset.value = 0;
      duration.value = 0;
      rest.value = 0;
      total.value = 0;
      totalRest.value = 0;
    });
    goal.clear();
  }

  RxInt exercise = 0.obs;
  RxInt level = 0.obs;
  RxInt eset = 0.obs;

  RxInt duration = 0.obs;
  RxInt rest = 0.obs;

  RxInt total = 0.obs;
  updateTotal(int value) => total.value = total.value + value;

  RxInt totalRest = 0.obs;
  updateTotalRest(int value) => totalRest.value = totalRest.value + value;

  final Rx<TrainersModel> _trainer = trainerList[0].obs;

  _setDurations() {
    var _set = _trainer.value.levels![level.value].exercises![exercise.value]
        .sets![eset.value];
    duration.value = _set.exercise!;
    rest.value = _set.rest!;
  }

  _updateLevel() {
    if (level.value == 50) level.value = 0;
    exercise.value = 0;
    _updateExercise(true);
  }

  _updateExercise([bool fromLevel = false]) {
    // if (!fromLevel) exercise.value = exercise.value + 1;
    eset.value = 0;
    _updateSet(true);
  }

  _updateSet([bool fromExercise = false]) {
    Get.log('updating set');
    // if (!fromExercise) eset.value = eset.value + 1;
    var _set = _trainer.value.levels![level.value].exercises![exercise.value]
        .sets![eset.value];
    duration.value = _set.exercise!;
    rest.value = _set.rest!;
    print(duration.value);
  }

  _decrementLevel() {
    if (level.value < 0) level.value = 0;
    exercise.value = 0;
    _decrementExercise(true);
  }

  _decrementExercise([bool fromLevel = false]) {
    eset.value = 0;
    _updateSet(true);
  }

  _exerciseDialog() {
    RxString status = ''.obs;
    CountDownController _countdowncontroller = CountDownController();

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
          contentPadding: const EdgeInsets.only(
            bottom: 10,
            left: 15,
            right: 15,
            top: 0,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          content: SizedBox(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => SizedBox(
                      height: 400,
                      width: 250,
                      child: Column(
                        children: [
                          Obx(
                            () => CustomCountdown(
                              caption: '',
                              cheight: 265,
                              controller: _countdowncontroller,
                              duration: status.value == 'rest'
                                  ? rest.value
                                  : duration.value,
                              onStart: () {
                                if (status.value != 'rest') {
                                  print('Countdown Started');
                                } else if (status.value == 'reset') {
                                  _countdowncontroller.reset();
                                }
                              },
                              onComplete: () {
                                if (status.value == 'reset') {
                                  _countdowncontroller.pause();
                                } else {
                                  playAlarm(_player);
                                  Get.log('completed');
                                  if (status.value == 'rest') {
                                    updateTotalRest(rest.value);
                                    eset.value = eset.value + 1;
                                    // status.value = 'finished';
                                    if (eset.value != 8) {
                                      _updateSet();
                                      status.value = 'play';
                                      _countdowncontroller.restart(
                                          duration: duration.value);
                                    } else {
                                      status.value = 'finished';
                                      exercise.value = exercise.value + 1;
                                      if (exercise.value > 9) {
                                        level.value = level.value + 1;
                                        _updateLevel();
                                      } else {
                                        _updateExercise();
                                      }
                                      Get.back();
                                      // status.value = 'play';
                                      // _countdowncontroller.restart(
                                      //     duration: duration.value);
                                      // exercise.value = exercise.value + 1;
                                      // if (exercise.value == 10) {
                                      //   level.value = level.value + 1;
                                      //   _updateLevel();
                                      // } else {
                                      //   _updateExercise();
                                      // }
                                    }
                                  } else {
                                    updateTotal(duration.value);
                                    status.value = 'rest';
                                    Get.log('resting');
                                    _countdowncontroller.restart(
                                        duration: rest.value);
                                  }
                                }
                              },
                            ),
                          ),
                          Obx(
                            () => TextWidget(
                              text:
                                  status.value == 'rest' ? 'Rest' : 'Exercise',
                              alignment: Alignment.center,
                              size: 16,
                              weight: FontWeight.bold,
                            ).marginOnly(top: 10),
                          ),
                          verticalSpace(height: 10),
                          SizedBox(
                            height: 40,
                            width: width,
                            child: ElevatedButton(
                              onPressed: status.value == 'rest'
                                  ? () {}
                                  : () {
                                      if (status.value == '' ||
                                          status.value == 'reset') {
                                        status.value = 'play';
                                        _countdowncontroller.start();
                                      } else if (status.value == 'play' ||
                                          status.value == 'rest') {
                                        status.value = 'paused';
                                        _countdowncontroller.pause();
                                      } else if (status.value == 'paused') {
                                        status.value = 'play';
                                        _countdowncontroller.resume();
                                      } else if (status.value == 'finished') {
                                        status.value = 'play';
                                        _countdowncontroller.restart(
                                            duration: duration.value);
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: AppColors.white, backgroundColor: AppColors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: TextWidget(
                                color: AppColors.white,
                                alignment: Alignment.center,
                                text: status.value == '' ||
                                        status.value == 'reset'
                                    ? 'Start Now!'
                                    : status.value == 'play'
                                        ? 'Pause'
                                        : status.value == 'paused'
                                            ? 'Resume'
                                            : status.value == 'finished'
                                                ? "Start"
                                                : status.value == 'rest'
                                                    ? 'Pause'
                                                    : "Stop",
                              ),
                            ),
                          ),
                          verticalSpace(height: 15),
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _countdowncontroller.reset();
                                    status.value = 'reset';
                                    exercise.value = exercise.value - 1;
                                    if (exercise.value <= 0) {
                                      level.value = level.value - 1;
                                      _decrementLevel();
                                    } else {
                                      _decrementExercise();
                                    }
                                  },
                                  child: const Icon(Icons.reply_outlined),
                                ),
                                TextWidget(text: 'Level ${level.value + 1}'),
                                horizontalSpace(width: 10),
                                TextWidget(
                                  text: 'Exercise ${exercise.value + 1}',
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _countdowncontroller.reset();
                                    status.value = 'reset';
                                    exercise.value = exercise.value + 1;
                                    if (exercise.value > 9) {
                                      level.value = level.value + 1;
                                      _updateLevel();
                                    } else {
                                      _updateExercise();
                                    }
                                  },
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math.pi),
                                    child: const Icon(Icons.reply_outlined),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  final bool edit = Get.arguments[0];
  final Rx<PCJ1Model> _journal = PCJ1Model(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _journal.value.name = name.text;
    _journal.value.date = currentTime.text;
    _journal.value.goal = goal.text.isEmpty ? 0 : int.parse(goal.text);
    _journal.value.level = level.value;
    _journal.value.exercise = exercise.value;
    _journal.value.eset = eset.value;
    _journal.value.total = total.value;
    _journal.value.rest = totalRest.value;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _journal.value.duration = _journal.value.duration! + diff;
    } else {
      _journal.value.duration = diff;
    }
  }

  fetchData() {
    _journal.value = Get.arguments[1] as PCJ1Model;
    name.text = _journal.value.name!;
    currentTime.text = _journal.value.date!;
    goal.text = _journal.value.goal!.toString();
    level.value = _journal.value.level!;
    exercise.value = _journal.value.exercise!;
    eset.value = _journal.value.eset!;
    total.value = _journal.value.total!;
    totalRest.value = _journal.value.rest!;
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == sexual);
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
      await sexualRef.doc(_journal.value.id).set(_journal.value.toMap());
      await addAccomplishment(end);
      Get.back();
      if (!fromsave) {
        if (Get.find<SexualController>().history.value.value == 141) {
          Get.find<SexualController>()
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
      await sexualRef.doc(_journal.value.id).update(_journal.value.toMap());
      Get.back();
      if (!fromsave) Get.back();
      customToast(message: 'Updated successfully');
    }
  }
}

class PreviousJournal extends StatelessWidget {
  const PreviousJournal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'PC Journal Level 1 - Strengthing your PC',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: sexualRef
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
              final PCJ1Model model =
                  PCJ1Model.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const PCJournalLvl1(),
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
