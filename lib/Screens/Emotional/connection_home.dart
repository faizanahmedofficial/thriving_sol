// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Screens/Emotional/Relationships/community.dart';
import 'package:schedular_project/Screens/Emotional/Relationships/meaningful_connection.dart';

import '../../Controller/play_routine_controller.dart';
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
import 'journals/connection_journal_lvl1.dart';
import 'journals/connection_journal_lvl2.dart';
import 'journals/connection_journal_lvl_0.dart';

class ConnectionController extends GetxController {
  final Rx<CurrentExercises> history = CurrentExercises(
    id: connection,
    index: 3,
    value: 94,
    time: DateTime.now(),
    connectedPractice: 95,
    connectedReading: 94,
    previousReading: 94,
    previousPractice: 94,
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
        .doc(connection)
        .get()
        .then((value) async {
      if (value.data() == {} || value.data() == null) {
        await currentExercises(Get.find<AuthServices>().userid)
            .doc(connection)
            .set(history.value.toMap());
      } else {
        history.value = CurrentExercises.fromMap(value.data());
      }
    });
    appModel.value = connectionList[connectionIndex(history.value.value!)];
  }

  Rx<AppModel> appModel = AppModel('', '').obs;
  Future updateReadingHistory(int duration) async {
    if (appModel.value.type == 1) {
      userReadings(Get.find<AuthServices>().userid)
          .update({'connection.element': history.value.value});
      addReadingAccomplishment(duration);
    }
  }

  Future addReadingAccomplishment(int duration) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == connection);
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
        .where((value) => value.id == connection);
    if (list.isNotEmpty) {
      list.first.advanced = appModel.value.title;
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future updateHistory(int duration) async {
    if (history.value.value != 101 && !history.value.completed!) {
      await updateReadingHistory(duration);
      history.value.value = history.value.value! + 1;
      _updatedData();
    } else if (history.value.value == 101) {
      await updateReadingHistory(duration);
      history.value.value == 101;
      history.value.completed = true;
      _updatedData();
    }
  }

  _updatedData() async {
    final _intro = connectionList[connectionIndex(history.value.value!)];
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
      connectionList.where((element) => element.type == 1).toList();

  selectData(int value) {
    appModel.value = connectionList[connectionIndex(value)];
    history.value = CurrentExercises(
      id: connection,
      index: 3,
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

class ConnectionHome extends StatelessWidget {
  ConnectionHome({Key? key}) : super(key: key);
  final ConnectionController controller = Get.put(ConnectionController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              headline('Connection').marginOnly(bottom: 30),
              TopList(
                list: connectionList,
                // controller.history.value.value == 101
                //     ? controller.history.value.value!
                //     : controller.history.value.connectedReading ==
                //     controller.history.value.value
                //     ? controller.history.value.connectedPractice ??
                //     controller.history.value.value!
                //     :
                value: controller.history.value.value!,
                onchanged: (val) {},
                // (val) => controller
                //     .selectData(val), // controller.history.value.value = val;,
                play: controller.appModel.value.ontap,
              ),
              Column(
                children: [
                  AppButton(
                    onTap: () => Get.to(() => const ConnectionJournal()),
                    title: 'Connection Journal',
                    description:
                        'Connect with others and see your own happiness, purpose, and health improve.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => const Relationships()),
                    title: 'Relationships',
                    description:
                        'Identify the relationships that are worthy of your energy. These relationships will be key to skyrocketing your happiness, purpose, and even financial health.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => ConnectionReading()),
                    title: 'Connection Library',
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

class ConnectionReading extends StatelessWidget {
  ConnectionReading({Key? key}) : super(key: key);
  final ConnectionController controller = Get.find();

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
            headline('Connection Library').marginOnly(bottom: 20),
            CustomContainer(
              background: const Color(0xffABEBAF),
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
                      child: elementTitle('Connection'),
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

class Relationships extends StatelessWidget {
  const Relationships({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            headline('Relationships').marginOnly(bottom: 30),
            Column(
              children: [
                AppButton(
                  onTap:
                      Get.find<ConnectionController>().history.value.value! >=
                              97
                          // ||
                          // Get.find<ConnectionController>()
                          //         .history
                          //         .value
                          //         .value ==
                          //     96
                          ? () => Get.to(() => const MeaningfulConnection(),
                              arguments: [false])
                          : () {},
                  title: 'Meaningful Relationships',
                  description:
                      'Identify your most meaningful, positive, and rejuvenating relationships. ',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap: Get.find<ConnectionController>()
                              .history
                              .value
                              .value! >=
                          100
                      //     ||
                      // Get.find<ConnectionController>()
                      //         .history
                      //         .value
                      //         .value ==
                      //     99
                      ? () =>
                          Get.to(() => const Community(), arguments: [false])
                      : () {},
                  title: 'Community',
                  description:
                      'Identify groups that you can give your time to gratefully and receive support from willingly. These groups can aid in increasing your sense of purpose, financial health, and happiness.',
                ).marginOnly(bottom: 30),
              ],
            ).marginOnly(left: 25, right: 25),
          ],
        ),
      ),
    );
  }
}

class ConnectionJournal extends StatelessWidget {
  const ConnectionJournal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            headline('Connection Journal').marginOnly(bottom: 30),
            Column(
              children: [
                AppButton(
                  onTap:
                      Get.find<ConnectionController>().history.value.value! >=
                              95
                          ? () => Get.to(
                                () => const ConnectionJournalLvl0(),
                                arguments: [false],
                              )
                          : () {},
                  title: 'Lvl 0 - Simply Reach Out',
                  description:
                      'Give & receive support. Acknowledge and & listen to others.',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap:
                      Get.find<ConnectionController>().history.value.value! >=
                              98
                          ? () => Get.to(() => const ConnectionJournalLvl1(),
                              arguments: [false])
                          : () {},
                  title: 'Lvl 1 - Meaningful Relationships',
                  description:
                      'Cultivate your most meaningful relationships. Give & receive support. Acknowledge and & listen to others. ',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap:
                      Get.find<ConnectionController>().history.value.value! >=
                              101
                          ? () => Get.to(
                                () => const ConnectionJournalLvl2(),
                                arguments: [false],
                              )
                          : () {},
                  title: 'Lvl 2 - Meaningful Relationships & Community',
                  description:
                      'Invest in & lead your community. Cultivate your most meaningful relationships. Give & receive support. Acknowledge and & listen to others. ',
                ).marginOnly(bottom: 30),
              ],
            ).marginOnly(left: 25, right: 25),
          ],
        ),
      ),
    );
  }
}
