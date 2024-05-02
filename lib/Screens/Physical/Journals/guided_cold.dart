// ignore_for_file: avoid_print

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/cold_model.dart';
import 'package:schedular_project/Model/exercise_models.dart';
import 'package:schedular_project/Screens/custom_bottom.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';

import '../../../Model/app_user.dart';
import '../../../Widgets/app_bar.dart';
import '../../../Widgets/spacer_widgets.dart';
import '../../../Widgets/text_widget.dart';
import 'dart:math' as math;

import '../../readings.dart';
import '../../seek_bar.dart';
import '../cold_home.dart';

class GuidedColdScreen extends StatefulWidget {
  const GuidedColdScreen({Key? key}) : super(key: key);

  @override
  State<GuidedColdScreen> createState() => _GuidedColdScreenState();
}

class _GuidedColdScreenState extends State<GuidedColdScreen> {
  RxInt type = 0.obs;
  RxInt exercise = (coldexercises[0].level![0].exercises![0].index!).obs;
  RxInt level = (coldexercises[0].level![0].level!).obs;
  RxInt duration = (coldexercises[0].level![0].exercises![0].time!).obs;

  final CountDownController _countDownController = CountDownController();
  RxString status = ''.obs;

  final Rx<ColdExercises> _exercise = (coldexercises[0]).obs;
  RxInt levelIndex = 0.obs;
  RxInt exercisIndex = 0.obs;
  RxInt total = 0.obs;

  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  selectExercise() {
    if (status.value == 'play') _countDownController.pause();
    if (status.value == 'play') status.value = 'pause';
    if (status.value == 'play') status.value = '';
    _exercise.value = coldexercises[coldexercisesIndex(type.value)];
    Get.log(_exercise.value.name!);
    if (level.value != 29) {
      level.value = _exercise.value.level![levelIndex.value].level!;
      if (exercise.value != 4) {
        exercise.value = _exercise.value.level![levelIndex.value]
            .exercises![exercisIndex.value].index!;
        duration.value = _exercise.value.level![levelIndex.value]
            .exercises![exercisIndex.value].time!;
      } else {
        level.value = _exercise.value.level![0].level!;
        exercise.value = _exercise.value.level![0].exercises![0].index!;
        duration.value = _exercise.value.level![0].exercises![0].time!;
        levelIndex.value = 0;
        exercisIndex.value = 0;
      }
    } else {
      level.value = _exercise.value.level![0].level!;
      exercise.value = _exercise.value.level![0].exercises![0].index!;
      duration.value = _exercise.value.level![0].exercises![0].time!;
      levelIndex.value = 0;
      exercisIndex.value = 0;
    }
  }

  _setLevel() {
    if (status.value == 'play') _countDownController.pause();
    if (status.value == 'play') status.value = 'pause';
    if (status.value == 'play') status.value = '';
    if (levelIndex.value != 29) {
      levelIndex.value = levelIndex.value + 1;
      level.value = _exercise.value.level![levelIndex.value].level!;
      exercisIndex.value = 0;
      _setExercise(true);
    } else {}
  }

  _setExercise([bool fromLevel = false]) {
    if (status.value == 'play') _countDownController.pause();
    if (status.value == 'play') status.value = 'pause';
    if (status.value == 'play') status.value = '';
    if (exercisIndex.value != 4) {
      if (!fromLevel) exercisIndex.value = exercisIndex.value + 1;
      exercise.value = _exercise
          .value.level![levelIndex.value].exercises![exercisIndex.value].index!;
      duration.value = _exercise
          .value.level![levelIndex.value].exercises![exercisIndex.value].time!;
    } else {
      _setLevel();
    }
  }

  _previousExercise([bool fromLevel = false]) {
    if (status.value == 'play') _countDownController.pause();
    if (status.value == 'play') status.value = 'pause';
    if (status.value == 'play') status.value = '';
    if (exercisIndex.value != 0) {
      if (!fromLevel) exercisIndex.value = exercisIndex.value - 1;
      exercise.value = _exercise
          .value.level![levelIndex.value].exercises![exercisIndex.value].index!;
      duration.value = _exercise
          .value.level![levelIndex.value].exercises![exercisIndex.value].time!;
    } else {
      _previousLevel();
    }
  }

  _previousLevel() {
    if (status.value == 'play') _countDownController.pause();
    if (status.value == 'play') status.value = 'pause';
    if (status.value == 'play') status.value = '';
    if (levelIndex.value != 0) {
      levelIndex.value = levelIndex.value - 1;
      level.value = _exercise.value.level![levelIndex.value].level!;
      exercisIndex.value = 0;
      _setExercise(true);
    } else {}
  }

  _updateTotal() => total.value = total.value + duration.value;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 10,
            bottom: 10,
          ),
          child: Column(
            children: [
              GuidedTop(
                title: 'Cold Exposure',
                subtitle:
                    'Increase your cold exposure systematically in small, easy-to-handle durations to improve with minimal effort and planning. ',
                value: type.value,
                onchanged: (val) {
                  type.value = val;
                  selectExercise();
                },
                list: guidedColdOptions,
                choose: 'Choose Cold Type',
                connectedReading: () => Get.to(
                  () => ReadingScreen(
                    title:
                        'Cold - Supercharge your Immune System, Resilience to Stress, and Energy',
                    link:
                        'https://docs.google.com/document/d/1AkeIS_IbXonuXs4gBdH009GyB1sqHasc/',
                    linked: () => Get.back(),
                    function: ()  {
                      if (Get.find<ColdController>().history.value.value == 134)
                        {
                           final end = DateTime.now();
                          Get.find<ColdController>().updateHistory(end.difference(initial).inSeconds);
                        }
                      Get.log('closed');
                    },
                  ),
                ),
                // () => Get.to(() => const ColdSuperchargeReading()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _previousExercise();
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.reply_outlined),
                        TextWidget(text: 'Level ${level.value}'),
                      ],
                    ),
                  ),
                  horizontalSpace(width: 10),
                  GestureDetector(
                    onTap: () {
                      _setExercise();
                    },
                    child: Row(
                      children: [
                        TextWidget(text: 'Exercise ${exercise.value}'),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: const Icon(Icons.reply_outlined),
                        ),
                      ],
                    ),
                  ),
                ],
              ).marginOnly(bottom: 30, left: 30, right: 30),
              CustomCountdown(
                controller: _countDownController,
                duration: duration.value,
                onStart: () => status.value = 'play',
                onComplete: () async {
                  status.value = '';
                  _updateTotal();
                  _setExercise();
                  await playAlarm(_player);
                  // playAudioAlarm();
                  // _countDownController.restart(duration: duration.value);
                },
                caption: 'Cold',
              ),
              CustomBottom(
                player: _player,
                start: status.value == 'play' ? 'Pause' : 'Thrive Now!',
                onstart: () {
                  if (status.value == '') {
                    _countDownController.restart(duration: duration.value);
                  } else if (status.value == 'play') {
                    status.value == 'pause';
                    _countDownController.pause();
                  } else if (status.value == 'pause') {
                    status.value = 'play';
                    _countDownController.resume();
                    // _countDownController.restart(duration: duration.value);
                  }
                  print(status.value);
                  print(_countDownController.getTime());
                  setState(() {});
                },
                onfinished: () async {
                  if (status.value == 'play') _countDownController.pause();
                  if (status.value == 'play') status.value = 'pause';
                  await addJournal();
                },
                onVolumeChanged: (val) {
                  setState(() {
                    _player.setVolume(val);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  final bool edit = Get.arguments[0];
  final Rx<GuidedColdModel> _journal = GuidedColdModel(
    userid: Get.find<AuthServices>().userid,
    id: generateId(),
  ).obs;
  
  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _journal.value.option = type.value;
    // _journal.value.duration = getDurationString(total.value);
    _journal.value.seconds = total.value;
    _journal.value.level = levelIndex.value;
    _journal.value.exercise = exercisIndex.value;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _journal.value.duration = _journal.value.duration! + diff;
    } else {
      _journal.value.duration = diff;
    }
  }

  fetchData() async {
    // _journal.value = Get.arguments[1] as GuidedColdModel;
    await coldRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 0)
        .orderBy('created', descending: true)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          _journal.value = GuidedColdModel.fromMap(doc);
          type.value = _journal.value.option!;
          total.value = _journal.value.seconds!;
          if (_journal.value.level == 29) {
            levelIndex.value = 0;
            exercisIndex.value = 0;
          } else {
            if (_journal.value.exercise == 4) {
              levelIndex.value = _journal.value.level! + 1;
              exercisIndex.value = 0;
            } else {
              levelIndex.value = _journal.value.level!;
              exercisIndex.value = _journal.value.exercise! + 1;
            }
          }
          _exercise.value = coldexercises[coldexercisesIndex(type.value)];
          level.value = _exercise.value.level![levelIndex.value].level!;
          exercise.value = _exercise.value.level![levelIndex.value]
              .exercises![exercisIndex.value].index!;
          duration.value = _exercise.value.level![levelIndex.value]
              .exercises![exercisIndex.value].time!;
          print(duration.value);
        }
      }
    });
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == cold);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: guidedColdOptions[guidedColdIndex(type.value)].title,
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
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    if (edit) {
      await coldRef.doc(_journal.value.id).update(_journal.value.toMap());
    } else {
      await coldRef.doc(_journal.value.id).set(_journal.value.toMap());
    }
    await addAccomplishment(end);
    Get.back();
    if (!fromsave) {
      if (Get.find<ColdController>().history.value.value == 136) {
        Get.find<ColdController>().updateHistory(end.difference(initial).inSeconds);
      }
      Get.back();
    }
    customToast(message: edit ? 'Updated successfully' : 'Added successfully');
  }
}
