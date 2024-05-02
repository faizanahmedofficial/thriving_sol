// ignore_for_file: use_key_in_widget_constructors, avoid_print, no_leading_underscores_for_local_identifiers
import 'dart:async';

import 'package:wakelock/wakelock.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/app_modal.dart';
import 'package:schedular_project/Screens/custom_bottom.dart';
import 'package:schedular_project/Screens/seek_bar.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_button.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/text_widget.dart';
import 'package:get/get.dart';
import '../../Controller/play_routine_controller.dart';
import '../../Model/app_user.dart';

import '../../Widgets/custom_toast.dart';
import '../../Widgets/dialogs.dart';
import '../../Widgets/widgets.dart';
import '../readings.dart';

class BreathingController extends GetxController {
  final Rx<CurrentExercises> history = CurrentExercises(
    id: breathing,
    index: 1,
    value: 5,
    time: DateTime.now(),
    connectedReading: 7,
    connectedPractice: 5,
    previousPractice: 5,
    previousReading: 5,
    completed: false,
  ).obs;

  late Timer timer;
  @override
  void onInit() async {
    await fetchHistory();
    if (routine) {
      DateTime start = DateTime.now();
      timer = Timer(
        Duration(seconds: Get.find<PlayRoutineController>().duration.value),
        () {
          Get.log('completed');
          infoDialog(start);
        },
      );
    }
    super.onInit();
  }

  List<AppModel> audioList =
      breathingList.where((val) => val.type == 2).toList();

  Future fetchHistory() async {
    await currentExercises(Get.find<AuthServices>().userid)
        .doc(breathing)
        .get()
        .then((value) async {
      if (value.data() == {} || value.data() == null) {
        await currentExercises(Get.find<AuthServices>().userid)
            .doc(breathing)
            .set(history.value.toMap());
      } else {
        history.value = CurrentExercises.fromMap(value.data());
      }
    });
    appModel.value = breathingList[breathingListIndex(history.value.value!)];
  }

  Rx<AppModel> appModel = AppModel('', '').obs;
  Future updateReadingHistory(int duration) async {
    if (appModel.value.type == 1) {
      userReadings(Get.find<AuthServices>().userid).update({
        'breathing.element': history.value.value,
      });
      await addReadingAccomplishment(duration);
    }
  }

  Future addReadingAccomplishment(int duration) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == breathing);
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
      print('added');
    }
  }

  Future addAdvancedAccomplishment() async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == breathing);
    if (list.isNotEmpty) {
      list.first.advanced = appModel.value.title;
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addListening(int duration) async {
    /// 0: one breath, 1: deep breathing, 2: 3 stage breathing
    /// 4: harmonic breathing
    if (appModel.value.type == 2) {
      await userListening(Get.find<AuthServices>().userid).add({
        'value': appModel.value.value,
        'category': 'breathing',
        'type': appModel.value.value! <= 6
            ? 0
            : appModel.value.value! <= 10
                ? 1
                : appModel.value.value! <= 14
                    ? 2
                    : appModel.value.value! <= 18
                        ? 3
                        : 4,
      });
      addReadingAccomplishment(duration);
      print('added');
    }
  }

  Future updateHistory(int duration,
      {bool added = false, bool fromlistening = false}) async {
    if (history.value.value != 18 && !history.value.completed!) {
      await updateReadingHistory(duration);
      if (!added) await addListening(duration);
      history.value.value = history.value.value! + 1;
      _updateData();
      if (fromlistening) Get.back();
    } else if (history.value.value == 18) {
      await updateReadingHistory(duration);
      if (!added) await addListening(duration);
      history.value.value = 18;
      history.value.completed = true;
      await _updateData();
      if (fromlistening) Get.back();
    }
  }

  _updateData() async {
    final _intro = breathingList[breathingListIndex(history.value.value!)];
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

  List<AppModel> get readingList =>
      breathingList.where((element) => element.type == 1).toList();

  selectData(int value) {
    appModel.value = breathingList[breathingListIndex(value)];
    history.value = CurrentExercises(
      id: breathing,
      index: 1,
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
    if (routine) timer.cancel();
    //  Get.find<PlayRoutineController>().completeElement();
    super.onClose();
  }
}

class BreathingHomeScreen extends StatelessWidget {
  BreathingHomeScreen({Key? key}) : super(key: key);
  final BreathingController controller = Get.put(BreathingController());

  Future updateListeningIndex(int value, DateTime initial) async {
    print('finishing');
    final end = DateTime.now();
    final diff = end.difference(initial).inSeconds;
    switch (value) {
      case 5:
      case 6:
      case 9:
        controller.updateHistory(diff, fromlistening: true);
        break;
      case 10:
        {
          controller.addListening(end.difference(initial).inSeconds);
          await userListening(Get.find<AuthServices>().userid)
              .where('type', isEqualTo: 1)
              .where('category', isEqualTo: 'breathing')
              .get()
              .then((value) {
            if (value.docs.isNotEmpty) {
              if (value.docs.length >= 3) {
                controller.updateHistory(diff,
                    added: true, fromlistening: true);
              } else {
                Get.back();
              }
            } else {
              Get.back();
            }
          });
        }
        break;
      case 12:
      case 13:
        controller.updateHistory(diff, fromlistening: true);
        break;
      case 14:
        {
          controller.addListening(diff);
          await userListening(Get.find<AuthServices>().userid)
              .where('type', isEqualTo: 2)
              .where('category', isEqualTo: 'breathing')
              .get()
              .then((value) {
            if (value.docs.isNotEmpty) {
              if (value.docs.length >= 3) {
                controller.updateHistory(diff,
                    added: true, fromlistening: true);
              } else {
                Get.back();
              }
            } else {
              Get.back();
            }
          });
        }
        break;
      case 16:
      case 17:
      case 18:
        controller.updateHistory(diff, fromlistening: true);
        break;
    }
  }

  connectedReading(int value, DateTime initial) {
    switch (value) {
      case 5:
      case 6:
        Get.to(
          () => ReadingScreen(
            title:
                'B Intro- Unlock the Anti-Stress Pathway and Build a Base to Exploring Your Inner World',
            link:
                'https://docs.google.com/document/d/1qw78rEKZDog52DV5Vblx-cdjaJCAfUmY',
            linked: () {
              Get.to(
                () => GuidedBreathingScreen(
                  fromExercise: true,
                  entity: breathingList[breathingListIndex(5)],
                  connectedReading: () => Get.back(),
                  onfinished: () => Get.back(),
                ),
              );
            },
            function: () {
              final end = DateTime.now();
              if (Get.find<BreathingController>().history.value.value == 7) {
                Get.find<BreathingController>()
                    .updateHistory(end.difference(initial).inSeconds);
              }
            },
          ),
        );
        // Get.to(() => const BIntroReading());
        break;
      case 9:
      case 10:
        Get.to(
          () => ReadingScreen(
            title: 'B100- Just Breath',
            link:
                'https://docs.google.com/document/d/1IV1Wbp0KY0wMF99JXYmpS75NB84tMllJ/',
            linked: () => Get.to(
              () => GuidedBreathingScreen(
                fromExercise: true,
                entity: breathingList[breathingListIndex(9)],
                onfinished: () => Get.back(),
                connectedReading: () => Get.back(),
              ),
            ),
            function: () {
              final end = DateTime.now();
              if (Get.find<BreathingController>().history.value.value == 8) {
                Get.find<BreathingController>()
                    .updateHistory(end.difference(initial).inSeconds);
              }
            },
          ),
        );
        // Get.to(() => const B100Reading());
        break;
      case 12:
      case 13:
      case 14:
        Get.to(
          () => ReadingScreen(
            title: 'B101- 3 Stage Breathing',
            link:
                'https://docs.google.com/document/d/1K3ms2VevzA9pduRSE0awRWRKnYEnmbHV/',
            linked: () => Get.to(
              () => GuidedBreathingScreen(
                fromExercise: true,
                entity: breathingList[breathingListIndex(12)],
                onfinished: () => Get.back(),
                connectedReading: () => Get.back(),
              ),
            ),
            function: () {
              final end = DateTime.now();
              if (Get.find<BreathingController>().history.value.value == 11) {
                Get.find<BreathingController>()
                    .updateHistory(end.difference(initial).inSeconds);
              }
              Get.log('closed');
            },
          ),
        );
        // Get.to(() => const B101Reading());
        break;
      case 16:
      case 17:
      case 18:
        Get.to(
          () => ReadingScreen(
            title: 'B102- Secret Ingredient',
            link:
                'https://docs.google.com/document/d/1HHWUuIsn32c1zGFq73iBpGMctWeEerX-/',
            linked: () => Get.to(
              () => GuidedBreathingScreen(
                fromExercise: true,
                entity: breathingList[breathingListIndex(16)],
                onfinished: () {},
                connectedReading: () => Get.back(),
              ),
            ),
            function: () {
              final end = DateTime.now();
              if (Get.find<BreathingController>().history.value.value == 15) {
                Get.find<BreathingController>()
                    .updateHistory(end.difference(initial).inSeconds);
              }
              Get.log('closed');
            },
          ),
        );
        // Get.to(() => const B102Reading());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              headline('Breathing').marginOnly(bottom: 30),
              TopList(
                list: breathingList,
                value: controller.history.value.value!,
                onchanged: (val) {},
                // (val) => controller.selectData(val), // controller.history.value.value = val;,
                play: controller.appModel.value.type == 1
                    ? controller.appModel.value.ontap
                    : controller.appModel.value.type == 2
                        ? () {
                            final start = DateTime.now();
                            Get.to(
                              () => GuidedBreathingScreen(
                                fromExercise: true,
                                entity: controller.appModel.value,
                                connectedReading: () => connectedReading(
                                    controller.history.value.value!, start),
                                onfinished: () => updateListeningIndex(
                                    controller.history.value.value!, start),
                              ),
                            );
                          }
                        : () {},
              ),
              Column(
                children: [
                  AppButton(
                    onTap: () => Get.to(() => const GuidedBreathingScreen()),
                    title: 'Guided Breathing',
                    description:
                        'Breathe easy with step-by-step guided breathing audios. ',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => const FreeBreathingScreen()),
                    title: 'Free Breathing',
                    description:
                        'Breathe without an accompanying guided audio and set your own custom duration.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => BreathingReadings()),
                    title: 'Breathing Library',
                    description:
                        'Gain knowledge that unlocks breathing techniques with massive practical wellness benefits.',
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

class FreeBreathingScreen extends StatefulWidget {
  const FreeBreathingScreen({Key? key}) : super(key: key);

  @override
  State<FreeBreathingScreen> createState() => _FreeBreathingScreenState();
}

class _FreeBreathingScreenState extends State<FreeBreathingScreen> {
  final RxInt type = 0.obs;
  final RxInt seconds = 0.obs;
  final Rx<DateTime> start = DateTime.now().obs;
  final Rx<DateTime> end = DateTime.now().obs;

  Future addFreeBreathing() async {
    loadingDialog(context);
    final FreeBreathing _breathing = FreeBreathing(
      id: generateId(),
      type: type.value,
      seconds: end.value.difference(start.value).inSeconds,
      start: start.value,
      end: end.value,
      category: 'breathing',
    );
    await freeExercises(Get.find<AuthServices>().userid)
        .doc(_breathing.id)
        .set(_breathing.toMap());
    Get.back();
    Get.back();
  }

  @override
  void initState() {
    super.initState();
  }

  RxString startCountdown = ''.obs;
  final CountDownController _countDownController = CountDownController();

  final AudioPlayer _player = AudioPlayer();

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
                title: 'Breathing',
                subtitle:
                    'Breathe without an accompanying guided audio and set your own custom duration.',
                type: type.value,
                seconds: seconds.value,
                typelist: freeBreathingList,
                onTypeChanged: (val) async {
                  type.value = val;
                },
                changeDuration: () async {
                  await customDurationPicker(
                    baseunit: BaseUnit.second,
                    initialMinutes: seconds.value,
                  ).then((value) {
                    seconds.value = value!.inSeconds;
                  });
                },
              ),
              CustomCountdown(
                caption: 'Breathe',
                controller: _countDownController,
                duration: seconds.value,
                onStart: () => {
                  startCountdown.value = 'play',
                  print(startCountdown.value),
                },
                onComplete: () {
                  startCountdown.value = '';
                  playAlarm(_player);
                },
              ).marginOnly(bottom: 50),
              CustomBottom(
                start: startCountdown.value == ''
                    ? 'Breathe Now!'
                    : startCountdown.value == 'play'
                        ? 'Pause'
                        : 'Breathe Now!',
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
                    customToast(message: 'Please set a duration first.');
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

class GuidedBreathingScreen extends StatefulWidget {
  const GuidedBreathingScreen({
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
  State<GuidedBreathingScreen> createState() => _GuidedBreathingScreenState();
}

class _GuidedBreathingScreenState extends State<GuidedBreathingScreen> {
  final BreathingController controller = Get.find();
  final RxInt audio = 5.obs;
  final RxString audiolink =
      (breathingList[breathingListIndex(5)].description).obs;
  final AudioPlayer _player = AudioPlayer();
  List<AppModel> list = <AppModel>[];

  setAudioUrl() async {
    if (widget.fromExercise) {
      audio.value = widget.entity!.value!;
      audiolink.value = widget.entity!.description;
    } else {
      list = controller.audioList
          .where((element) => element.value! <= controller.history.value.value!)
          .toList();
      if (controller.history.value.value == 18) {
        audio.value = 18;
        audiolink.value = breathingList[breathingListIndex(18)].description;
      }
    }
    if (audiolink.contains('https:')) {
      await _player.setUrl(audiolink.value);
    } else {
      await _player.setAsset(audiolink.value);
    }
  }

  _seturl(int val) async {
    if (_player.playing) _player.pause();
    audio.value = val;
    audiolink.value =
        breathingList[breathingListIndex(audio.value)].description;
    await _player.setAsset(audiolink.value).then((value) {});
    setState(() {});
  }

  @override
  void initState() {
    setAudioUrl();
    super.initState();
  }

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
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 15,
            bottom: 20,
          ),
          child: Column(
            children: [
              GuidedTop(
                title: 'Breathing',
                subtitle:
                    'Breathe easy with step-by-step guided breathing audios. ',
                value: audio.value,
                list: widget.fromExercise ? controller.audioList : list,
                fromExercise: widget.fromExercise,
                connectedReading: widget.connectedReading,
                onchanged:
                    widget.fromExercise ? null : (val) async => _seturl(val),
              ),
              AudioProgressBar(player: _player, title: 'Breathe')
                  .marginOnly(bottom: 30),
              CustomBottom(
                start: 'Breath Now!',
                player: _player,
                playing: _player.playing,
                onVolumeChanged: (val) {
                  setState(() {
                    _player.setVolume(val);
                  });
                },
                onstart: () async {
                  if (!_player.playing) {
                    _player.play();
                  } else if (_player.playing) {
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
                          'type': 'breathing'
                        });
                        Get.back();
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BreathingReadings extends StatelessWidget {
  BreathingReadings({Key? key}) : super(key: key);
  final BreathingController controller = Get.find();

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
            headline('Breathing Library').marginOnly(bottom: 20),
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
                      child: elementTitle('Breathing'),
                    ),
                  ],
                ),
                children: List.generate(
                  controller.readingList.length,
                  (index) => InkWell(
                    onTap: controller.readingList[index].value! <=
                            controller.history.value.value!
                        ? controller.readingList[index].ontap
                        : () {},
                    child: elementTitle2(controller.readingList[index].title)
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
