// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers
import 'dart:async';

import 'package:wakelock/wakelock.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Controller/play_routine_controller.dart';
import 'package:schedular_project/Screens/seek_bar.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../Functions/functions.dart';
import '../../Global/firebase_collections.dart';
import '../../Model/app_modal.dart';
import '../../Model/app_user.dart';
import '../../Services/auth_services.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_toast.dart';
import '../../Widgets/dialogs.dart';
import '../../Widgets/loading_dialog.dart';
import '../../Widgets/widgets.dart';
import '../custom_bottom.dart';
import '../readings.dart';

class MindfulnessController extends GetxController {
  final Rx<CurrentExercises> history = CurrentExercises(
    id: mindfulness,
    index: 9,
    value: 35,
    time: DateTime.now(),
    connectedPractice: 35,
    connectedReading: 35,
    previousPractice: 35,
    previousReading: 35,
    completed: false,
  ).obs;

  late Timer timer;
  @override
  void onInit() async {
    await fetchHistory();
    print(routine);
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
      mindfulnessList.where((val) => val.type == 2).toList();

  List<AppModel> readinglist =
      mindfulnessList.where((val) => val.type == 1).toList();

  Future fetchHistory() async {
    await currentExercises(Get.find<AuthServices>().userid)
        .doc(mindfulness)
        .get()
        .then((value) async {
      if (value.data() == {} || value.data() == null) {
        await currentExercises(Get.find<AuthServices>().userid)
            .doc(mindfulness)
            .set(history.value.toMap());
      } else {
        history.value = CurrentExercises.fromMap(value.data());
      }
    });
    appModel.value =
        mindfulnessList[mindfulnessListIndex(history.value.value!)];
  }

  Rx<AppModel> appModel = AppModel('', '').obs;
  Future updateReadingHistory(int duration) async {
    if (appModel.value.type == 1) {
      userReadings(Get.find<AuthServices>().userid).update({
        'mindfulness.element': history.value.value,
      });
      addReadingAccomplishment(duration);
    }
  }

  Future addReadingAccomplishment(int duration) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == mindfulness);
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
        .where((value) => value.id == mindfulness);
    if (list.isNotEmpty) {
      list.first.advanced = appModel.value.title;
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addListening(int duration) async {
    /// 0: baby, 1: breath, 2: smile
    /// 3: sight, 4: sound, 5: smell,6: touch,7: taste,
    /// 8: kinesthetic, 9: bodyscan, 10: openmonitioring
    if (appModel.value.type == 2) {
      await userListening(Get.find<AuthServices>().userid).add({
        'value': appModel.value.value,
        'category': 'breathing',
        'type': appModel.value.value! == 36
            ? 0
            : appModel.value.value! == 39
                ? 1
                : appModel.value.value! == 41
                    ? 2
                    : appModel.value.value! == 44
                        ? 3
                        : appModel.value.value! == 46
                            ? 4
                            : appModel.value.value! == 48
                                ? 5
                                : appModel.value.value! == 50
                                    ? 6
                                    : appModel.value.value! == 52
                                        ? 7
                                        : appModel.value.value! == 54
                                            ? 8
                                            : appModel.value.value! == 56
                                                ? 9
                                                : appModel.value.value! == 58
                                                    ? 10
                                                    : 11,
      });
      addReadingAccomplishment(duration);
    }
  }

  Future updateHistory(int duration,
      {bool fromlistening = false, bool added = false}) async {
    if (history.value.value != 58) {
      await updateReadingHistory(duration);
      if (!added) addListening(duration);
      history.value.value = history.value.value! + 1;
      await _updateData();
      if (fromlistening) Get.back();
    } else if (history.value.value == 58) {
      await updateReadingHistory(duration);
      if (!added) addListening(duration);
      history.value.value = 58;
      history.value.completed = true;
      await _updateData();
      if (fromlistening) Get.back();
    }
  }

  _updateData() async {
    final _intro = mindfulnessList[mindfulnessListIndex(history.value.value!)];
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
    appModel.value = mindfulnessList[mindfulnessListIndex(value)];
    history.value = CurrentExercises(
      id: mindfulness,
      index: 9,
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
    // Get.find<PlayRoutineController>().completeElement();
    super.onClose();
  }
}

class MindfulnesScreen extends StatelessWidget {
  MindfulnesScreen({Key? key}) : super(key: key);
  final MindfulnessController controller = Get.put(MindfulnessController());

  Future updateListeningIndex(int value, DateTime initial) async {
    final end = DateTime.now();
    final diff = end.difference(initial).inSeconds;
    switch (value) {
      case 36:
      case 39:
      case 41:
      case 44:
      case 46:
      case 48:
      case 50:
      case 52:
      case 54:
      case 56:
      case 58:
        controller.updateHistory(diff, fromlistening: true);
        break;
    }
  }

  connectedReading(int value, DateTime initial) {
    final end = DateTime.now();
    switch (value) {
      case 36:
        break;
      case 39:
        Get.to(
          () => ReadingScreen(
            title: 'M101- Breath Awareness',
            link:
                'https://docs.google.com/document/d/1nq3njNLEtiPkXas3RtQUMaJZEOWcLYtC/',
            linked: () {
              Get.to(
                () => GuidedMinfulnessScreen(
                  fromExercise: true,
                  entity: mindfulnessList[mindfulnessListIndex(39)],
                  connectedReading: () => Get.back(),
                  onfinished: () => Get.back(),
                ),
              );
            },
            function: () {
              if (Get.find<MindfulnessController>().history.value.value == 38) {
                debugPrint('disposing');
                Get.find<MindfulnessController>()
                    .updateHistory(end.difference(initial).inSeconds);
                debugPrint('disposed');
              }
              Get.log('closed');
            },
          ),
        );
        // Get.to(() => const BreathAwarenessReading());
        break;
      case 41:
        // Get.to(() => const SmileAwarenessReading());
        Get.to(
          () => ReadingScreen(
            title: 'M102- Smiling Awareness!',
            link:
                'https://docs.google.com/document/d/1BcFvuTHErGqqWeTD9iOIh2hF7_AClPgI/',
            linked: () {
              Get.to(
                () => GuidedMinfulnessScreen(
                  fromExercise: true,
                  entity: mindfulnessList[mindfulnessListIndex(41)],
                  connectedReading: () => Get.back(),
                  onfinished: () => Get.back(),
                ),
              );
            },
            function: () {
              if (Get.find<MindfulnessController>().history.value.value == 40) {
                debugPrint('disposing');
                Get.find<MindfulnessController>()
                    .updateHistory(end.difference(initial).inSeconds);
                debugPrint('disposed');
              }
              Get.log('closed');
            },
          ),
        );
        break;
      case 44:
        // Get.to(() => .const SightAwarenessReading());
        Get.to(
          () => ReadingScreen(
            title: 'M103a- Sight Awareness',
            link:
                'https://docs.google.com/document/d/1j1Isvw0f6bS5j3epwzeklTvPgWHfh5tv/',
            linked: () {
              Get.to(
                () => GuidedMinfulnessScreen(
                  fromExercise: true,
                  entity: mindfulnessList[mindfulnessListIndex(44)],
                  connectedReading: () => Get.back(),
                  onfinished: () => Get.back(),
                ),
              );
            },
            function: () {
              if (Get.find<MindfulnessController>().history.value.value == 43) {
                debugPrint('disposing');
                Get.find<MindfulnessController>()
                    .updateHistory(end.difference(initial).inSeconds);
                debugPrint('disposed');
              }
              Get.log('closed');
            },
          ),
        );
        break;
      case 46:
        // Get.to(() => const SoundAwarenessReading());
        Get.to(
          () => ReadingScreen(
            title: 'M103b- Sound Awareness',
            link:
                'https://docs.google.com/document/d/17waIUmRJbcE87p0FzHx0sZhgQkuc95dD/',
            linked: () {
              Get.to(
                () => GuidedMinfulnessScreen(
                  fromExercise: true,
                  entity: mindfulnessList[mindfulnessListIndex(46)],
                  connectedReading: () => Get.back(),
                  onfinished: () => Get.back(),
                ),
              );
            },
            function: () {
              if (Get.find<MindfulnessController>().history.value.value == 45) {
                debugPrint('disposing');
                Get.find<MindfulnessController>()
                    .updateHistory(end.difference(initial).inSeconds);
                debugPrint('disposed');
              }
              Get.log('closed');
            },
          ),
        );
        break;
      case 48:
        // Get.to(() => const SmellAwareness());
        Get.to(
          () => ReadingScreen(
            title: 'M103c- Smell Awareness',
            link:
                'https://docs.google.com/document/d/1-ouPyYUZ5fbQc7rxK8OHOgGbLXHd75oT/',
            linked: () {
              Get.to(
                () => GuidedMinfulnessScreen(
                  fromExercise: true,
                  entity: mindfulnessList[mindfulnessListIndex(48)],
                  connectedReading: () => Get.back(),
                  onfinished: () => Get.back(),
                ),
              );
            },
            function: () {
              if (Get.find<MindfulnessController>().history.value.value == 47) {
                debugPrint('disposing');
                Get.find<MindfulnessController>()
                    .updateHistory(end.difference(initial).inSeconds);
                debugPrint('disposed');
              }
              Get.log('closed');
            },
          ),
        );
        break;
      case 50:
        // Get.to(() => const TouchAwarenessReading());
        Get.to(
          () => ReadingScreen(
            title: 'M103d- Touch Awareness',
            link:
                'https://docs.google.com/document/d/1hz5O1wZ0jq5_Zqxv9qFwramNixup2cHe/',
            linked: () {
              Get.to(
                () => GuidedMinfulnessScreen(
                  fromExercise: true,
                  entity: mindfulnessList[mindfulnessListIndex(50)],
                  connectedReading: () => Get.back(),
                  onfinished: () => Get.back(),
                ),
              );
            },
            function: () {
              if (Get.find<MindfulnessController>().history.value.value == 49) {
                debugPrint('disposing');
                Get.find<MindfulnessController>()
                    .updateHistory(end.difference(initial).inSeconds);
                debugPrint('disposed');
              }
              Get.log('closed');
            },
          ),
        );
        break;
      case 52:
        // Get.to(() => const TasteAwarenessReading());
        Get.to(
          () => ReadingScreen(
            title: 'M103e- Taste Awareness',
            link:
                'https://docs.google.com/document/d/1xH5KCddx0uwKiLUl1QqrMr2MFQQp6Uei/',
            linked: () {
              Get.to(
                () => GuidedMinfulnessScreen(
                  fromExercise: true,
                  entity: mindfulnessList[mindfulnessListIndex(52)],
                  connectedReading: () => Get.back(),
                  onfinished: () => Get.back(),
                ),
              );
            },
            function: () {
              if (Get.find<MindfulnessController>().history.value.value == 51) {
                debugPrint('disposing');
                Get.find<MindfulnessController>()
                    .updateHistory(end.difference(initial).inSeconds);
                debugPrint('disposed');
              }
              Get.log('closed');
            },
          ),
        );
        break;
      case 54:
        // Get.to(() => const KinestheticAwarenessReading());
        Get.to(
          () => ReadingScreen(
            title: 'M103f- Kinesthetic Awareness',
            link:
                'https://docs.google.com/document/d/1KsgqONXoaJJXTrJjC5NVhI8aNh_KYpln/',
            linked: () {
              Get.to(
                () => GuidedMinfulnessScreen(
                  fromExercise: true,
                  entity: mindfulnessList[mindfulnessListIndex(54)],
                  connectedReading: () => Get.back(),
                  onfinished: () => Get.back(),
                ),
              );
            },
            function: () {
              if (Get.find<MindfulnessController>().history.value.value == 53) {
                debugPrint('disposing');
                Get.find<MindfulnessController>()
                    .updateHistory(end.difference(initial).inSeconds);
                debugPrint('disposed');
              }
              Get.log('closed');
            },
          ),
        );
        break;
      case 56:
        // Get.to(() => const BodyScanReading());
        Get.to(
          () => ReadingScreen(
            title: 'M104- Body Scans',
            link:
                'https://docs.google.com/document/d/12-_h0kCWz9bs02DuNSVt6I4BTyKgUQYz/',
            linked: () {
              Get.to(
                () => GuidedMinfulnessScreen(
                  fromExercise: true,
                  entity: mindfulnessList[mindfulnessListIndex(56)],
                  connectedReading: () => Get.back(),
                  onfinished: () => Get.back(),
                ),
              );
            },
            function: () {
              if (Get.find<MindfulnessController>().history.value.value == 55) {
                debugPrint('disposing');
                Get.find<MindfulnessController>()
                    .updateHistory(end.difference(initial).inSeconds);
                debugPrint('disposed');
              }
              Get.log('closed');
            },
          ),
        );
        break;
      case 58:
        // Get.to(() => const OpenMonitoringReading());
        Get.to(
          () => ReadingScreen(
            title: 'M105- Open Monitoring',
            link:
                'https://docs.google.com/document/d/1yWvIM1d9hXIPFtgK2nN3hKi5Yg5bZlxW/',
            linked: () {
              Get.to(
                () => GuidedMinfulnessScreen(
                  fromExercise: true,
                  entity: mindfulnessList[mindfulnessListIndex(58)],
                  connectedReading: () => Get.back(),
                  onfinished: () => Get.back(),
                ),
              );
            },
            function: () {
              if (Get.find<MindfulnessController>().history.value.value == 57) {
                debugPrint('disposing');
                Get.find<MindfulnessController>()
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
    return Obx(() {
      return Scaffold(
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
              headline('Mindfulness').marginOnly(bottom: 30),
              TopList(
                list: mindfulnessList,
                // controller.history.value.value == 18
                //     ? controller.history.value.value!
                //     : controller.history.value.connectedReading ==
                //     controller.history.value.value
                //     ? controller.history.value.connectedPractice ??
                //     controller.history.value.value!
                //     :
                value: controller.history.value.value!,
                onchanged: (val) {},
                // (val) => controller
                // .selectData(val), // controller.history.value.value = val;,
                play: controller.appModel.value.type == 1
                    ? controller.appModel.value.ontap
                    : controller.appModel.value.type == 2
                        ? () {
                            final start = DateTime.now();
                            Get.to(
                              () => GuidedMinfulnessScreen(
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
                    onTap: () => Get.to(() => const GuidedMinfulnessScreen()),
                    title: 'Guided Mindfulness',
                    description:
                        'Focus with step-by-step guided mindfulness audios.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => const FreeMindfulnessScreen()),
                    title: 'Free Mindfulness',
                    description:
                        'Practice mindfulness without an accompanying guided audio and set your own custom duration.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => MindfulnessReading()),
                    title: 'Mindfulness Library',
                    description:
                        'Gain knowledge that unlocks mindfulness techniques with massive practical wellness benefits.',
                  ).marginOnly(bottom: 30),
                ],
              ).marginOnly(left: 25, right: 25),
            ],
          ),
        ),
      );
    });
  }
}

class FreeMindfulnessScreen extends StatefulWidget {
  const FreeMindfulnessScreen({Key? key}) : super(key: key);

  @override
  State<FreeMindfulnessScreen> createState() => _FreeMindfulnessScreenState();
}

class _FreeMindfulnessScreenState extends State<FreeMindfulnessScreen> {
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
      category: 'mindfulness',
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
                title: 'Mindfulness',
                subtitle:
                    'Practice mindfulness without an accompanying guided audio and set your own custom duration.',
                type: type.value,
                seconds: seconds.value,
                typelist: freeMindfulList,
                onTypeChanged: (val) async => type.value = val,
                changeDuration: () async {
                  await customDurationPicker(initialMinutes: seconds.value)
                      .then((value) {
                    seconds.value = value!.inSeconds;
                  });
                },
              ),
              CustomCountdown(
                controller: _countDownController,
                duration: seconds.value,
                onStart: () => startCountdown.value = 'play',
                onComplete: () =>
                    {startCountdown.value = '', playAlarm(_player)},
                caption: 'Be Mindful',
              ).marginOnly(bottom: 50),
              CustomBottom(
                start: startCountdown.value == '' ||
                        startCountdown.value == 'paused'
                    ? 'Be Mindful Now!'
                    : 'Pause',
                player: _player,
                onVolumeChanged: (val) {
                  setState(() {
                    _player.setVolume(val);
                  });
                },
                onstart: () async {
                  bool check = await Wakelock.enabled;
                  if (!check) await Wakelock.enable();
                  setState(() {
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
                  });
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

class GuidedMinfulnessScreen extends StatefulWidget {
  const GuidedMinfulnessScreen({
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
  State<GuidedMinfulnessScreen> createState() => _GuidedMinfulnessScreenState();
}

class _GuidedMinfulnessScreenState extends State<GuidedMinfulnessScreen> {
  final MindfulnessController controller = Get.find();
  final RxInt audio = 36.obs;
  final RxString audiolink =
      (mindfulnessList[mindfulnessListIndex(36)].description).obs;
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
        mindfulnessList[mindfulnessListIndex(audio.value)].description;
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

  DateTime initial = DateTime.now();

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
                title: 'Mindfulness',
                subtitle:
                    'Breathe easy with step-by-step guided breathing audios.  ',
                value: audio.value,
                list: widget.fromExercise ? controller.audioList : list,
                onchanged:
                    widget.fromExercise ? null : (val) async => _seturl(val),
                connectedReading: widget.connectedReading,
                fromExercise: widget.fromExercise,
              ),
              AudioProgressBar(player: _player, title: 'Be Mindful')
                  .marginOnly(bottom: 30),
              CustomBottom(
                start: 'Be Mindful Now!',
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
                        final end = DateTime.now();
                        await guided(Get.find<AuthServices>().userid)
                            .doc(id)
                            .set({
                          'id': id,
                          'audio': audio.value,
                          'link': audiolink.value,
                          'type': 'mindfulness',
                        });
                        if (Get
                                        .find<MindfulnessController>()
                                    .history
                                    .value
                                    .value ==
                                36 ||
                            Get
                                        .find<MindfulnessController>()
                                    .history
                                    .value
                                    .value ==
                                39 ||
                            Get
                                        .find<MindfulnessController>()
                                    .history
                                    .value
                                    .value ==
                                41 ||
                            Get
                                        .find<MindfulnessController>()
                                    .history
                                    .value
                                    .value ==
                                44 ||
                            Get
                                        .find<MindfulnessController>()
                                    .history
                                    .value
                                    .value ==
                                46 ||
                            Get
                                        .find<MindfulnessController>()
                                    .history
                                    .value
                                    .value ==
                                48 ||
                            Get
                                        .find<MindfulnessController>()
                                    .history
                                    .value
                                    .value ==
                                50 ||
                            Get
                                        .find<MindfulnessController>()
                                    .history
                                    .value
                                    .value ==
                                52 ||
                            Get
                                        .find<MindfulnessController>()
                                    .history
                                    .value
                                    .value ==
                                54 ||
                            Get.find<MindfulnessController>()
                                    .history
                                    .value
                                    .value ==
                                56 ||
                            Get.find<MindfulnessController>()
                                    .history
                                    .value
                                    .value ==
                                58) {
                          Get.find<MindfulnessController>()
                              .updateHistory(end.difference(initial).inSeconds);
                        }
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

class MindfulnessReading extends StatelessWidget {
  MindfulnessReading({Key? key}) : super(key: key);
  final MindfulnessController controller = Get.find();

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
            headline('Mindfulness Library').marginOnly(bottom: 20),
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
                      child: elementTitle('Mindfulness'),
                    ),
                  ],
                ),
                children: List.generate(
                  controller.readinglist.length,
                  (index) => InkWell(
                    onTap: controller.readinglist[index].value! <=
                            controller.history.value.value!
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
