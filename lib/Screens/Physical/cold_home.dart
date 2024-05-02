// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Screens/Physical/Journals/free_style_cold.dart';
import 'package:schedular_project/Screens/Physical/Journals/guided_cold.dart';

import '../../Controller/play_routine_controller.dart';
import '../../Functions/functions.dart';
import '../../Global/firebase_collections.dart';
import '../../Model/app_modal.dart';
import '../../Model/app_user.dart';
import '../../Services/auth_services.dart';
import '../../Widgets/app_bar.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/dialogs.dart';
import '../../Widgets/text_widget.dart';
import '../custom_bottom.dart';
import '../../Widgets/widgets.dart';

class ColdController extends GetxController {
  Rx<CurrentExercises> history = CurrentExercises(
    id: cold,
    index: 2,
    value: 134,
    time: DateTime.now(),
    connectedPractice: 134,
    connectedReading: 134,
    previousReading: 134,
    previousPractice: 134,
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

  Future fetchHistory() async {
    await currentExercises(Get.find<AuthServices>().userid)
        .doc(cold)
        .get()
        .then((value) async {
      if (value.data() == {} || value.data() == null) {
        await currentExercises(Get.find<AuthServices>().userid)
            .doc(cold)
            .set(history.value.toMap());
      } else {
        history.value = CurrentExercises.fromMap(value.data());
      }
    });
    appModel.value = coldList[coldListIndex(history.value.value!)];
  }

  Rx<AppModel> appModel = AppModel('', '').obs;
  Future updateReadingHistory(int duration) async {
    if (appModel.value.type == 1) {
      userReadings(Get.find<AuthServices>().userid)
          .update({'cold.element': history.value.value});
      addReadingAccomplishment(duration);
    }
  }

  Future addReadingAccomplishment(int duration) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == cold);
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
        .where((value) => value.id == cold);
    if (list.isNotEmpty) {
      list.first.advanced = appModel.value.title;
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future updateHistory(int duration) async {
    if (history.value.value != 138 && !history.value.completed!) {
      await updateReadingHistory(duration);
      history.value.value = history.value.value! + 1;
      _updateData();
    } else if (history.value.value == 138) {
      await updateReadingHistory(duration);
      history.value.value = 136;
      history.value.completed = true;
      _updateData();
    }
  }

  _updateData() async {
    final _intro = coldList[coldListIndex(history.value.value!)];
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

  List<AppModel> get readinglist =>
      coldList.where((element) => element.type == 1).toList();

  selectData(int value) {
    appModel.value = coldList[coldListIndex(value)];
    history.value = CurrentExercises(
      id: cold,
      index: 2,
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

class ColdHome extends StatelessWidget {
  ColdHome({Key? key}) : super(key: key);
  final ColdController controller = Get.put(ColdController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              headline('Cold').marginOnly(bottom: 30),
              TopList(
                list: coldList,
                // controller.history.value.value == 138
                //     ? controller.history.value.value!
                //     : controller.history.value.connectedReading ==
                //     controller.history.value.value
                //     ? controller.history.value.connectedPractice ??
                //     controller.history.value.value!
                //     : controller.history.value.connectedReading!
                value: controller.history.value.value!,
                onchanged: (val) {},
                // (val) => controller.selectData(val), // controller.history.value.value = val;,
                play: controller.appModel.value.ontap,
              ),
              Column(
                children: [
                  AppButton(
                    onTap: () => Get.to(
                      () => const GuidedColdScreen(),
                      arguments: [false],
                    ),
                    title: 'Guided Cold',
                    description:
                        'Increase your cold exposure systematically in small, easy-to-handle durations to improve with minimal effort and planning. ',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(
                      () => const FreeStyleScreen(),
                      arguments: [false],
                    ),
                    title: 'Freestyle Cold',
                    description:
                        'Set your own custom duration of cold exposure and record it here.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => ColdReadings()),
                    title: 'Cold Library',
                    description:
                        'Gain knowledge that unlocks techniques with massive practical wellness benefits.',
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

class ColdReadings extends StatelessWidget {
  ColdReadings({Key? key}) : super(key: key);
  final ColdController controller = Get.find();

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
            headline('Cold Library').marginOnly(bottom: 20),
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
                      child: elementTitle('Cold'),
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
