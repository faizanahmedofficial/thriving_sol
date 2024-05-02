// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Screens/Purpose/exercises/ideal_time.dart';
import 'package:schedular_project/Screens/Purpose/exercises/pomodoro_screen.dart';
import 'package:schedular_project/Screens/Purpose/journals/tactical_review.dart';
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
import 'journals/action_journal_lvl0.dart';
import 'journals/action_journal_level3.dart';
import 'journals/action_journal_lvl1.dart';
import 'journals/action_journal_lvl2.dart';
import 'exercises/habits_builder.dart';
import 'exercises/nudges_screen.dart';
import '../../Widgets/widgets.dart';

class BdController extends GetxController {
  final Rx<CurrentExercises> history = CurrentExercises(
    id: bd,
    index: 0,
    value: 116,
    time: DateTime.now(),
    completed: false,
    connectedReading: 116,
    connectedPractice: 117,
    previousReading: 116,
    previousPractice: 116,
  ).obs;

late Timer timer;
  @override
  void onInit() async {
    await fetchHistory();
    if (routine) {
      DateTime start = DateTime.now();
  timer=    Timer(
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
        .doc(bd)
        .get()
        .then((value) async {
      if (value.data() == {} || value.data() == null) {
        await currentExercises(Get.find<AuthServices>().userid)
            .doc(bd)
            .set(history.value.toMap());
      } else {
        history.value = CurrentExercises.fromMap(value.data());
      }
    });
    appModel.value = bdList[bdListIndex(history.value.value!)];
  }

  Rx<AppModel> appModel = AppModel('', '').obs;
  Future updateReadingHistory(int duration) async {
    if (appModel.value.type == 1) {
      userReadings(Get.find<AuthServices>().userid)
          .update({'behavioral design.element': history.value.value});
      addReadingAccomplishment(duration);
    }
  }

  Future addReadingAccomplishment(int duration) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == bd);
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
        .where((value) => value.id == bd);
    if (list.isNotEmpty) {
      list.first.advanced = appModel.value.title;
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future updateHistory(int duration) async {
    if (history.value.value != 133 && !history.value.completed!) {
      await updateReadingHistory(duration);
      history.value.value = history.value.value! + 1;
      _updateData();
    } else if (history.value.value == 133) {
      await updateReadingHistory(duration);
      history.value.value = 131;
      history.value.completed = true;
      _updateData();
    }
  }

  _updateData() async {
    final _intro = bdList[bdListIndex(history.value.value!)];
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
    addAdvancedAccomplishment();
  }

  List<AppModel> get readinglist =>
      bdList.where((element) => element.type == 1).toList();

  selectData(int value) {
    appModel.value = bdList[bdListIndex(value)];
    history.value = CurrentExercises(
      id: bd,
      index: 0,
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

class BdHome extends StatelessWidget {
  BdHome({Key? key}) : super(key: key);
  final BdController controller = Get.put(BdController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              headline('Planning & Behavioral Design').marginOnly(bottom: 30),
              TopList(
                list: bdList,
                value: controller.history.value.value!,
                onchanged: (val){},// (val) => controller.selectData(val),
                play: controller.appModel.value.ontap,
              ),
              Column(
                children: [
                  AppButton(
                    onTap: () => Get.to(() => const ActionJournal()),
                    title: 'Action Journal',
                    description:
                        'Take action now and always do what you want to do. Work towards your most important and highest priority tasks efficiently and carve out massive amounts of free time.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => const BdExercises()),
                    title: 'Exercise for Habits & Productivity',
                    description:
                        'Design your life and environment so good habits are the easiest and most natural choice while bad habits are difficult and not worth the effort.  Conquer procrastination, confusion, and lack of freedom.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => BdReadings()),
                    title: 'Planning & Behavioral Design Library',
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

class BdReadings extends StatelessWidget {
  BdReadings({Key? key}) : super(key: key);
  final BdController controller = Get.find();

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
            headline('Planning & Behavioral Design Library')
                .marginOnly(bottom: 20),
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
                      child: elementTitle('Planning & Behavioral Design'),
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

class ActionJournal extends StatelessWidget {
  const ActionJournal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            headline('Action Journal').marginOnly(bottom: 30),
            Column(
              children: [
                AppButton(
                  onTap: () => Get.to(() => const ActionJournalLvl0(),
                      arguments: [false]),
                  title: 'Lvl0- Honest Accounting',
                  description:
                      'Plan what to get done, prioritize, and stay accountable.',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap: () => Get.to(
                    () => const ActionJournalLvl1(),
                    arguments: [false],
                  ),
                  title: 'Lvl1- Tactical Accounting',
                  description:
                      'Plan what to get done, prioritize, and stay accountable. Move closer to your ideal use of time.',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap: () => Get.to(() => const ActionJournalLvl2(),
                      arguments: [false]),
                  title: 'Lvl2- Tactical Priorities',
                  description:
                      'Plan what to get done, prioritize, and stay accountable. Move closer to your ideal use of time & get more important work done.',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap: () => Get.to(() => const ActionJournalLvl3(),
                      arguments: [false]),
                  title: 'Lvl3- Tactical Precision',
                  description:
                      'Plan what to get done, prioritize, and stay accountable. Move closer to your ideal use of time & get more important work done.',
                ).marginOnly(bottom: 30),
              ],
            ).marginOnly(left: 25, right: 25),
          ],
        ),
      ),
    );
  }
}

class BdExercises extends StatelessWidget {
  const BdExercises({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            headline('Exercises for Habits & Productivity')
                .marginOnly(bottom: 30),
            Column(
              children: [
                AppButton(
                  onTap: () => Get.to(
                    () => const NudgesScreen(),
                    arguments: [false],
                  ),
                  title: 'Nudges',
                  description:
                      'Use behavioral science "nudges" to increase your chances of showing up for your routines.',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap: () =>
                      Get.to(() => const HabitsBuilder(), arguments: [false]),
                  title: 'Habits Builder',
                  description:
                      'Use behavioral science to increase your chances of forming a lifelong habit.',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap: () => Get.to(
                    () => const IdealTimeScreen(),
                    arguments: [false],
                  ),
                  title: 'Ideal Time Use',
                  description:
                      'How would you like to use your time? Create your ideal use of time so you can measure it against your actual use of time and narrow the gap.',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap: () => Get.to(
                    () => const PomodoroScreen(),
                    arguments: [false],
                  ),
                  title: 'Pomodoro Timer',
                  description:
                      'Ensure you keep your mind fresh and more productive with regular breaks.',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap: () => Get.to(() => const TacticalReviewScreen(),
                      arguments: [false]),
                  title: 'Tactical Review',
                  description:
                      'Review what you got done and how you spent your time. Create custom strategies to maximize your leisure time while still reaching your dreams.',
                ).marginOnly(bottom: 30),
              ],
            ).marginOnly(left: 25, right: 25),
          ],
        ),
      ),
    );
  }
}
