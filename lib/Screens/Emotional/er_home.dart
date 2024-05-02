// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/functions.dart';
import '../../Controller/play_routine_controller.dart';
import '../../Widgets/dialogs.dart';
import '../../Widgets/widgets.dart';
import 'Exercises/abc_root_analysis.dart';
import 'Exercises/fact_checking.dart';
import 'journals/emotional_analysis.dart';
import 'journals/emotional_analysis_sf.dart';
import 'journals/emotional_check_in.dart';
import 'journals/emotional_checkin_sf.dart';
import 'journals/observe_full_version.dart';
import 'journals/observe_sf.dart';
import 'journals/thought_analysis.dart';
import 'journals/thought_analysis_sf.dart';
import 'journals/thought_checkin.dart';
import 'journals/thought_checkin_sf.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import '../../Global/firebase_collections.dart';
import '../../Model/app_modal.dart';
import '../../Model/app_user.dart';
import '../../Services/auth_services.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/text_widget.dart';
import 'Exercises/baby_reframing.dart';
import 'Exercises/congnitive_distortions.dart';
import 'Exercises/fact_checking_your_thoughts.dart';
import 'Exercises/reframing.dart';
import 'Exercises/resolution.dart';
import 'Exercises/behavioral_activation.dart';
import '../custom_bottom.dart';

class ErController extends GetxController {
  final Rx<CurrentExercises> history = CurrentExercises(
    id: er,
    index: 5,
    value: 67,
    time: DateTime.now(),
    connectedPractice: 71,
    connectedReading: 67,
    previousReading: 67,
    previousPractice: 67,
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
        .doc(er)
        .get()
        .then((value) async {
      if (value.data() == {} || value.data() == null) {
        await currentExercises(Get.find<AuthServices>().userid)
            .doc(er)
            .set(history.value.toMap());
      } else {
        history.value = CurrentExercises.fromMap(value.data());
      }
    });
    appModel.value = erList[erListIndex(history.value.value!)];
  }

  Rx<AppModel> appModel = AppModel('', '').obs;
  Future updateReadingHistory(int duration) async {
    if (appModel.value.type == 1) {
      userReadings(Get.find<AuthServices>().userid).update({
        'emotional regulation.element': history.value.value,
      });
      addReadingAccomplishment(duration);
    }
  }

  Future addReadingAccomplishment(int duration) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id ==er);
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
        .where((value) => value.id ==er);
    if (list.isNotEmpty) {
      list.first.advanced = appModel.value.title;
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future updateHistory(int duration) async {
    if (history.value.value != 93 && !history.value.completed!) {
      await updateReadingHistory(duration);
      history.value.value = history.value.value! + 1;
      _updateData();
    } else if (history.value.value == 93) {
      await updateReadingHistory(duration);
      history.value.value = 91;
      history.value.completed = true;
      _updateData();
    }
  }

  _updateData() async {
    final _intro = erList[erListIndex(history.value.value!)];
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
      erList.where((element) => element.type == 1).toList();

  selectData(int value) {
    appModel.value = erList[erListIndex(value)];
    history.value = CurrentExercises(
      id: er,
      index: 5,
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

class ErHome extends StatelessWidget {
  ErHome({Key? key}) : super(key: key);
  final ErController controller = Get.put(ErController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              headline('Emotional Regulation (ER)').marginOnly(bottom: 30),
              TopList(
                list: erList,
                // controller.history.value.value == 93
                //     ? controller.history.value.value!
                //     : controller.history.value.connectedReading ==
                //     controller.history.value.value
                //     ? controller.history.value.connectedPractice ??
                //     controller.history.value.value!
                //     :
                value: controller.history.value.value!,
                onchanged: (val){},
                // (val) => controller
                //     .selectData(val), // controller.history.value.value = val;,
                play: controller.appModel.value.ontap,
              ),
              Column(
                children: [
                  AppButton(
                    onTap: () => Get.to(() => const ERJournalScreen()),
                    title: 'ER Journal',
                    description:
                        'This is your place to consistently improve your control of emotions, decision-making, and understanding of your thoughts, emotions, and behaviors.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => const ERExerciseScreen()),
                    title: 'ER Exercises',
                    description:
                        'This is where you discover the tools to understand and change the inner workings of your thought processes, emotions, and behaviors.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => ErReading()),
                    title: 'ER Library',
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

class ErReading extends StatelessWidget {
  ErReading({Key? key}) : super(key: key);
  final ErController controller = Get.find();

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
            headline('Emotional Regulation (ER) Library')
                .marginOnly(bottom: 20),
            CustomContainer(
              background: const Color(0xffC2EFC5),
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
                      child: elementTitle('Emotional Regulation (ER)'),
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

class ERExerciseScreen extends StatelessWidget {
  const ERExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
        child: Column(
          children: [
            headline('Emotional Regulation (ER) Exercises')
                .marginOnly(bottom: 50),
            Column(
              children: [
                AppButton(
                  onTap: () =>
                      Get.to(() => BabyReframing(), arguments: [false]),
                  title: 'Baby Reframing',
                  description:
                      'Change your mood and outlook by reframing your thoughts.',
                ).marginOnly(bottom: 20),
                AppButton(
                  onTap: () =>
                      Get.to(() => const BAScreen(), arguments: [false]),
                  title: 'Behavioral Activation',
                  description: 'Plan fun & joy back into your life.',
                ).marginOnly(bottom: 20),
                AppButton(
                  // onTap: Get.find<ErController>().history.value.value! == 75 ||
                  //         Get.find<ErController>().history.value.value == 93
                  //     ?
                  onTap: () => Get.to(() => const Resolution(),
                      arguments: [false]), // : () {},
                  title: 'Resolve the Situation',
                  description:
                      'Resolve situations intelligently to create positive outcomes. Take action now, plan for the future, or learn from the past.',
                ).marginOnly(bottom: 20),
                AppButton(
                  // onTap: Get.find<ErController>().history.value.value == 79 ||
                  //         Get.find<ErController>().history.value.value == 93
                  //     ?
                  onTap: () => Get.to(() => const AbcRootAnalysis(),
                      arguments: [false]), //  : () {},
                  title: 'ABC Root Analysis',
                  description:
                      'Find the root cause of thought & behavioral patterns.',
                ).marginOnly(bottom: 20),
                AppButton(
                  // onTap: Get.find<ErController>().history.value.value == 83 ||
                  //         Get.find<ErController>().history.value.value == 93
                  //     ?
                  onTap: () => Get.to(() => const FactChecking(),
                      arguments: [false]), // : () {},
                  title: 'Fact Checking Test',
                  description:
                      'How well can you really discern fact from opinion?',
                ).marginOnly(bottom: 20),
                AppButton(
                  // onTap: Get.find<ErController>().history.value.value == 84 ||
                  //         Get.find<ErController>().history.value.value == 93
                  //     ?
                  onTap: () => Get.to(() => const FactCheckingYourThoughts(),
                      arguments: [false]),
                  // : () {},
                  title: 'Fact Checking Thoughts',
                  description: 'Check your own thoughts for factual validity.',
                ).marginOnly(bottom: 20),
                AppButton(
                  // onTap: Get.find<ErController>().history.value.value == 88 ||
                  //         Get.find<ErController>().history.value.value == 93
                  //     ?
                  onTap: () => Get.to(
                    () => const CognitiveDistortion(),
                    arguments: [false],
                  ),
                  // : () {},
                  title: 'Cognitive Distortions in Yourself',
                  description: 'What thinking patterns are holding you back?',
                ).marginOnly(bottom: 20),
                AppButton(
                  // onTap: Get.find<ErController>().history.value.value == 90 ||
                  //         Get.find<ErController>().history.value.value == 93
                  //     ?
                  onTap: () =>
                      Get.to(() => const Reframing(), arguments: [false]),
                  // : () {},
                  title: 'Reframing',
                  description:
                      'Use all that you\'ve learned to change your mood and outlook by reframing your thoughts.',
                ).marginOnly(bottom: 20),
              ],
            ).marginOnly(left: 20, right: 20),
          ],
        ),
      ),
    );
  }
}

class ERJournalScreen extends StatelessWidget {
  const ERJournalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
        child: Column(
          children: [
            headline('Emotional Regulation (ER) Journal')
                .marginOnly(bottom: 30),
            const TextWidget(
              text:
                  'This is your space to check in with your emotions & thoughts to get a hold of difficult emotions and situations to feel better, make better decisions, and take intelligent action. ',
              fontStyle: FontStyle.italic,
              alignment: Alignment.center,
              textAlign: TextAlign.center,
            ).marginOnly(left: 15, right: 15, bottom: 20),
            titles(
              'Level 0- Observe',
              alignment: Alignment.center,
              textAlign: TextAlign.center,
            ).marginOnly(bottom: 20),
            Get.find<ErController>().history.value.value! >= 71 ||
                    Get.find<ErController>().history.value.value! >= 72 ||
                    Get.find<ErController>().history.value.value! >= 67
                ? erButtons(
                    () => Get.to(() => const ObserveFullForm(),
                        arguments: [false]),
                    () => Get.to(() => const ObserveSF(), arguments: [false]),
                  )
                : erButtons(() {}, () {}),
            titles(
              'Level 1- Emotional Check In',
              alignment: Alignment.center,
              textAlign: TextAlign.center,
            ).marginOnly(bottom: 20),
            Get.find<ErController>().history.value.value! >= 76 ||
                    Get.find<ErController>().history.value.value! >= 77 ||
                    Get.find<ErController>().history.value.value! >= 73
                ? erButtons(
                    () => Get.to(() => const EmotionalCheckIn(),
                        arguments: [false]),
                    () => Get.to(
                      () => const EmotionalCheckInSf(),
                      arguments: [false],
                    ),
                  )
                : erButtons(() {}, () {}),
            titles(
              'Level 2- Emotional Analysis',
              alignment: Alignment.center,
              textAlign: TextAlign.center,
            ).marginOnly(bottom: 20),
            Get.find<ErController>().history.value.value! >= 80 ||
                    Get.find<ErController>().history.value.value! >= 81 ||
                    Get.find<ErController>().history.value.value! >= 78
                ? erButtons(
                    () => Get.to(() => const EmotionalAnalysis(),
                        arguments: [false]),
                    () => Get.to(
                      () => const EmotionalAnalysisSf(),
                      arguments: [false],
                    ),
                  )
                : erButtons(() {}, () {}),
            titles(
              'Level 3- Thought Check In',
              alignment: Alignment.center,
              textAlign: TextAlign.center,
            ).marginOnly(bottom: 20),
            Get.find<ErController>().history.value.value! >= 85 ||
                    Get.find<ErController>().history.value.value! >= 86 ||
                    Get.find<ErController>().history.value.value! >= 82
                ? erButtons(
                    () => Get.to(() => const ThoughtCheckIn(),
                        arguments: [false]),
                    () => Get.to(() => const ThoughtCheckinSf(),
                        arguments: [false]),
                  )
                : erButtons(() {}, () {}),
            titles(
              'Level 4- Thought Analysis',
              alignment: Alignment.center,
              textAlign: TextAlign.center,
            ).marginOnly(bottom: 20),
            Get.find<ErController>().history.value.value! >= 91 ||
                    Get.find<ErController>().history.value.value! >= 92 ||
                    Get.find<ErController>().history.value.value! >= 89
                ? erButtons(
                    () => Get.to(() => const ThoughtAnalysis(),
                        arguments: [false]),
                    () => Get.to(() => const ThoughtAnalysisSf(),
                        arguments: [false]),
                  )
                : erButtons(() {}, () {}),
          ],
        ),
      ),
    );
  }

  Widget erButtons(VoidCallback first, VoidCallback second) {
    return JournalButtons(
      first: 'Full Version',
      second: 'Short Form',
      onFirst: first,
      onSecond: second,
    ).marginOnly(bottom: 40);
  }
}
