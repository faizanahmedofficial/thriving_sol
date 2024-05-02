// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Functions/time_picker.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_button.dart';

import '../../Global/firebase_collections.dart';
import '../../Model/routine_model.dart';
import '../../Widgets/custom_snackbar.dart';
import '../../Widgets/loading_dialog.dart';
import '../../Widgets/widgets.dart';
import '../custom_bottom.dart';

class MRController extends GetxController {
  RxInt index = 0.obs;

  Rx<RoutineModel> routineModel = RoutineModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
    type: 0,
  ).obs;
  
  RxList<Routines> routines = <Routines>[
    Routines(
      name: 'Morning Routine',
      starttime: '',
      duration: '',
      seconds: 0,
      nudges: nudges(),
      elements: [addElements()],
      color: 0xffDAF4FA,
      days: <bool>[true, true, true, true, true, true, true],
      alarm: 0,
    ),
    Routines(
      name: 'Afternoon Routine',
      starttime: '',
      duration: '',
      seconds: 0,
      nudges: nudges(),
      elements: [addElements()],
      color: 0xffFFF6A5,
      days: <bool>[true, true, true, true, true, true, true],
      alarm: 0,
    ),
    Routines(
      name: 'Evening Routine',
      starttime: '',
      duration: '',
      seconds: 0,
      nudges: nudges(),
      elements: [addElements()],
      color: 0xffE4C6FA,
      days: <bool>[true, true, true, true, true, true, true],
      alarm: 0,
    ),
  ].obs;

  updateIndex() => index.value = index.value + 1;

  moveToNext() {
    switch (index.value) {
      case 0:
        updateIndex();
        break;
      case 1:
        break;
    }
  }

  Future adRoutine() async {
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
}

class ManualRoutines extends StatefulWidget {
  const ManualRoutines({Key? key}) : super(key: key);

  @override
  State<ManualRoutines> createState() => _ManualRoutinesState();
}

class _ManualRoutinesState extends State<ManualRoutines> {
  final MRController controller = Get.put(MRController());
  final RxBool rearrange = false.obs;
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
  void initState() {
    _scroll.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(
          leading: backButton(),
          implyLeading: true,
        ),
        body: SingleChildScrollView(
          controller: _scroll,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 50,
            bottom: 10,
          ),
          child: Column(
            children: [
              controller.index.value == 0
                  ? _Routines(rearrange: rearrange.value)
                  : Container(),
              Column(
                children: [
                  CustomOutlineButton(
                    title: rearrange.value
                        ? 'Customize your routine'
                        : 'Re-arrange the order of your routine',
                    ontap: () {
                      rearrange.value = !rearrange.value;
                      _scroll.animateTo(
                        0,
                        duration: const Duration(milliseconds: 3),
                        curve: Curves.linear,
                      );
                    },
                  ).marginOnly(bottom: 10),
                  CustomOutlineButton(
                    title: 'Create your personalized routine now!',
                    ontap: () => controller.adRoutine(),
                  ),
                ],
              ).marginOnly(top: 50, bottom: 10, left: 15, right: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class _Routines extends StatefulWidget {
  const _Routines({Key? key, required this.rearrange}) : super(key: key);
  final bool rearrange;

  @override
  State<_Routines> createState() => __RoutinesState();
}

class __RoutinesState extends State<_Routines> {
  final MRController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: List.generate(
          controller.routines.length,
          (index) {
            final Routines _routine = controller.routines[index];
            return ManualRoutineWidget(
              _routine,
              rearrange: widget.rearrange,
              selectStart: () async {
                await customTimePicker(context, initialTime: TimeOfDay.now())
                    .then((value) {
                  setState(() {
                    _routine.starttime = value.format(context);
                  });
                });
              },
              deleteRoutine: () {
                setState(() {
                  controller.routines.removeAt(index);
                });
              },
            );
          },
        ),
      ),
    );
  }
}
