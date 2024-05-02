// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/constants.dart';

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
import '../../Widgets/widgets.dart';
import '../custom_bottom.dart';
import 'gratitude_letter.dart';
import 'journals/baby_gratitude_journal.dart';
import 'journals/gratitude_journal_lvl1.dart';

class GratitudeController extends GetxController {
  final Rx<CurrentExercises> history = CurrentExercises(
    id: gratitude,
    index: 7,
    value: 60,
    time: DateTime.now(),
    connectedPractice: 61,
    connectedReading: 60,
    previousPractice: 60,
    previousReading: 60,
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
        .doc(gratitude)
        .get()
        .then((value) async {
      if (value.data() == {} || value.data() == null) {
        await currentExercises(Get.find<AuthServices>().userid)
            .doc(gratitude)
            .set(history.value.toMap());
      } else {
        history.value = CurrentExercises.fromMap(value.data());
      }
    });
    appModel.value = gratitudeList[gratitudeIndex(history.value.value!)];
  }

  Rx<AppModel> appModel = AppModel('', '').obs;
  Future updateReadingHistory(int duration) async {
    if (appModel.value.type == 1) {
      userReadings(Get.find<AuthServices>().userid).update({
        'gratitude.element': history.value.value,
      });
      addReadingAccomplishment(duration);
    }
  }

  Future addReadingAccomplishment(int duration) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == gratitude);
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
        .where((value) => value.id == gratitude);
    if (list.isNotEmpty) {
      list.first.advanced = appModel.value.title;
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future updateHistory(int duration) async {
    if (history.value.value != 65 && !history.value.completed!) {
      await updateReadingHistory(duration);
      history.value.value = history.value.value! + 1;
      _updateData();
    } else if (history.value.value == 65) {
      await updateReadingHistory(duration);
      history.value.value = 65;
      history.value.completed = true;
      _updateData();
    }
  }

  _updateData() async {
    final _intro = gratitudeList[gratitudeIndex(history.value.value!)];
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
      gratitudeList.where((element) => element.type == 1).toList();

  selectData(int value) {
    appModel.value = gratitudeList[gratitudeIndex(value)];
    history.value = CurrentExercises(
      id: gratitude,
      index: 7,
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

class GratitudeHome extends StatelessWidget {
  GratitudeHome({Key? key}) : super(key: key);
  final GratitudeController controller = Get.put(GratitudeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              headline('Gratitude').marginOnly(bottom: 30),
              TopList(
                list: gratitudeList,
                value: controller.history.value.value!,
                onchanged: (val) {},
                //  (val) => controller
                // .selectData(val), // controller.history.value.value = val;,
                play: controller.appModel.value.ontap,
              ),
              Column(
                children: [
                  AppButton(
                    onTap: () => Get.to(() => const GratitudeJournal()),
                    title: 'Gratitude Journal',
                    description:
                        'Make gratitude and happiness second nature. Use our journals to easily uncover gratitude and happiness in every facet of your life.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap:
                        Get.find<GratitudeController>().history.value.value !=
                                65
                            ? () {}
                            : () => Get.to(
                                  () => const GratitudeLetter(),
                                  arguments: [false],
                                ),
                    title: 'Gratitude Letter/ Gift',
                    description:
                        'Give the gift of gratitude to another to double the benefits you receive from gratitude!',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => GratitudeReading()),
                    title: 'Gratitude Library',
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

class GratitudeReading extends StatelessWidget {
  GratitudeReading({Key? key}) : super(key: key);
  final GratitudeController controller = Get.find();

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
            headline('Gratitude Library').marginOnly(bottom: 20),
            CustomContainer(
              background: const Color(0xffB3D8B5),
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
                      child: elementTitle('Gratitude'),
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

class GratitudeJournal extends StatelessWidget {
  const GratitudeJournal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            headline('Gratitude Journal').marginOnly(bottom: 30),
            Column(
              children: [
                AppButton(
                  onTap:
                      Get.find<GratitudeController>().history.value.value! >= 61
                          // ||  Get.find<GratitudeController>()
                          //           .history
                          //           .value
                          //           .value! ==
                          //       60
                          ? () => Get.to(() => const BabyGratitudeJournal(),
                              arguments: [false])
                          : () {},
                  title: 'Baby Gratitude Journal',
                  description: 'List the things you are thankful for.',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap:
                      Get.find<GratitudeController>().history.value.value! >= 63
                          // ||Get.find<GratitudeController>()
                          //                                 .history
                          //                                 .value
                          //                                 .value! ==
                          //                             62
                          ? () => Get.to(() => const GratitudeJournal1(),
                              arguments: [false])
                          : () {},
                  title: 'Gratitude Journal',
                  description:
                      'Ask yourself a few questions to easily uncover gratitude and happiness in every facet of your life.',
                ).marginOnly(bottom: 30),
              ],
            ).marginOnly(left: 25, right: 25),
          ],
        ),
      ),
    );
  }
}
