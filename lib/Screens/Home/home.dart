// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/commons.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Controller/user_controller.dart';
import 'package:schedular_project/Database/cloud_firestore.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/app_user.dart';
import 'package:schedular_project/Model/routine_model.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_button.dart';
import 'package:schedular_project/Widgets/custom_snackbar.dart';
import 'package:schedular_project/Widgets/drop_down_button.dart';
import 'package:schedular_project/Widgets/progress_indicator.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';
import 'package:schedular_project/Widgets/widgets.dart';

import '../../Constants/colors.dart';
import '../../Controller/play_routine_controller.dart';
import '../../Functions/date_picker.dart';
import '../../Functions/time_picker.dart';
import '../../Theme/buttons_theme.dart';
import '../../Theme/input_decoration.dart';
import '../../Widgets/custom_images.dart';
import '../../app_icons.dart';

String today = formateDate(DateTime.now());

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController date = TextEditingController(
    text: formateDate(DateTime.now()),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: customAppbar(
        title: 'Thriving.org',
        titleAlignment: Alignment.topLeft,
        actions: appactions,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: date,
                readOnly: true,
                decoration: decoration(),
                onTap: () {
                  customDatePicker(
                    context,
                    initialDate: date.text.isEmpty
                        ? DateTime.now()
                        : convertToDateTime(date.text),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  ).then((value) {
                    setState(() {
                      date.text = formateDate(value);
                    });
                  });
                },
              ),
            ),
            StreamBuilder(
              initialData: const [],
              stream: fetchroutines(Get.find<AuthServices>().userid),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data.docs.isEmpty) {
                  return CircularLoadingWidget(
                    height: height * 0.5,
                    onCompleteText: 'Nothing to show...',
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    RoutineModel _routine =
                        RoutineModel.fromMap(snapshot.data.docs[index]);
                    return HomeRoutines(routine: _routine, date: date.text);
                  },
                );
              },
            ).marginOnly(top: 50),
          ],
        ),
      ),
    );
  }
}

class HomeRoutines extends StatefulWidget {
  const HomeRoutines({
    Key? key,
    required this.routine,
    required this.date,
  }) : super(key: key);
  final RoutineModel routine;
  final String date;

  @override
  State<HomeRoutines> createState() => _HomeRoutinesState();
}

class _HomeRoutinesState extends State<HomeRoutines> {
  final PlayRoutineController playroutine = Get.put(PlayRoutineController());

  updateAccomplishment(Routines _routine) {
    for (int i = 0; i < _routine.elements!.length; i++) {
      final list = Get.find<AuthServices>()
          .accomplishments
          .where((value) => value.category == _routine.elements![i].category);
      if (list.isNotEmpty) {
        list.first.total = list.first.total! + 1;
        list.first.max = list.first.max! + 1;
        list.first.routines!.add(ARoutines(
          name: _routine.name,
          count: 1,
          date: widget.date,
          duration: _routine.elements![i].seconds,
          id: widget.routine.id,
        ));
        accomplsihmentRef(Get.find<AuthServices>().userid)
            .doc(list.first.id)
            .update(list.first.toMap());
      }
    }
    userAccomplishments(Get.find<AuthServices>().userid)
        .where('name', isEqualTo: _routine.name)
        .where('parentid', isEqualTo: widget.routine.id)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          userAccomplishments(Get.find<AuthServices>().userid)
              .doc(doc.id)
              .update({
            'time': FieldValue.increment(_routine.seconds ?? 0),
            'current': FieldValue.increment(1),
            'longest': FieldValue.increment(1),
            'total': FieldValue.increment(1),
          });
        }
      } else if (value.docs.isEmpty) {
        userAccomplishments(Get.find<AuthServices>().userid).doc().set({
          'name': _routine.name,
          'parentid': widget.routine.id,
          'time': _routine.seconds,
          'current': 1,
          'longest': 1,
          'total': 1,
          'advanced': '',
        });
      }
    });
  }

  updateToday(int index, int eindex) async {
    await todayRoutines(Get.find<AuthServices>().userid)
        .where('date', isEqualTo: widget.date)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        TodayRoutines _today = TodayRoutines.fromMap(value.docs[0]);
        final _troutines = _today.routines!
            .where((element) => element.routineid == widget.routine.id);
        if (_troutines.isNotEmpty) {
          TRModel _routine = _troutines.first;
          final _currents =
              _routine.indexes!.where((element) => element.index == index);
          if (_currents.isNotEmpty) {
            TREModel _current = _currents.first;
            _current.elements!.add(eindex);
          } else {
            _routine.indexes!.add(TREModel(index: index, elements: [eindex]));
          }
        } else {
          _today.routines!.add(
            TRModel(
              routineid: widget.routine.id,
              indexes: [
                TREModel(index: index, elements: [eindex])
              ],
            ),
          );
        }
        Get.find<UserController>()
            .todaysList
            .where((p0) => p0.date == widget.date)
            .toList()
            .first = _today;
        todayRoutines(Get.find<AuthServices>().userid)
            .doc(value.docs[0].id)
            .update(_today.toMap());
      } else {
        TodayRoutines _today = TodayRoutines(
          date: widget.date,
          routines: [
            TRModel(
              routineid: widget.routine.id,
              indexes: [
                TREModel(index: index, elements: [eindex])
              ],
            )
          ],
        );
        Get.find<UserController>().todaysList.add(_today);
        todayRoutines(Get.find<AuthServices>().userid)
            .doc()
            .set(_today.toMap());
      }
    });

    await Get.find<UserController>()
        .fetchTodays(Get.find<AuthServices>().userid);
    print('updated');
  }

  bool checkPreviousComplete(int index) {
    print(widget.date);
    if (Get.find<AuthServices>()
        .todaysList
        .where((element) => element.date == widget.date)
        .isEmpty) {
      return false;
    } else if (Get.find<AuthServices>()
        .todaysList
        .where((element) => element.date == widget.date)
        .first
        .routines!
        .where((element) => element.routineid == widget.routine.id)
        .isEmpty) {
      return false;
    } else {
      return Get.find<AuthServices>()
          .todaysList
          .where((element) => element.date == widget.date)
          .first
          .routines!
          .where((element) => element.routineid == widget.routine.id)
          .first
          .indexes!
          .where((element) => element.index == index)
          .isNotEmpty;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: List.generate(
          (widget.routine.routines ?? []).length,
          (index) {
            Routines _routine = widget.routine.routines![index];
            return _routine.elements!.isEmpty
                ? Container()
                : Obx(
                    () => RoutineWidget(
                      title: _routine.name,
                      duration: _routine.duration,
                      completed: checkPreviousComplete(index),
                      onChanged: (val) {
                        setState(() {
                          _routine.completed = val;
                          if (index == widget.routine.routines!.length - 1) {
                            widget.routine.completed = true;
                          }
                          // routineRef
                          //     .doc(widget.routine.id)
                          //     .update(widget.routine.toMap());
                          // updateAccomplishment(_routine);
                          updateToday(index, -1);
                        });
                      },
                      play: () => playCategories(
                        _routine.elements![0].category!,
                        index,
                        0,
                        1,
                        _routine.elements!.length == 1
                            ? 0
                            : _routine.elements![1].category!,
                        widget.routine,
                        _routine.elements![0].seconds!,
                        false,
                        widget.date,
                      ),
                      ontap: () => Get.to(
                        () => const ViewRoutineScreen(),
                        arguments: [
                          widget.routine,
                          index,
                          checkPreviousComplete(index),
                          widget.date,
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class RoutineWidget extends StatelessWidget {
  const RoutineWidget({
    Key? key,
    required this.title,
    required this.duration,
    required this.completed,
    this.play,
    required this.onChanged,
    this.ontap,
  }) : super(key: key);
  final String? title, duration;
  final bool completed;
  final VoidCallback? play, ontap;
  final onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: play ?? () {},
              padding: EdgeInsets.zero,
              iconSize: 70,
            ),
            SizedBox(
              width: width * 0.3,
              child: InkWell(
                onTap: ontap ?? () {},
                child: TextWidget(
                  text: title ?? '',
                  maxline: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            TextWidget(text: '${duration ?? 'HH:MM:SS'} Duration'),
            completed
                ? const Icon(Icons.check, color: Colors.green, size: 50)
                : Checkbox(value: completed, onChanged: onChanged),
          ],
        ),
      ],
    );
  }
}

class ViewRoutineScreen extends StatefulWidget {
  const ViewRoutineScreen({Key? key}) : super(key: key);

  @override
  State<ViewRoutineScreen> createState() => _ViewRoutineScreenState();
}

class _ViewRoutineScreenState extends State<ViewRoutineScreen> {
  final Rx<RoutineModel> routineModel = (Get.arguments[0] as RoutineModel).obs;
  final int routineIndex = Get.arguments[1];
  final bool completed = Get.arguments[2];
  final Rx<Routines> _routine = Routines().obs;
  RxBool nudge = false.obs;
  TextEditingController date = TextEditingController(text: Get.arguments[3]);

  setData() {
    _routine.value = routineModel.value.routines![routineIndex];
  }

  Future updateData() async {
    // if (routineIndex == routineModel.value.routines!.length - 1) {
    //   routineModel.value.completed = true;
    // }
    routineModel.value.routines![routineIndex] = _routine.value;
    await routineRef
        .doc(routineModel.value.id)
        .update(routineModel.value.toMap());
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  updateAccomplishment(Routines _routine, int category, int index) {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.category == category);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: _routine.name,
        count: 1,
        date: date.text,
        duration: _routine.elements![index].seconds,
        id: routineModel.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
    userAccomplishments(Get.find<AuthServices>().userid)
        .where('name', isEqualTo: _routine.name)
        .where('parentid', isEqualTo: routineModel.value.id)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          userAccomplishments(Get.find<AuthServices>().userid)
              .doc(doc.id)
              .update({
            'time': FieldValue.increment(_routine.seconds ?? 0),
            'current': FieldValue.increment(1),
            'longest': FieldValue.increment(1),
            'total': FieldValue.increment(1),
          });
        }
      } else if (value.docs.isEmpty) {
        userAccomplishments(Get.find<AuthServices>().userid).doc().set({
          'name': _routine.name,
          'parentid': routineModel.value.id,
          'time': _routine.seconds,
          'current': 1,
          'longest': 1,
          'total': 1,
          'advanced': '',
        });
      }
    });
  }

  updateToday(int index, int eindex) async {
    print(date.text);
    await todayRoutines(Get.find<AuthServices>().userid)
        .where('date', isEqualTo: date.text)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        TodayRoutines _today = TodayRoutines.fromMap(value.docs[0]);
        final _troutines = _today.routines!
            .where((element) => element.routineid == routineModel.value.id);
        if (_troutines.isNotEmpty) {
          TRModel _routine = _troutines.first;
          final _currents =
              _routine.indexes!.where((element) => element.index == index);
          if (_currents.isNotEmpty) {
            TREModel _current = _currents.first;
            _current.elements!.add(eindex);
          } else {
            _routine.indexes!.add(TREModel(index: index, elements: [eindex]));
          }
        } else {
          _today.routines!.add(
            TRModel(
              routineid: routineModel.value.id,
              indexes: [
                TREModel(index: index, elements: [eindex])
              ],
            ),
          );
        }
        // Get.find<UserController>()
        //     .todaysList
        //     .where((p0) => p0.date == date.text)
        //     .toList()
        //     .first = _today;
        print(Get.find<UserController>().todaysList);
        todayRoutines(Get.find<AuthServices>().userid)
            .doc(value.docs[0].id)
            .update(_today.toMap());
      } else {
        TodayRoutines _today = TodayRoutines(
          date: date.text,
          routines: [
            TRModel(
              routineid: routineModel.value.id,
              indexes: [
                TREModel(index: index, elements: [eindex])
              ],
            )
          ],
        );
        Get.find<UserController>().todaysList.add(_today);
        todayRoutines(Get.find<AuthServices>().userid)
            .doc()
            .set(_today.toMap());
      }
    });
    await Get.find<UserController>()
        .fetchTodays(Get.find<AuthServices>().userid);
    print('updated');
    setState(() {});
  }

  bool checkPreviousComplete(int elements) {
    final todaylist = Get.find<AuthServices>()
        .todaysList
        .where((element) => element.date == date.text);
    if (todaylist.isEmpty) {
      return false;
    } else {
      final routines = todaylist.first.routines!
          .where((element) => element.routineid == routineModel.value.id);
      if (routines.isEmpty) {
        return false;
      } else {
        final indexes = routines.first.indexes!
            .where((element) => element.index == routineIndex);
        if (indexes.isEmpty) {
          return false;
        } else {
          final _elements = indexes.first.elements!
              .where((element) => element == elements)
              .toList();
          if (_elements.isEmpty) {
            return false;
          } else {
            return indexes.first.elements!.contains(elements);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 15),
                child: TextFormField(
                  controller: date,
                  readOnly: true,
                  decoration: decoration(),
                  onTap: () {
                    customDatePicker(
                      context,
                      initialDate: date.text.isEmpty
                          ? DateTime.now()
                          : convertToDateTime(date.text),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    ).then((value) {
                      setState(() {
                        date.text = formateDate(value);
                      });
                    });
                  },
                ),
              ),
              Row(
                children: [
                  Container(
                    width: width * 0.55,
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 10),
                    decoration: BoxDecoration(border: Border.all()),
                    child: TextWidget(
                      text: _routine.value.name!,
                      alignment: Alignment.center,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CustomIconTextButton(
                    text: 'Edit Routine...',
                    icon: assetImage(AppIcons.edit),
                    onPressed: () => Get.to(
                      () => EditRoutineScreen(routineModel.value, routineIndex),
                    ),
                  ),
                ],
              ).marginOnly(bottom: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  assetImage(AppIcons.bell, width: 20),
                  TextWidget(text: '${_routine.value.starttime!} (Start time)'),
                  assetImage(AppIcons.clock, width: 20),
                  TextWidget(
                    text: '${_routine.value.duration ?? ''} (Duration)',
                  ),
                ],
              ).marginOnly(left: 2, right: 2, bottom: 35),
              // if (routineModel.value.type == 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => Get.to(
                      () => NudgeScreen(routineModel.value, routineIndex),
                    ),
                    child: Container(
                      width: width * 0.6,
                      margin: const EdgeInsets.only(right: 30),
                      decoration: BoxDecoration(border: Border.all()),
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 10),
                      child: const TextWidget(
                        text: 'Nudges',
                        alignment: Alignment.center,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Checkbox(
                    value: nudge.value,
                    onChanged: (val) {
                      nudge.value = val!;
                      Get.to(
                        () => NudgeScreen(routineModel.value, routineIndex),
                      );
                    },
                  ),
                ],
              ).marginOnly(bottom: 35),
              Column(
                children: List.generate(
                  _routine.value.elements!.length,
                  (index) {
                    final RoutineElements _element =
                        _routine.value.elements![index];
                    return Obx(
                      () => RoutineWidget(
                        title: categoryList[categoryIndex(_element.category!)]
                            .title,
                        duration: _element.duration,
                        completed: checkPreviousComplete(index),
                        onChanged: (val) {
                          setState(() {
                            _element.completed = val;
                            updateToday(routineIndex, index);
                            // updateAccomplishment(
                            //   _routine.value,
                            //   _element.category!,
                            //   index,
                            // );
                            if (index == _routine.value.elements!.length - 1) {
                              _routine.value.completed = true;
                            }
                            // updateData();
                          });
                        },
                        play: () => playCategories(
                          _element.category!,
                          routineIndex,
                          index,
                          index + 1,
                          index == _routine.value.elements!.length - 1
                              ? 0
                              : _routine.value.elements![index + 1].category!,
                          routineModel.value,
                          _element.seconds!,
                          false,
                          date.text,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditRoutineScreen extends StatefulWidget {
  const EditRoutineScreen(this.routineModel, this.routineIndex, {Key? key})
      : super(key: key);
  final RoutineModel routineModel;
  final int routineIndex;

  @override
  State<EditRoutineScreen> createState() => _EditRoutineScreenState();
}

class _EditRoutineScreenState extends State<EditRoutineScreen> {
  Future saveRoutine() async {
    await routineRef
        .doc(widget.routineModel.id)
        .update(widget.routineModel.toMap());
    Get.back();
    Get.back();
    customSnackbar(
      title: 'Success!',
      message: 'Routine updated successfully',
      position: SnackPosition.BOTTOM,
    );
  }

  Future deleteRoutine() async {
    setState(() {
      Get.back();
      Get.back();
      Get.back();
      widget.routineModel.routines!.removeAt(widget.routineIndex);
      if (widget.routineModel.routines!.isEmpty) {
        routineRef.doc(widget.routineModel.id).delete();
      } else {
        routineRef
            .doc(widget.routineModel.id)
            .update(widget.routineModel.toMap());
      }
      customSnackbar(
        title: 'Success!',
        message: 'Routine has been deleted successfully.',
        position: SnackPosition.BOTTOM,
      );
    });
  }

  Future startTime() async {
    await customTimePicker(
      context,
      initialTime: getTimeFromString(
        widget.routineModel.routines![widget.routineIndex].starttime!,
      ),
    ).then((value) {
      setState(() {
        widget.routineModel.routines![widget.routineIndex].starttime =
            value.format(context);
      });
    });
  }

  deleteRoutineDialog() {
    Get.defaultDialog(
      title: 'Delete Routine',
      middleText:
          'Are you sure you want to delete your routine? This action is permanent.',
      textConfirm: 'Delete',
      onConfirm: () async => await deleteRoutine(),
      textCancel: 'Cancel',
      confirmTextColor: AppColors.white,
      titlePadding: const EdgeInsets.only(top: 10, bottom: 10),
      barrierDismissible: false,
    );
  }

  RxBool rearrange = false.obs;
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
    debugPrint(widget.routineModel.type.toString());
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        bottomNavigationBar: bottomNavigation(),
        body: SingleChildScrollView(
          controller: _scroll,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 10,
            bottom: 10,
          ),
          child: Column(
            children: [
              if (widget.routineModel.routines!.isNotEmpty)
                // widget.routineModel.type == 0 ?
                ManualRoutineWidget(
                  widget.routineModel.routines![widget.routineIndex],
                  deleteRoutine: () => deleteRoutineDialog(),
                  selectStart: () async => await startTime(),
                  rearrange: rearrange.value,
                ),
              // : PersonalizedRoutineWidget(
              //     widget.routineModel.routines![widget.routineIndex],
              //     rearrange: false,
              //     deleteRoutine: () => deleteRoutineDialog(),
              //     startTime: () async => await startTime(),
              //   ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNavigation() {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            // width: width * 0.3,
            child: OutlinedButton(
              onPressed: () {
                rearrange.value = !rearrange.value;
                _scroll.animateTo(
                  0,
                  duration: const Duration(milliseconds: 3),
                  curve: Curves.linear,
                );
              },
              style: outlineButton(radius: 7.0),
              child: TextWidget(
                text: rearrange.value
                    ? 'Customize your routine'
                    : 'Re-arrange the order of your routine',
                alignment: Alignment.center,
                textAlign: TextAlign.center,
              ),
            ),
          ).marginOnly(bottom: 5),
          SizedBox(
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
                    onPressed: () async => await saveRoutine(),
                    style: outlineButton(radius: 7.0),
                    child: const TextWidget(
                      text: 'Save & Complete',
                      alignment: Alignment.center,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).marginOnly(bottom: 5, left: 10, right: 10);
  }
}

class NudgeScreen extends StatefulWidget {
  const NudgeScreen(this.routineModel, this.index, {Key? key})
      : super(key: key);
  final RoutineModel routineModel;
  final int index;

  @override
  State<NudgeScreen> createState() => _NudgeScreenState();
}

class _NudgeScreenState extends State<NudgeScreen> {
  final Rx<Routines> _routine = Routines().obs;
  final Rx<Nudges> _nudges = Nudges().obs;
  final Rx<NudgeCompleted> _nudgeCompleted = NudgeCompleted().obs;

  setData() {
    _routine.value = widget.routineModel.routines![widget.index];
    _nudges.value = _routine.value.nudges!;
    _nudgeCompleted.value = _routine.value.nCompleted!;
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  Future updateData() async {
    _routine.value.nudges = _nudges.value;
    _routine.value.nCompleted = _nudgeCompleted.value;
    widget.routineModel.routines![widget.index] = _routine.value;
    await routineRef
        .doc(widget.routineModel.id)
        .update(widget.routineModel.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        bottomNavigationBar: IconButton(
          alignment: Alignment.centerRight,
          icon: assetImage(AppIcons.share),
          onPressed: () => Get.back(),
          padding: const EdgeInsets.only(right: 10, bottom: 10),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width,
                decoration: BoxDecoration(border: Border.all()),
                margin: const EdgeInsets.only(
                    bottom: 50, top: 10, left: 15, right: 15),
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 10),
                child: TextWidget(
                  text: _routine.value.name!,
                  alignment: Alignment.center,
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  assetImage(
                    AppIcons.cue,
                    fit: BoxFit.fitWidth,
                    width: 50,
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(text: 'Cue'),
                      CustomDropDownStruct(
                        child: DropdownButton(
                          value: _nudges.value.cue,
                          onChanged: (val) {
                            setState(() {
                              _nudges.value.cue = val;
                              updateData();
                            });
                          },
                          items: cueList
                              .map((e) => DropdownMenuItem(
                                    value: e.value,
                                    child: TextWidget(
                                      text: e.title,
                                      alignment: Alignment.centerLeft,
                                      size: 11,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      if (_nudges.value.cue == 3)
                        SizedBox(
                          width: width * 0.48,
                          child: TextFormField(
                            initialValue: _nudges.value.wcue,
                            decoration: inputDecoration(hint: 'Write in...'),
                            onChanged: (val) {
                              setState(() {
                                _nudges.value.wcue = val;
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                  Checkbox(
                    value: _nudgeCompleted.value.cue,
                    onChanged: (val) {
                      setState(() {
                        _nudgeCompleted.value.cue = val;
                        updateData();
                      });
                    },
                  ),
                ],
              ).marginOnly(left: 7, bottom: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  assetImage(
                    AppIcons.chain,
                    fit: BoxFit.fitWidth,
                    width: 50,
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(text: 'Chain'),
                      CustomDropDownStruct(
                        child: DropdownButton(
                          value: _nudges.value.chain,
                          onChanged: (val) {
                            setState(() {
                              _nudges.value.chain = val;
                              updateData();
                            });
                          },
                          items: chainList
                              .map((e) => DropdownMenuItem(
                                    value: e.value,
                                    child: TextWidget(
                                      text: e.title,
                                      alignment: Alignment.centerLeft,
                                      size: 12,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      if (_nudges.value.chain == 0)
                        SizedBox(
                          width: width * 0.48,
                          child: TextFormField(
                            initialValue: _nudges.value.wchain,
                            decoration: inputDecoration(hint: 'Write in...'),
                            onChanged: (val) {
                              setState(() {
                                _nudges.value.wchain = val;
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                  Checkbox(
                    value: _nudgeCompleted.value.chain,
                    onChanged: (val) {
                      setState(() {
                        _nudgeCompleted.value.chain = val;
                        updateData();
                      });
                    },
                  ),
                ],
              ).marginOnly(left: 7, bottom: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  assetImage(
                    AppIcons.reward,
                    fit: BoxFit.fitWidth,
                    width: 50,
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(text: 'Reward'),
                      CustomDropDownStruct(
                        child: DropdownButton(
                          value: _nudges.value.reward,
                          onChanged: (val) {
                            setState(() {
                              _nudges.value.reward = val;
                              updateData();
                            });
                          },
                          items: rewardList
                              .map((e) => DropdownMenuItem(
                                    value: e.value,
                                    child: TextWidget(
                                      text: e.title,
                                      alignment: Alignment.centerLeft,
                                      size: 12,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      if (_nudges.value.reward == 8)
                        SizedBox(
                          width: width * 0.48,
                          child: TextFormField(
                            initialValue: _nudges.value.wreward,
                            decoration: inputDecoration(hint: 'Write in...'),
                            onChanged: (val) {
                              setState(() {
                                _nudges.value.wreward = val;
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                  Checkbox(
                    value: _nudgeCompleted.value.reward,
                    onChanged: (val) {
                      setState(() {
                        _nudgeCompleted.value.reward = val;
                        updateData();
                      });
                    },
                  ),
                ],
              ).marginOnly(left: 7, bottom: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  assetImage(
                    AppIcons.setup,
                    fit: BoxFit.fitWidth,
                    width: 50,
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(text: 'Setup'),
                      SizedBox(
                        width: width * 0.5,
                        child: TextFormField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          initialValue: _nudges.value.setup,
                          onChanged: (val) {
                            setState(() {
                              _nudges.value.setup = val;
                              updateData();
                            });
                          },
                          decoration: inputDecoration(),
                        ),
                      ),
                    ],
                  ),
                  Checkbox(
                    value: _nudgeCompleted.value.setup,
                    onChanged: (val) {
                      setState(() {
                        _nudgeCompleted.value.setup = val;
                        updateData();
                      });
                    },
                  ),
                ],
              ).marginOnly(left: 7, bottom: 30),
            ],
          ),
        ),
      ),
    );
  }
}
