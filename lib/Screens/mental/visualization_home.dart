// ignore_for_file: avoid_print, unnecessary_overrides, no_leading_underscores_for_local_identifiers
import 'dart:async';

import 'package:schedular_project/Widgets/dialogs.dart';
import 'package:wakelock/wakelock.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Screens/seek_bar.dart';
import 'package:schedular_project/Screens/mental/v101_create_script.dart';

import '../../Controller/play_routine_controller.dart';
import '../../Functions/functions.dart';
import '../../Global/firebase_collections.dart';
import '../../Model/app_modal.dart';
import '../../Model/app_user.dart';
import '../../Model/visualization_model.dart';
import '../../Services/auth_services.dart';
import '../../Widgets/app_bar.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_toast.dart';
import '../../Widgets/loading_dialog.dart';
import '../../Widgets/text_widget.dart';
import '../../Widgets/widgets.dart';
import '../readings.dart';
import 'lsrt.dart';
import '../custom_bottom.dart';

class VisualizationController extends GetxController {
  final Rx<CurrentExercises> history = CurrentExercises(
    id: visualization,
    index: 12,
    value: 19,
    time: DateTime.now(),
    connectedPractice: 24,
    connectedReading: 19,
    previousPractice: 19,
    previousReading: 19,
    completed: false,
  ).obs;

  late Timer timer;
  @override
  void onInit() async {
    await fetchHistory();
    if (routine) {
      print('started');
      DateTime start = DateTime.now();
      timer = Timer(
        Duration(seconds: Get.find<PlayRoutineController>().duration.value),
        () {
          print(Get.find<PlayRoutineController>().duration.value);
          Get.log('completed');
          infoDialog(start);
        },
      );
    }
    super.onInit();
  }

  List<AppModel> audioList =
      visualizationList.where((val) => val.type == 2).toList();

  List<AppModel> readinglist =
      visualizationList.where((val) => val.type == 1).toList();

  Rx<AppModel> appModel = AppModel('', '').obs;

  Future fetchHistory() async {
    await currentExercises(Get.find<AuthServices>().userid)
        .doc(visualization)
        .get()
        .then((value) async {
      if (value.data() == {} || value.data() == null) {
        await currentExercises(Get.find<AuthServices>().userid)
            .doc(visualization)
            .set(history.value.toMap());
      } else {
        history.value = CurrentExercises.fromMap(value.data());
      }
    });
    appModel.value =
        visualizationList[visualizationIndex(history.value.value!)];
  }

  Future updateReadingHistory(int duration) async {
    if (appModel.value.type == 1) {
      if (history.value.value == 19) {
        userReadings(Get.find<AuthServices>().userid).set({
          'visualization': {
            'value': 0,
            'element': history.value.value,
            'id': visualization
          }
        }, SetOptions(merge: true));
      } else {
        userReadings(Get.find<AuthServices>().userid).update({
          'visualization.element': history.value.value,
        });
      }
      addReadingAccomplishment(duration);
    }
  }

  Future addListening(int duration) async {
    /// 0: fruit, 1: water, 2: progressive muscle relaxation
    /// 4: improve physical strength
    if (appModel.value.type == 2) {
      await userListening(Get.find<AuthServices>().userid).add({
        'value': appModel.value.value,
        'category': 'visualization',
        'type': appModel.value.value! == 22
            ? 0
            : appModel.value.value! == 23
                ? 1
                : appModel.value.value! == 24
                    ? 2
                    : appModel.value.value! == 27
                        ? 3
                        : 4,
      });
    }
    addReadingAccomplishment(duration);
  }

  Future addReadingAccomplishment(int duration) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == visualization);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: appModel.value.title,
        count: 1,
        duration: duration,
        id: '',
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addAdvancedAccomplishment() async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == visualization);
    if (list.isNotEmpty) {
      list.first.advanced = appModel.value.title;
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future updateHistory(int duration,
      {bool added = false, bool fromlistening = false}) async {
    if (history.value.value != 34 && !history.value.completed!) {
      await updateReadingHistory(duration);
      if (!added) addListening(duration);
      history.value.value = history.value.value! + 1;
      if (history.value.value == 30) history.value.value = 31;
      _updateData();
      if (fromlistening) Get.back();
    } else if (history.value.value == 34) {
      await updateReadingHistory(duration);
      if (!added) addListening(duration);
      history.value.value = 31;
      history.value.completed = true;
      _updateData();
      if (fromlistening) Get.back();
    }
  }

  _updateData() async {
    final _intro = visualizationList[visualizationIndex(history.value.value!)];
    history.value.previousPractice = _intro.prePractice ?? history.value.value;
    history.value.connectedPractice =
        _intro.connectedPractice ?? history.value.value;
    history.value.connectedReading =
        _intro.connectedReading ?? history.value.value;
    history.value.previousReading = _intro.preReading ?? history.value.value;
    await currentExercises(Get.find<AuthServices>().userid)
        .doc(history.value.id)
        .update(history.value.toMap());
    await fetchHistory();
    await addAdvancedAccomplishment();
  }

  selectData(int value) {
    appModel.value = visualizationList[visualizationIndex(value)];
    history.value = CurrentExercises(
      id: visualization,
      index: 12,
      value: value,
      time: DateTime.now(),
      completed: false,
      connectedPractice: appModel.value.connectedPractice ?? value,
      connectedReading: appModel.value.connectedReading ?? value,
      previousPractice: appModel.value.prePractice ?? value,
      previousReading: appModel.value.preReading ?? value,
    );
  }

  bool routine = Get.arguments[0];

  @override
  void onClose() {
    if (routine) {
      timer.cancel();
      print('cancelled');
    }
    // Get.find<PlayRoutineController>().completeElement();
    super.onClose();
  }
}

class VisualizationHome extends StatelessWidget {
  VisualizationHome({Key? key}) : super(key: key);
  final VisualizationController controller = Get.put(VisualizationController());

  Future updateListeningIndex(int value, DateTime initial) async {
    final end = DateTime.now();
    final diff = end.difference(initial).inSeconds;
    switch (value) {
      case 22:
      case 23:
      case 24:
      case 27:
        controller.updateHistory(diff, fromlistening: true);
        break;
    }
  }

  connectedReading(int value, DateTime initial) {
    final end = DateTime.now();
    switch (value) {
      case 22:
        // Get.to(() => const GuidedVisualizationFruitReading());
        Get.to(
          () => ReadingScreen(
            title:
                'Guided Visualization for Improving Physical Strength -Fruit',
            link:
                'https://docs.google.com/document/d/1YMyAu6mW6tEnp7RQBodgPMk7t3FVcBVp/',
            linked: () {
              Get.to(
                () => GuidedVisualization(
                  fromExercise: true,
                  entity: visualizationList[visualizationIndex(22)],
                  connectedReading: () => Get.back(),
                  onfinished: () => Get.back(),
                ),
              );
            },
            function: () {
              if (Get.find<VisualizationController>().history.value.value ==
                  21) {
                debugPrint('disposing');
                Get.find<VisualizationController>()
                    .updateHistory(end.difference(initial).inSeconds);
                debugPrint('disposed');
              }
              Get.log('closed');
            },
          ),
        );
        break;
      case 23:
        // Get.to(() => const WhatIsVisualizationReading());
        Get.to(
          () => ReadingScreen(
            title: 'V100- What is Visualization? ',
            link:
                'https://docs.google.com/document/d/1mWPm4jf9I0IF-4G9rPEX_icsxB74Ap17/',
            linked: () {
              Get.to(
                () => GuidedVisualization(
                  fromExercise: true,
                  entity: visualizationList[visualizationIndex(23)],
                  connectedReading: () => Get.back(),
                  onfinished: () => Get.back(),
                ),
              );
            },
            function: () {
              if (Get.find<VisualizationController>().history.value.value ==
                  20) {
                debugPrint('disposing');
                Get.find<VisualizationController>()
                    .updateHistory(end.difference(initial).inSeconds);
                debugPrint('disposed');
              }
              Get.log('closed');
            },
          ),
        );
        break;
      case 24:
        // Get.to(() => const WhatIsVisualizationReading());
        Get.to(
          () => ReadingScreen(
            title: 'V100- What is Visualization? ',
            link:
                'https://docs.google.com/document/d/1mWPm4jf9I0IF-4G9rPEX_icsxB74Ap17/',
            linked: () {
              Get.to(
                () => GuidedVisualization(
                  fromExercise: true,
                  entity: visualizationList[visualizationIndex(24)],
                  connectedReading: () => Get.back(),
                  onfinished: () => Get.back(),
                ),
              );
            },
            function: () {
              if (Get.find<VisualizationController>().history.value.value ==
                  20) {
                debugPrint('disposing');
                Get.find<VisualizationController>()
                    .updateHistory(end.difference(initial).inSeconds);
                debugPrint('disposed');
              }
              Get.log('closed');
            },
          ),
        );
        break;
      case 27:
        // Get.to(() => const GuidedVisualizationReading());
        Get.to(
          () => ReadingScreen(
            title:
                'Guided Visualization for Improving Physical Strength - Workout',
            link:
                'https://docs.google.com/document/d/1bE9_jphBA1WgvoufwVHOuFYaENqxAxiB/',
            linked: () {
              Get.to(
                () => GuidedVisualization(
                  fromExercise: true,
                  entity: visualizationList[visualizationIndex(27)],
                  connectedReading: () => Get.back(),
                  onfinished: () => Get.back(),
                ),
              );
            },
            function: () {
              if (Get.find<VisualizationController>().history.value.value ==
                  26) {
                debugPrint('disposing');
                Get.find<VisualizationController>()
                    .updateHistory(end.difference(initial).inSeconds);
                debugPrint('disposed');
              }
              Get.log('closed');
            },
          ),
        );
        break;
    }
  }

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
              headline('Visualization').marginOnly(bottom: 30),
              TopList(
                list: visualizationList,
                onchanged: (val) {},
                // (val) => controller
                //     .selectData(val), // controller.history.value.value = val;
                value: controller.history.value
                    .value!, //controller.history.value.value == 34
                // ? controller.history.value.value!
                // : controller.history.value.connectedReading ==
                //         controller.history.value.value
                //     ? controller.history.value.connectedPractice ??
                //         controller.history.value.value!
                //     :
                play: controller.appModel.value.type == 1 ||
                        controller.appModel.value.type == 0
                    ? controller.appModel.value.ontap
                    : controller.appModel.value.type == 2
                        ? () {
                            final start = DateTime.now();
                            Get.to(
                              () => GuidedVisualization(
                                fromExercise: true,
                                entity: controller.appModel.value,
                                onfinished: () => updateListeningIndex(
                                    controller.history.value.value!, start),
                                connectedReading: () => connectedReading(
                                    controller.history.value.value!, start),
                              ),
                            );
                          }
                        : () {},
              ),
              Column(
                children: [
                  AppButton(
                    onTap: () => Get.to(() => const GuidedVisualization()),
                    title: 'Guided Visualization',
                    description:
                        'Listen to a guided audio visualization or to one of the visualizations you have created.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => const FreeVisualization()),
                    title: 'Free Visualization',
                    description:
                        'Visualize without an accompanying guided audio and set your own custom duration.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => const CIVisualization()),
                    title: 'Create/ Improve a Visualization',
                    description:
                        'Create a new visualization or improve upon a visualization you created in the past.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => VisualizationReadings()),
                    title: 'Visualization Library',
                    description:
                        'Gain knowledge that unlocks visualization techniques with massive practical wellness benefits.',
                  ).marginOnly(bottom: 30),
                ],
              ).marginOnly(left: 25, right: 25),
            ],
          ),
        ),
      ),
    );
  }
}

class CIVisualization extends StatelessWidget {
  const CIVisualization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 10),
        child: Column(
          children: [
            headline('Create/Improve a Visualization').marginOnly(bottom: 50),
            const TextWidget(
              text:
                  'Will you make a new visualization or improve an existing visualization?',
              size: 15,
            ).marginOnly(left: 35, right: 35, bottom: 70),
            CustomOutlineButton(
              title: 'Create a new Visualization',
              ontap:
                  // Get.find<VisualizationController>().history.value.value ==
                  //             28 ||
                  Get.find<VisualizationController>().history.value.value! >= 25
                      ? () => Get.to(
                            () => const V101CreateScript(),
                            arguments: [false],
                          )
                      : () {},
              weight: FontWeight.bold,
              size: 16,
            ).marginOnly(left: 25, right: 25, bottom: height * 0.2),
            CustomOutlineButton(
              title: 'Improve a Visualization',
              ontap:
                  Get.find<VisualizationController>().history.value.value! >= 29
                      ? () => Get.to(() => const LSRT(), arguments: [false])
                      : () {},
              weight: FontWeight.bold,
              size: 16,
            ).marginOnly(left: 25, right: 25, bottom: 50),
          ],
        ),
      ),
    );
  }
}

class FreeVisualization extends StatefulWidget {
  const FreeVisualization({Key? key}) : super(key: key);

  @override
  State<FreeVisualization> createState() => _FreeVisualizationState();
}

class _FreeVisualizationState extends State<FreeVisualization> {
  final RxInt type = 0.obs;
  final RxInt seconds = 0.obs;
  final Rx<DateTime> start = DateTime.now().obs;
  final Rx<DateTime> end = DateTime.now().obs;
  final RxString topic = ''.obs;

  Future addFreeBreathing() async {
    loadingDialog(context);
    final FreeBreathing _breathing = FreeBreathing(
      id: generateId(),
      seconds: end.value.difference(start.value).inSeconds,
      start: start.value,
      end: end.value,
      category: 'visualization',
      topic: topic.value,
    );
    await freeExercises(Get.find<AuthServices>().userid)
        .doc(_breathing.id)
        .set(_breathing.toMap());
    Get.back();
    Get.back();
  }

  RxString startCountdown = ''.obs;
  final CountDownController _countDownController = CountDownController();

  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 15,
            bottom: 10,
          ),
          child: Column(
            children: [
              FreeTop(
                title: 'Visualization',
                subtitle:
                    'Visualize without an accompanying guided audio and set your own custom duration.',
                type: 0,
                seconds: seconds.value,
                typelist: freeMindfulList,
                text: true,
                topic: topic.value,
                ontopicChanged: (val) => topic.value = val,
                changeDuration: () async {
                  await customDurationPicker(initialMinutes: seconds.value)
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        seconds.value = value.inSeconds;
                      });
                    }
                  });
                },
              ),

              ///
              CustomCountdown(
                controller: _countDownController,
                duration: seconds.value,
                onStart: () => startCountdown.value = 'play',
                onComplete: () =>
                    {startCountdown.value = '', playAlarm(_player)},
                caption: 'Visualize',
              ).marginOnly(bottom: 50),
              CustomBottom(
                start: startCountdown.value == ''
                    ? 'Visualize Now!'
                    : startCountdown.value == 'play'
                        ? 'Pause'
                        : 'Visualize Now!',
                player: _player,
                onVolumeChanged: (val) {
                  setState(() {
                    _player.setVolume(val);
                  });
                },
                onstart: () async {
                  bool check = await Wakelock.enabled;
                  if (!check) await Wakelock.enable();
                  if (seconds.value != 0) {
                    if (startCountdown.value == '') {
                      start.value = DateTime.now();
                      _countDownController.restart(duration: seconds.value);
                    } else if (startCountdown.value == 'play') {
                      _countDownController.pause();
                      startCountdown.value = 'paused';
                    } else if (startCountdown.value == 'paused') {
                      _countDownController.resume();
                      startCountdown.value = 'play';
                    } else {
                      customToast(message: 'Countdown started already');
                    }
                  } else {
                    customToast(message: 'Please select a duration first');
                  }
                  setState(() {});
                },
                onfinished: () async {
                  if (startCountdown.value == 'play') {
                    _countDownController.pause();
                  }
                  end.value = DateTime.now();
                  bool check = await Wakelock.enabled;
                  if (check) await Wakelock.disable();
                  setState(() {});
                  await addFreeBreathing();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GuidedVisualization extends StatefulWidget {
  const GuidedVisualization({
    Key? key,
    this.fromExercise = false,
    this.entity,
    this.onfinished,
    this.connectedReading,
  }) : super(key: key);
  final bool fromExercise;
  final AppModel? entity;
  final VoidCallback? onfinished, connectedReading;

  @override
  State<GuidedVisualization> createState() => _GuidedVisualizationState();
}

class _GuidedVisualizationState extends State<GuidedVisualization> {
  final VisualizationController controller = Get.find();
  final RxInt audio = 22.obs;
  final RxString audiolink =
      (visualizationList[visualizationIndex(22)].description).obs;
  final AudioPlayer _player = AudioPlayer();
  final RxList<AppModel> _visalizations = <AppModel>[].obs;
  final RxInt indexes = 0.obs;

  Future fetchScripts() async {
    await scriptRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 'visualization')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          ScriptModel _script = ScriptModel.fromMap(doc);
          if (_script.link != '') {
            indexes.value = indexes.value + 1;
            _visalizations.add(
              AppModel(
                _script.topic!,
                _script.detail!,
                value: indexes.value,
                link: _script.link,
                docid: _script.id,
              ),
            );
          }
        }
        return true;
      }
    });
    setState(() {});
  }

  Future fetchlsrtScripts() async {
    await lsrtRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .orderBy('created', descending: true)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          LsrtModel _script = LsrtModel.fromMap(doc);
          if (_script.audio != '') {
            indexes.value = indexes.value + 1;
            _visalizations.add(
              AppModel(
                _script.title!,
                _script.script!,
                value: indexes.value,
                link: _script.audio!,
                docid: _script.id,
              ),
            );
          }
        }
        return true;
      }
    });
    setState(() {});
  }

  Future setLists([bool fromExercise = false]) async {
    if (fromExercise) {
      for (int i = 0; i < controller.audioList.length; i++) {
        if (controller.audioList[i].value! <= controller.history.value.value!) {
          indexes.value = i;
          _visalizations.add(controller.audioList[i]);
        }
      }
    } else {
      for (int i = 0; i < controller.audioList.length; i++) {
        indexes.value = i;
        _visalizations.add(controller.audioList[i]);
      }
    }
    print(indexes.value);
    await fetchScripts();
    await fetchlsrtScripts();
  }

  setAudioUrl() async {
    if (widget.fromExercise) {
      audio.value = widget.entity!.value!;
      audiolink.value = widget.entity!.description;
    }
    if (audiolink.contains('https:')) {
      await _player.setUrl(audiolink.value);
    } else {
      await _player.setAsset(audiolink.value);
    }
    setLists();
  }

  _seturl(int val) async {
    _player.pause();
    audio.value = val;
    audiolink.value = _visalizations[_viusalizationIndex(audio.value)].link!;
    if (audiolink.value.contains('assets/')) {
      print('----setting assets-----');
      await _player.setAsset(audiolink.value);
    } else {
      print('----setting url-----');
      await _player.setUrl(audiolink.value);
    }
    setState(() {});
  }

  @override
  void initState() {
    setState(() {
      setAudioUrl();
    });
    super.initState();
  }

  int _viusalizationIndex(int value) =>
      _visalizations.indexWhere((element) => element.value == value);

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 20),
          child: Column(
            children: [
              GuidedTop(
                title: 'Visualization',
                subtitle:
                    'Visualize with ease by following premade guided visualization audios. ',
                value: audio.value,
                list: _visalizations,
                fromExercise: widget.fromExercise,
                onchanged:
                    widget.fromExercise ? null : (val) async => _seturl(val),
                connectedReading: widget.connectedReading,
              ),
              AudioProgressBar(player: _player, title: 'Visualize')
                  .marginOnly(bottom: 30),
              CustomBottom(
                start: 'Visualize Now!',
                player: _player,
                playing: _player.playing,
                onstart: () async {
                  if (!_player.playing) {
                    _player.play();
                  } else {
                    _player.pause();
                  }
                  setState(() {});
                },
                onfinished: widget.fromExercise
                    ? widget.onfinished
                    : () async {
                        if (_player.playing) _player.pause();
                        String id = generateId();
                        await guided(Get.find<AuthServices>().userid)
                            .doc(id)
                            .set({
                          'id': id,
                          'audio': audio.value,
                          'link': audiolink.value,
                          'type': 'visualization',
                        });
                        // if (Get
                        //                 .find<VisualizationController>()
                        //             .history
                        //             .value
                        //             .value ==
                        //         22 ||
                        //     Get
                        //                 .find<VisualizationController>()
                        //             .history
                        //             .value
                        //             .value ==
                        //         23 ||
                        //     Get.find<VisualizationController>()
                        //             .history
                        //             .value
                        //             .value ==
                        //         24 ||
                        //     Get.find<VisualizationController>()
                        //             .history
                        //             .value
                        //             .value ==
                        //         27) {
                        //   Get.find<VisualizationController>().updateHistory(end.difference(initial).inSeconds);
                        // }
                        Get.back();
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
}

class VisualizationReadings extends StatelessWidget {
  VisualizationReadings({Key? key}) : super(key: key);
  final VisualizationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 15,
          left: 10,
          right: 10,
          bottom: 10,
        ),
        child: Column(
          children: [
            headline('Visualization Library').marginOnly(bottom: 20),
            CustomContainer(
              background: const Color(0xffD6E9FF),
              child: ExpansionTile(
                initiallyExpanded: true,
                tilePadding: EdgeInsets.zero,
                trailing: const SizedBox.shrink(),
                childrenPadding: const EdgeInsets.only(
                  left: 15,
                  right: 10,
                  bottom: 30,
                ),
                title: Row(
                  children: [
                    const Icon(Icons.keyboard_arrow_down),
                    SizedBox(
                      width: width * 0.78,
                      child: elementTitle('Visualization'),
                    ),
                  ],
                ),
                children: List.generate(
                  controller.readinglist.length,
                  (index) => InkWell(
                    onTap: controller.readinglist[index].value! <=
                                controller.history.value.value! ||
                            controller.history.value.completed!
                        ? controller.readinglist[index].ontap
                        : () {},
                    child: elementTitle2(controller.readinglist[index].title)
                        .marginOnly(bottom: 7),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
