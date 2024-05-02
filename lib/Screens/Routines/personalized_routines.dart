// ignore_for_file: avoid_print, unused_element, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Functions/time_picker.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Screens/Routines/personalized_routine_data.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/buttons_theme.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_button.dart';
import 'package:schedular_project/Widgets/custom_snackbar.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/text_widget.dart';
import '../../Model/app_modal.dart';
import '../../Model/routine_model.dart';
import '../../Widgets/widgets.dart';
import '../custom_bottom.dart';

class PRController extends GetxController {
  RxInt index = 0.obs;
  RxInt time = 5.obs;
  RxInt goal = 5.obs;

  RxList<List<DaysModel>> days = <List<DaysModel>>[dayLists].obs;

  Rx<RoutineModel> routineModel = RoutineModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
    type: 1,
  ).obs;

  RxList<Routines> routines = <Routines>[].obs;
  RxList<TextEditingController> routineTimes = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
    // TextEditingController(),
  ].obs;

  RxInt split = (-1).obs; // 0: yes, 1:no

  moveToNext() {
    Get.focusScope!.unfocus();
    switch (index.value) {
      case 0:
        setTime();
        break;
      case 1:
        setGoal();
        break;
      case 2:
        spiltRoutine();
        break;
      case 3:
        setRoutineTime(); //updateIndex(4);
        break;
    }
  }

  updateIndex(int value) => index.value = value;

  spiltRoutine() {
    if (split.value == -1) {
      customSnackbar(
        title: 'Can\'t Proceed',
        message: 'Please select whether you want to split the routine or not',
        position: SnackPosition.BOTTOM,
      );
    } else {
      if (split.value == 0) {
        updateIndex(3);
      } else {
        setRoutineTime();
      }
    }
  }

  setTime() {
    routineModel.value.time = time.value;
    updateIndex(1);
  }

  setGoal() {
    if (goal.value == 5) {
      customSnackbar(
        title: 'No goal selected!',
        message: 'Please select a goal first',
        position: SnackPosition.BOTTOM,
      );
    } else {
      routineModel.value.goal = goal.value;
      updateIndex(2);
    }
  }

  int inSeconds() {
    return Duration(minutes: time.value == 0 ? 0 : time.value).inSeconds;
    // switch (time.value) {
    //   case 5:
    //     return 2970;
    //   case 10:
    //     return 5580;
    //   case 15:
    //     return 8280;
    //   case 20:
    //     return 10980;
    //   case 25:
    //     return 13680;
    //   case 30:
    //   case 35:
    //     return 16380;
    //   case 40:
    //   case 45:
    //     return 20580;
    //   case 50:
    //   case 55:
    //     return 24780;
    //   case 60:
    //   case 65:
    //   case 70:
    //   case 75:
    //   case 80:
    //     return 28980;
    //   case 85:
    //   case 90:
    //   case 95:
    //   case 100:
    //   case 105:
    //   case 110:
    //   case 115:
    //   case 120:
    //   case 0:
    //     return 36480;
    //   default:
    //     return 0;
    // }
  }

  final GlobalKey<FormState> timeKey = GlobalKey();
  setRoutineTime() {
    // timeKey.currentState!.save();
    // if (timeKey.currentState!.validate()) {
    routines.clear();
    loadingDialog(Get.context!);
    final List<RoutineElements> _elements =
        setRoutines(goal.value, inSeconds());
    if (split.value == 0) {
      final morning = _elements.where((element) => element.type == 0).toList();
      int mtotal = 0;
      for (int i = 0; i < morning.length; i++) {
        mtotal = mtotal + morning[i].seconds!;
      }
      routines.add(
        Routines(
          name: 'Morning Routine',
          starttime: routineTimes[0].text,
          color: 0xffDAF4FA,
          seconds: mtotal,
          duration: getDurationString(mtotal),
          elements: morning, //_addMorningRoutines(), //[selectElementType()],
          days: [true, true, true, true, true, true, true],
          alarm: 0,
        ),
      );
      // routines.add(
      //   Routines(
      //     name: 'Afternoon Routine',
      //     starttime: routineTimes[1].text,
      //     color: 0xffFFF6A5,
      //     seconds: 0,
      //     duration: getDurationString(0),
      //     elements: <RoutineElements>[],
      //     days: [true, true, true, true, true, true, true],
      //     alarm: 0,
      //   ),
      // );

      final evening = _elements.where((element) => element.type == 1).toList();
      int etotal = 0;
      for (int i = 0; i < evening.length; i++) {
        etotal = etotal + evening[i].seconds!;
      }
      routines.add(
        Routines(
          name: 'Evening Routine',
          starttime: routineTimes[1].text,
          color: 0xffE4C6FA,
          seconds: etotal,
          duration: getDurationString(etotal),
          elements: evening, //_addEveningRoutines(), //[selectElementType()],
          days: [true, true, true, true, true, true, true],
          alarm: 0,
        ),
      );
    } else {
      int mtotal = 0;
      for (int i = 0; i < _elements.length; i++) {
        mtotal = mtotal + _elements[i].seconds!;
      }
      routines.add(
        Routines(
          seconds: mtotal,
          duration: getDurationString(mtotal),
          elements: _elements,
          days: [true, true, true, true, true, true, true],
          alarm: 0,
          name: split.value == 2
              ? 'Morning Routine'
              : split.value == 1
                  ? 'Evening Routine'
                  : '',
          starttime: routineTimes[0].text,
          color: split.value == 2
              ? 0xffDAF4FA
              : split.value == 1
                  ? 0xffE4C6FA
                  : 0xffE4C6FA,
        ),
      );
      // }
    }
    Get.back();
    updateIndex(4);
  }

  Future addRoutine() async {
    Get.focusScope!.unfocus();
    loadingDialog(Get.context!);
    routineModel.value.seconds = 0;
    routineModel.value.routines = <Routines>[];
    for (int i = 0; i < routines.length; i++) {
      routineModel.value.seconds =
          routineModel.value.seconds! + routines[i].seconds!;
      for (int j = 0; j < routines[i].elements!.length; j++) {
        routines[i].elements![j].index = j;
      }
      routineModel.value.routines!.add(routines[i]);
    }
    routineModel.value.duration =
        getDurationString(routineModel.value.seconds!);
    await routineRef.doc(routineModel.value.id).set(routineModel.value.toMap());
    Get.back();
    Get.back();
    customSnackbar(title: 'Success', message: 'Routine created successfully');
  }

  final ScrollController _scroll = ScrollController();

  _scrollListener() {
    if (_scroll.offset >= _scroll.position.maxScrollExtent &&
        !_scroll.position.outOfRange) {
      print('bottom');
    }
    if (_scroll.offset <= _scroll.position.minScrollExtent &&
        !_scroll.position.outOfRange) {
      print('top');
    }
  }

  @override
  void onInit() {
    _scroll.addListener(_scrollListener);
    super.onInit();
  }

  previousIndex(int value) => index.value = value;

  moveBack() {
    switch (index.value) {
      case 0:
        Get.back();
        break;
      case 1:
        previousIndex(0);
        break;
      case 2:
        previousIndex(1);
        break;
      case 3:
        previousIndex(2); //updateIndex(4);
        break;
      case 4:
        previousIndex(split.value == 0 ? 3 : 2);
        break;
    }
  }
}

class PersonalizedRoutines extends StatefulWidget {
  const PersonalizedRoutines({Key? key}) : super(key: key);

  @override
  State<PersonalizedRoutines> createState() => _PersonalizedRoutinesState();
}

class _PersonalizedRoutinesState extends State<PersonalizedRoutines> {
  final PRController controller = Get.put(PRController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: bottomNavigation(),
        appBar: customAppbar(
          leading: backButton(
            () => controller.index.value == 0
                ? Get.back()
                : controller.moveBack(),
          ),
          implyLeading: true,
        ),
        body: SingleChildScrollView(
          controller: controller._scroll,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.index.value == 0
                  ? question1()
                  : controller.index.value == 1
                      ? question2()
                      : controller.index.value == 2
                          ? question4()
                          : controller.index.value == 3
                              ? question3()
                              : controller.index.value == 4
                                  ? const RoutineScreen()
                                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNavigation() {
    return controller.index.value == 4
        ? const SizedBox.shrink()
        : controller.index.value == 0 ||
                controller.index.value == 1 ||
                (controller.index.value == 2 &&
                    (controller.split.value == 0 ||
                        controller.split.value == -1))
            ? IconButton(
                alignment: Alignment.bottomRight,
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => controller.moveToNext(),
              )
            : controller.index.value == 3 ||
                    (controller.split.value == 1 || controller.split.value == 2)
                ? SizedBox(
                    height: 65,
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.3,
                          child: OutlinedButton(
                            onPressed: () => Get.back(),
                            style: outlineButton(radius: 7.0),
                            child: const TextWidget(
                              text: 'Cancel',
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ).marginOnly(right: 15),
                        SizedBox(
                          width: width * 0.6,
                          child: OutlinedButton(
                            onPressed: () => controller.moveToNext(),
                            style: outlineButton(radius: 7.0),
                            child: const TextWidget(
                              text: 'Get your routine now!',
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).marginOnly(bottom: 5, left: 10, right: 10)
                : const SizedBox.shrink();
  }

  Widget question1() {
    return Column(
      children: [
        const TextWidget(
          text:
              'How much total\n time will/ can you spare throughout the day including in the mornings, afternoon break, and in the evening to improve your physical, mental, emotional, and financial health?',
          weight: FontWeight.bold,
          size: 17,
          alignment: Alignment.center,
          textAlign: TextAlign.center,
        ).marginOnly(top: 30, bottom: 50),
        const TextWidget(
          text: 'I can/will invest a total time of...',
          weight: FontWeight.bold,
          size: 17,
        ).marginOnly(left: 20, right: 20),
        DropdownButtonFormField<int>(
          value: controller.time.value,
          decoration: inputDecoration(),
          onChanged: (val) => controller.time.value = val!,
          items: timeList
              .map(
                (e) => DropdownMenuItem(
                  value: e.value,
                  child: TextWidget(
                    text: e.title,
                    alignment: Alignment.centerLeft,
                  ),
                ),
              )
              .toList(),
        ).marginOnly(left: 19, right: 19),
      ],
    ).marginOnly(left: 5, right: 5);
  }

  Widget question2() {
    return Column(
      children: [
        const TextWidget(
          text:
              'What is the most important goal in your life right now? (choose the answer that fits the closest)',
          weight: FontWeight.bold,
          size: 17,
          alignment: Alignment.center,
          textAlign: TextAlign.center,
        ).marginOnly(top: 30, bottom: 40),
        Column(
          children: List.generate(
            goalsList.length,
            (index) => Stack(
              children: [
                AppButton(
                  title: goalsList[index].title,
                  description: goalsList[index].description,
                  onTap: () => controller.goal.value = goalsList[index].value!,
                ),
                if (controller.goal.value == goalsList[index].value)
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(Icons.check_circle, color: Colors.green),
                  ),
              ],
            ),
          ),
        ).marginOnly(left: 15, right: 15),
      ],
    );
  }

  Widget question3() {
    return Form(
      key: controller.timeKey,
      child: Column(
        children: [
          const TextWidget(
            text:
                'What times throughout the day will you start to improve your physical, mental, emotional, and financial health?',
            weight: FontWeight.bold,
            size: 17,
            alignment: Alignment.center,
            textAlign: TextAlign.center,
          ).marginOnly(top: 30, bottom: 70),
          Column(
            children: [
              timeWidget(
                'In the morning at',
                0,
                const Color(0xffDAF4FA),
              ).marginOnly(bottom: height * 0.1),
              // timeWidget(
              //   'In the afternoon at',
              //   1,
              //   const Color(0xffFFF6A5),
              // ).marginOnly(bottom: height * 0.1),
              timeWidget('In the evening at', 1, const Color(0xffE4C6FA)),
            ],
          ).marginOnly(left: 15, right: 15),
        ],
      ),
    );
  }

  Widget question4() {
    return Column(
      children: [
        const TextWidget(
          text: 'Will you create a morning routine, evening routine, or both?',
          weight: FontWeight.bold,
          size: 17,
          alignment: Alignment.center,
          textAlign: TextAlign.center,
        ).marginOnly(top: 70, bottom: 50),
        CustomRadioButton(
          value: 2,
          width: width,
          groupValue: controller.split.value,
          title: 'Morning (or anytime) routine',
          onChanged: (val) {
            controller.split.value = val;
          },
        ),
        CustomRadioButton(
          value: 1,
          width: width,
          groupValue: controller.split.value,
          title: 'Evening Routine',
          onChanged: (val) {
            controller.split.value = val;
          },
        ),
        CustomRadioButton(
          value: 0,
          width: width,
          groupValue: controller.split.value,
          title: 'Both',
          onChanged: (val) {
            controller.split.value = val;
          },
        ),
      ],
    ).marginOnly(left: 20, right: 20);
  }

  Widget timeWidget(String title, int index, Color color) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      decoration: BoxDecoration(color: color, border: Border.all()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextWidget(text: title, weight: FontWeight.bold, size: 16),
          SizedBox(
            width: width * 0.35,
            child: TextFormField(
              readOnly: true,
              controller: controller.routineTimes[index],
              decoration: inputDecoration(
                filled: true,
                filledColor: Colors.white,
                hint: 'HH:MM (Start time)',
              ),
              // validator: (val) {
              //   if (val!.isEmpty) {
              //     return '*Required';
              //   }
              //   return null;
              // },
              onTap: () async {
                await customTimePicker(Get.context!,
                        initialTime: TimeOfDay.now())
                    .then((value) {
                  controller.routineTimes[index].text =
                      value.format(Get.context!);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({Key? key}) : super(key: key);

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  final PRController controller = Get.find();
  final RxBool rearrange = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 10),
      child: Obx(
        () => Column(
          children: [
            ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: List.generate(
                controller.routines.length,
                (index) {
                  final Routines _routine = controller.routines[index];
                  return PersonalizedRoutineWidget(
                    _routine,
                    rearrange: rearrange.value,
                    deleteRoutine: () {
                      controller.routines.removeAt(index);
                    },
                    startTime: () async {
                      await customTimePicker(
                        context,
                        initialTime: _routine.starttime! == ''
                            ? TimeOfDay.now()
                            : getTimeFromString(_routine.starttime!),
                      ).then((value) {
                        setState(() {
                          _routine.starttime = value.format(context);
                        });
                      });
                    },
                  );
                },
              ),
            ).marginOnly(bottom: 50),
            Column(
              children: [
                CustomOutlineButton(
                  title: rearrange.value
                      ? 'Customize your routine'
                      : 'Re-arrange the order of your routine',
                  ontap: () {
                    rearrange.value = !rearrange.value;
                    controller._scroll.animateTo(
                      0,
                      duration: const Duration(milliseconds: 3),
                      curve: Curves.linear,
                    );
                    setState(() {});
                  },
                ).marginOnly(bottom: 10),
                CustomOutlineButton(
                  title: 'Create your personalized routine now!',
                  ontap: () async => await controller.addRoutine(),
                ),
              ],
            ).marginOnly(left: 15, right: 15, bottom: 30, top: 50),
          ],
        ),
      ),
    );
  }
}
