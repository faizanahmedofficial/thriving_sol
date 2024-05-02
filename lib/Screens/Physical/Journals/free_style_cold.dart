// ignore_for_file: avoid_print
import 'package:wakelock/wakelock.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/cold_model.dart';
import 'package:schedular_project/Screens/seek_bar.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';

import '../../../Model/app_user.dart';
import '../../custom_bottom.dart';
import '../cold_home.dart';

class FreeStyleScreen extends StatefulWidget {
  const FreeStyleScreen({Key? key}) : super(key: key);

  @override
  State<FreeStyleScreen> createState() => _FreeStyleScreenState();
}

class _FreeStyleScreenState extends State<FreeStyleScreen> {
  RxInt type = 0.obs;
  RxInt seconds = 0.obs;

  final CountDownController _countDownController = CountDownController();
  RxString status = ''.obs;

  final AudioPlayer _player = AudioPlayer();
  @override
  void initState() {
    if (edit) fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
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
                  title: 'Cold',
                  subtitle:
                      'Set your own custom duration of cold exposure and record it here.',
                  type: type.value,
                  seconds: seconds.value,
                  typelist: freeColdOptions,
                  onTypeChanged: (val) async => type.value = val,
                  changeDuration: () async {
                    await customDurationPicker(
                      initialMinutes: 1,
                      baseunit: BaseUnit.second,
                    ).then((value) {
                      seconds.value = value!.inSeconds;
                    });
                  },
                ),
                CustomCountdown(
                  controller: _countDownController,
                  duration: seconds.value,
                  onStart: () => status.value == 'play',
                  onComplete: () {
                    playAlarm(_player);
                    status.value = '';
                  },
                  caption: 'Cold',
                ),
                CustomBottom(
                  start: status.value == 'play' ? 'Pause' : 'Thrive Now!',
                  player: _player,
                  onVolumeChanged: (val) {
                    setState(() {
                      _player.setVolume(val);
                    });
                  },
                  onstart: () async {
                    bool check = await Wakelock.enabled;
                    if (!check) await Wakelock.enable();
                    if (seconds.value == 0) {
                      customToast(
                          message: 'Please select a duration to proceed');
                    } else {
                      if (status.value == '') {
                        status.value = 'play';
                        _countDownController.restart(duration: seconds.value);
                      } else if (status.value == 'pause') {
                        status.value = 'play';
                        _countDownController.resume();
                      } else if (status.value == 'play') {
                        status.value = 'pause';
                        _countDownController.pause();
                      }
                    }
                    setState(() {});
                  },
                  onfinished: () async {
                    if (status.value == 'play') _countDownController.pause();
                    if (status.value == 'play') status.value = '';
                    bool check = await Wakelock.enabled;
                    if (check) await Wakelock.disable();
                    setState(() {});
                    await addJournal();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  final bool edit = Get.arguments[0];
  final Rx<FreestyleModel> _journal = FreestyleModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _journal.value.option = type.value;
    _journal.value.seconds = seconds.value;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _journal.value.duration = _journal.value.duration! + diff;
    } else {
      _journal.value.duration = diff;
    }
  }

  fetchData() {
    _journal.value = Get.arguments[1] as FreestyleModel;
    type.value = _journal.value.option!;
    seconds.value = _journal.value.seconds!;
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == cold);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: freeColdOptions[freeColdIndex(type.value)].title,
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
      if (Get.find<ColdController>().history.value.value == 135) {
        Get.find<ColdController>().updateHistory(end.difference(initial).inSeconds);
      }
      Get.back();
    }
    customToast(message: edit ? 'Updated Successfully' : 'Added successfullyy');
  }
}
