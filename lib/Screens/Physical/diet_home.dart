// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Screens/Physical/Journals/easy_shopping_list_lvl1.dart';

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
import 'Journals/food_journal_lvl_1.dart';
import '../../Widgets/widgets.dart';

class DietController extends GetxController {
  final Rx<CurrentExercises> history = CurrentExercises(
    id: diet,
    index: 4,
    value: 143,
    time: DateTime.now(),
    connectedPractice: 143,
    connectedReading: 143,
    previousPractice: 143,
    previousReading: 143,
    completed: false,
  ).obs;

late Timer timer;
  @override
  void onInit() async {
    await fetchHistory();
    if (routine) {
      DateTime start = DateTime.now();
    timer =  Timer(
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
        .doc(diet)
        .get()
        .then((value) async {
      if (value.data() == {} || value.data() == null) {
        await currentExercises(Get.find<AuthServices>().userid)
            .doc(diet)
            .set(history.value.toMap());
      } else {
        history.value = CurrentExercises.fromMap(value.data());
      }
    });
    appModel.value = dietList[dietListIndex(history.value.value!)];
  }

  Rx<AppModel> appModel = AppModel('', '').obs;
  Future updateReadingHistory(int duration) async {
    if (appModel.value.type == 1) {
      userReadings(Get.find<AuthServices>().userid)
          .update({'eating.element': history.value.value});
      addReadingAccomplishment(duration);
    }
  }

  Future addReadingAccomplishment(int duration) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == diet);
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
        .where((value) => value.id == diet);
    if (list.isNotEmpty) {
      list.first.advanced = appModel.value.title;
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future updateHistory(int duration) async {
    if (history.value.value != 146 && !history.value.completed!) {
      await updateReadingHistory(duration);
      history.value.value = history.value.value! + 1;
      _updateData();
    } else if (history.value.value == 146) {
      await updateReadingHistory(duration);
      history.value.value = 145;
      history.value.completed = true;
      _updateData();
    }
  }

  _updateData() async {
    final _intro = dietList[dietListIndex(history.value.value!)];
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
      dietList.where((element) => element.type == 1).toList();
  
  selectData(int value) {
    appModel.value = dietList[dietListIndex(value)];
    history.value = CurrentExercises(
      id: diet,
      index: 4,
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

class DietHome extends StatelessWidget {
  DietHome({Key? key}) : super(key: key);
  final DietController controller = Get.put(DietController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              headline('Diet').marginOnly(bottom: 30),
              TopList(
                list: dietList,
                value: controller.history.value.value!,
                onchanged: (val){},// (val) => controller.selectData(val),
                play: controller.appModel.value.ontap,
              ),
              Column(
                children: [
                  AppButton(
                    onTap: () =>
                        Get.to(() => const FJLvl1(), arguments: [false]),
                    title: 'Food Journal',
                    description:
                        'Make smarter food choices lifelong habits. Keep these choices in the front of your mind here and track them.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => const EasyShoppingList1(),
                        arguments: [false]),
                    title: 'Easy Shopping List',
                    description:
                        'Review your week and make eating right easier by surrounding yourself with food and drinks that encourage physical health, healthy body fat levels, and increased longevity.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => DietReadings()),
                    title: 'Diet Library',
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

class DietReadings extends StatelessWidget {
  DietReadings({Key? key}) : super(key: key);
  final DietController controller = Get.find();

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
            headline('Diet Library').marginOnly(bottom: 20),
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
                      child: elementTitle('Diet'),
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
