// ignore_for_file: avoid_print

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/bd_models.dart';
import 'package:schedular_project/Screens/seek_bar.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:wakelock/wakelock.dart';

import '../../../Constants/constants.dart';
import '../../../Model/app_user.dart';
import '../../../Widgets/drop_down_button.dart';
import '../../../Widgets/text_widget.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';
import '../bd_home.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({Key? key}) : super(key: key);

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  RxInt pomodoro = 0.obs;
  RxInt duration = pomodoroList[0].duration!.obs;
  RxInt rest = pomodoroList[0].rest!.obs;

  RxInt totalDuration = 0.obs;
  updateTotalDuration(int value) =>
      totalDuration.value = totalDuration.value + value;

  RxInt totalRest = 0.obs;
  updateTotalRest(int value) => totalRest.value = totalRest.value + value;

  RxString status = ''.obs;

  final AudioPlayer _player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 10,
            left: 15,
            bottom: 10,
            right: 15,
          ),
          child: Column(
            children: [
              ExerciseTitle(
                title: 'Pomodoro Timer',
                onPressed: () => Get.to(
                  () => ReadingScreen(
                    title: 'P101- Pomodoro Taking breaks and deep workouts',
                    link:
                        'https://docs.google.com/document/d/1v7Iiq_AHEihJBewr-fP_U_GY7N7hd0Rk/',
                    linked: () => Get.back(),
                    function: () {
                      if (Get.find<BdController>().history.value.value == 129) {
                        final end = DateTime.now();
                        Get.find<BdController>()
                            .updateHistory(end.difference(initial).inSeconds);
                      }
                      Get.log('closed');
                    },
                  ),
                ),
                // () => Get.to(() => const P101Reading()),
              ).marginOnly(bottom: 30),
              const TextWidget(
                text: 'Pomodoro Interval',
                weight: FontWeight.bold,
                alignment: Alignment.center,
              ),
              CustomDropDownStruct(
                child: DropdownButton(
                  value: pomodoro.value,
                  onChanged: (val) => {
                    setState(() {
                      resetController();
                      pomodoro.value = val;
                      duration.value = pomodoroList[pomodoro.value].duration!;
                      rest.value = pomodoroList[pomodoro.value].rest!;
                      print(duration.value);
                    }),
                  },
                  items: pomodoroList
                      .map((e) => DropdownMenuItem(
                            value: e.value,
                            child: TextWidget(
                              text: e.title,
                              alignment: Alignment.centerLeft,
                            ),
                          ))
                      .toList(),
                ),
              ),
              CustomCountdown(
                caption: resting.value ? 'Rest' : 'Action',
                duration: duration.value,
                controller: _countDownController,
                onStart: () {
                  if (!startCountdown.value && !resting.value) {
                    startCountdown.value = true;
                  }
                  print(startCountdown.value);
                },
                onComplete: () {
                  if (status.value != 'reset') {
                    playAlarm(_player);
                    if (startCountdown.value) {
                      startCountdown.value = false;
                      updateTotalDuration(duration.value);
                      resting.value = true;
                      _countDownController.restart(duration: rest.value);
                      status.value = 'play';
                    } else {
                      resting.value = false;
                      updateTotalRest(rest.value);
                      status.value = 'completed';
                      startCountdown.value = true;
                      _countDownController.restart(duration: duration.value);
                      status.value = 'play';
                    }
                  }
                },
              ),
              CustomBottom(
                player: _player,
                playing: _player.playing,
                start: status.value == 'play'
                    ? 'Pause'
                    : status.value == 'pause'
                        ? 'Resume'
                        : 'Take Action Now!',
                onVolumeChanged: (val) {
                  setState(() {
                    _player.setVolume(val);
                  });
                },
                onstart: () {
                  if (!startCountdown.value && status.value == '') {
                    _countDownController.restart(duration: duration.value);
                    status.value = 'play';
                    startCountdown.value = true;
                    print(status.value);
                  } else if (status.value == 'play') {
                    _countDownController.pause();
                    status.value = 'pause';
                  } else if (status.value == 'pause') {
                    _countDownController.resume();
                    status.value = 'play';
                  } else {
                    _countDownController.restart(duration: duration.value);
                    status.value = 'play';
                  }
                },
                onfinished: () async {
                  status.value = 'reset';
                  _countDownController.reset();
                  status.value = '';
                  startCountdown.value = false;
                  resting.value = false;
                  await addPomodoro();
                  // completed[index] = true;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  resetController() {
    status.value = 'reset';
    _countDownController.reset();
    startCountdown.value = false;
    status.value = '';
  }

  RxBool startCountdown = false.obs;
  final CountDownController _countDownController = CountDownController();
  RxBool resting = false.obs;

  void setDurations() {
    duration.value = pomodoroList[pomodoroIndex(pomodoro.value)].duration!;
    rest.value = pomodoroList[pomodoroIndex(pomodoro.value)].rest!;
  }

  final bool edit = Get.arguments[0];
  final Rx<PomodoroModel> _pomodoro = PomodoroModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _pomodoro.value.pomodoro = pomodoro.value;
    _pomodoro.value.totalRest = totalRest.value;
    _pomodoro.value.totalduration = totalDuration.value;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _pomodoro.value.duration = _pomodoro.value.duration! + diff;
    } else {
      _pomodoro.value.duration = diff;
    }
  }

  fetchData() {
    _pomodoro.value = Get.arguments[1] as PomodoroModel;
    pomodoro.value = _pomodoro.value.pomodoro!;
    setDurations();
    totalDuration.value = _pomodoro.value.totalduration!;
    totalRest.value = _pomodoro.value.totalRest!;
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == bd);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: pomodoroList[pomodoroIndex(pomodoro.value)].title,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _pomodoro.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addPomodoro([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    if (edit) _pomodoro.value.id = generateId();
    await bdRef.doc(_pomodoro.value.id).set(_pomodoro.value.toMap());
    await addAccomplishment(end);
    Get.back();
    if (!fromsave) {
      if (Get.find<BdController>().history.value.value == 130) {
        Get.find<BdController>()
            .updateHistory(end.difference(initial).inSeconds);
      }
      Get.back();
    }
    customToast(message: 'Added successfully');
  }

  Future updatePomodoro([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    await bdRef.doc(_pomodoro.value.id).update(_pomodoro.value.toMap());
    Get.back();
    if (!fromsave) Get.back();
    customToast(message: 'Updated successfully');
  }

  enableWakeLock() async {
    bool check = await Wakelock.enabled;
    if (!check) await Wakelock.enable();
  }

  disableWakeLock() async {
    bool check = await Wakelock.enabled;
    if (check) await Wakelock.disable();
  }

  @override
  void initState() {
    setState(() {
      enableWakeLock();
      if (edit) fetchData();
    });
    super.initState();
  }

  @override
  void dispose() {
    disableWakeLock();
    super.dispose();
  }
}
