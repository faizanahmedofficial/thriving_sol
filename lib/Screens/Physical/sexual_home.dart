// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Screens/Physical/Journals/pc_journal_level_0.dart';

import '../../Controller/play_routine_controller.dart';
import '../../Global/firebase_collections.dart';
import '../../Model/app_modal.dart';
import '../../Model/app_user.dart';
import '../../Services/auth_services.dart';
import '../../Widgets/app_bar.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/dialogs.dart';
import '../../Widgets/text_widget.dart';
import '../custom_bottom.dart';
import '../reading_library.dart';
import 'Journals/pc_journal_level_1.dart';
import '../../Widgets/widgets.dart';

class SexualController extends GetxController {
  final Rx<CurrentExercises> history = CurrentExercises(
    id: sexual,
    index: 11,
    value: 139,
    time: DateTime.now(),
    connectedReading: 139,
    connectedPractice: 139,
    completed: false,
    previousReading: 139,
    previousPractice: 139,
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
        .doc(sexual)
        .get()
        .then((value) async {
      if (value.data() == {} || value.data() == null) {
        await currentExercises(Get.find<AuthServices>().userid)
            .doc(sexual)
            .set(history.value.toMap());
      } else {
        history.value = CurrentExercises.fromMap(value.data());
      }
    });
    appModel.value = sexualList[sexualListIndex(history.value.value!)];
  }

  Rx<AppModel> appModel = AppModel('', '').obs;
  Future updateReadingHistory(int duration) async {
    if (appModel.value.type == 1) {
      userReadings(Get.find<AuthServices>().userid)
          .update({'sexual.element': history.value.value});
      addReadingAccomplishment(duration);
    }
  }

  Future addReadingAccomplishment(int duration) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == sexual);
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
        .where((value) => value.id == sexual);
    if (list.isNotEmpty) {
      list.first.advanced = appModel.value.title;
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future updateHistory(int duration) async {
    if (history.value.value != 142 && !history.value.completed!) {
      await updateReadingHistory(duration);
      history.value.value = history.value.value! + 1;
      _updateData();
    } else if (history.value.value == 142) {
      await updateReadingHistory(duration);
      history.value.value = 141;
      history.value.completed = true;
      _updateData();
    }
  }

  _updateData() async {
    final _intro = sexualList[sexualListIndex(history.value.value!)];
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
      sexualList.where((element) => element.type == 1).toList();

  selectData(int value) {
    appModel.value = sexualList[sexualListIndex(value)];
    history.value = CurrentExercises(
      id: sexual,
      index: 11,
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

class SexualHome extends StatelessWidget {
  SexualHome({Key? key}) : super(key: key);
  final SexualController controller = Get.put(SexualController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              headline('Sexual').marginOnly(bottom: 30),
              TopList(
                list: sexualList,
                value: controller.history.value.value!,
                onchanged: (val) {}, //(val) => controller.selectData(val),
                play: controller.appModel.value.ontap,
              ),
              Column(
                children: [
                  AppButton(
                    onTap: () => Get.to(() => const SexualJournal()),
                    title: 'PC Journal',
                    description:
                        'Strengthen your pelvic floor for better sexual health, and increased pleasure given and received by both sexes. Men, gain the ability to have multiple orgasms. Women, reach orgasm faster and have more intense orgasms.',
                  ).marginOnly(bottom: 30),
                  // AppButton(
                  //   onTap: () => {},
                  //   title: 'Sexual Exercises',
                  //   description:
                  //       'Use all your senses and your imagination to strengthen the bond between partners and have an amazing time doing so.',
                  // ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(
                      () => CustomReadingLibrary(
                        title: 'Sexual',
                        list: sexualList
                            .where((element) => element.type == 1)
                            .toList(),
                        color: const Color(0xffC2B8B8),
                      ),
                    ),
                    title: 'Sexual Library',
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

class SexualReadings extends StatelessWidget {
  SexualReadings({Key? key}) : super(key: key);
  final SexualController controller = Get.find();

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
            headline('Sexual Library').marginOnly(bottom: 20),
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
                      child: elementTitle('Sexual'),
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

class SexualJournal extends StatelessWidget {
  const SexualJournal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            headline('PC Journal').marginOnly(bottom: 30),
            Column(
              children: [
                AppButton(
                  onTap: () =>
                      Get.to(() => const PCJournalLvl0(), arguments: [false]),
                  title: 'Lvl0- Discovery',
                  description:
                      'The PC muscles can be fickle beasts. Finding them and isolating them is key to progress.',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap: () =>
                      Get.to(() => const PCJournalLvl1(), arguments: [false]),
                  title: 'Lvl1- Strengthen',
                  description:
                      'Follow the levels to increase your PC strength at a healthy pace. No guesswork required.',
                ).marginOnly(bottom: 30),
              ],
            ).marginOnly(left: 25, right: 25),
          ],
        ),
      ),
    );
  }
}
