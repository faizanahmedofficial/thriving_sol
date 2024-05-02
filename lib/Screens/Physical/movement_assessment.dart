// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers
import 'dart:math' as math;
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:wakelock/wakelock.dart';

import '../../Common/journal_top.dart';
import '../../Constants/constants.dart';
import '../../Functions/functions.dart';
import '../../Functions/time_picker.dart';
import '../../Global/firebase_collections.dart';
import '../../Model/app_modal.dart';
import '../../Model/app_user.dart';
import '../../Model/movement_model.dart';
import '../../Services/auth_services.dart';
import '../../Widgets/app_bar.dart';
import '../../Widgets/checkboxRows.dart';
import '../../Widgets/checkboxes.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_snackbar.dart';
import '../../Widgets/custom_toast.dart';
import '../../Widgets/loading_dialog.dart';
import '../../Widgets/progress_indicator.dart';
import '../../Widgets/text_widget.dart';
import '../../Widgets/textbutton_icon.dart';
import '../../app_icons.dart';
import '../custom_bottom.dart';
import '../seek_bar.dart';
import 'movement_home.dart';
import 'movement_widget.dart';

class MovementAssessment extends StatefulWidget {
  const MovementAssessment({Key? key}) : super(key: key);

  @override
  State<MovementAssessment> createState() => _MovementAssessmentState();
}

class _MovementAssessmentState extends State<MovementAssessment> {
  TextEditingController name = TextEditingController(
      text: 'WeeklyMovementAssessment ${formatTitelDate(DateTime.now())}');
  TextEditingController currentTime =
      TextEditingController(text: formateDate(DateTime.now()));
  RxInt importantgoal = (-1).obs;
  RxInt resistancetraining = (-1).obs;
  RxInt dedicatedTime = (-1).obs;
  RxInt cardioTraining = (-1).obs;
  RxInt weekdays = (-1).obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: customAppbar(
            leading: backButton(
              () => edit
                  ? Get.back()
                  : index.value == 0
                      ? Get.back()
                      : goback(),
            ),
            implyLeading: true,
          ),
          bottomNavigationBar: index.value == 5
              ? Container(
                  height: 40,
                  margin:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.65,
                        child: CustomOutlinedButton(
                          text: 'Save & Add to Calendar',
                          onPressed: () async =>
                              edit ? await updateRoutine() : await addRoutine(),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.25,
                        child: CustomOutlinedButton(
                          text: 'Back',
                          onPressed: () => edit ? Get.back() : previousIndex(4),
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: 40,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => moveToNext(),
                      icon: const Icon(Icons.last_page),
                    ),
                  ),
                ),
          body: SingleChildScrollView(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Column(
              children: [
                title2(
                  edit
                      ? 'Movement Journal - Edit Routine (Practice)'
                      : 'Personalized Exercise/ Mobility Routine Creator 30 Seconds Weekly Routine Creator',
                ).marginOnly(bottom: 20),
                if (!edit)
                  JournalTop(
                    controller: name,
                    add: () => clearData(),
                    save: () async => edit
                        ? await updateRoutine(true)
                        : await addRoutine(true),
                    drive: () => Get.off(() => const PreviousAssessments()),
                  ).marginOnly(bottom: 40),
                index.value == 0
                    ? page1()
                    : index.value == 1
                        ? page2()
                        : index.value == 2
                            ? page3()
                            : index.value == 3
                                ? page4()
                                : index.value == 4
                                    ? page5()
                                    : index.value == 5
                                        ? page6()
                                        : Container(),
              ],
            ),
          ),
        );
      },
    );
  }

  goback() {
    switch (index.value) {
      case 1:
      case 2:
        previousIndex(0);
        break;
      case 3:
        previousIndex(2);
        break;
      case 4:
        if (importantgoal.value == 3 && dedicatedTime.value >= 4) {
          previousIndex(3);
        } else {
          previousIndex(2);
        }
        break;
      case 5:
        previousIndex(4);
        break;
    }
  }

  Widget page1() {
    return Column(
      children: [
        const TextWidget(
          text: 'What is your most important exercise goal?',
          weight: FontWeight.bold,
          size: 17,
          alignment: Alignment.center,
          textAlign: TextAlign.center,
        ).marginOnly(bottom: 20),
        Column(
          children: List.generate(
            movementGoals.length,
            (index) => Stack(
              children: [
                CustomOutlineButton(
                  title: movementGoals[index].title,
                  ontap: () =>
                      importantgoal.value = movementGoals[index].value!,
                ),
                if (movementGoals[index].value == importantgoal.value)
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                  ),
              ],
            ).marginOnly(bottom: 20),
          ),
        ),
      ],
    );
  }

  Widget page2() {
    return Column(
      children: [
        const TextWidget(
          text:
              'What type of resistance training do you prefer and have access to?',
          weight: FontWeight.bold,
          size: 17,
          alignment: Alignment.center,
          textAlign: TextAlign.center,
        ).marginOnly(bottom: 20),
        Column(
          children: List.generate(
            resistanceTraining.length,
            (index) => Stack(
              children: [
                CustomOutlineButton(
                  title: resistanceTraining[index].title,
                  ontap: () => resistancetraining.value =
                      resistanceTraining[index].value!,
                ),
                if (resistanceTraining[index].value == resistancetraining.value)
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                  ),
              ],
            ).marginOnly(bottom: 20),
          ),
        ),
      ],
    );
  }

  Widget page3() {
    return Column(
      children: [
        const TextWidget(
          text: 'How much time can you dedicate to each exercicse session?',
          weight: FontWeight.bold,
          size: 17,
          alignment: Alignment.center,
          textAlign: TextAlign.center,
        ).marginOnly(bottom: 20),
        Column(
          children: List.generate(
            dedicatedTimeList.length,
            (index) => Stack(
              children: [
                CustomOutlineButton(
                  title: dedicatedTimeList[index].title,
                  ontap: () =>
                      dedicatedTime.value = dedicatedTimeList[index].value!,
                ),
                if (dedicatedTimeList[index].value == dedicatedTime.value)
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                  ),
              ],
            ).marginOnly(bottom: 20),
          ),
        ),
      ],
    );
  }

  Widget page4() {
    return Column(
      children: [
        const TextWidget(
          text: 'What type of cardio training do you prefer?',
          weight: FontWeight.bold,
          size: 17,
          alignment: Alignment.center,
          textAlign: TextAlign.center,
        ).marginOnly(bottom: 20),
        Column(
          children: List.generate(
            cardioTrainingList.length,
            (index) => Stack(
              children: [
                CustomOutlineButton(
                  title: cardioTrainingList[index].title,
                  ontap: () =>
                      cardioTraining.value = cardioTrainingList[index].value!,
                ),
                if (cardioTrainingList[index].value == cardioTraining.value)
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                  ),
              ],
            ).marginOnly(bottom: 20),
          ),
        ),
      ],
    );
  }

  Widget page5() {
    return Column(
      children: [
        const TextWidget(
          text: 'How many days a week are you available to workout?',
          weight: FontWeight.bold,
          size: 17,
          alignment: Alignment.center,
          textAlign: TextAlign.center,
        ).marginOnly(bottom: 20),
        Column(
          children: List.generate(
            exerciseDaysList.length,
            (index) => Stack(
              children: [
                CustomOutlineButton(
                  title: exerciseDaysList[index].title,
                  ontap: () => weekdays.value = exerciseDaysList[index].value!,
                ),
                if (exerciseDaysList[index].value == weekdays.value)
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                  ),
              ],
            ).marginOnly(bottom: 20),
          ),
        ),
      ],
    );
  }

  Widget page6() {
    return Column(
      children: [
        const TextWidget(
          text: 'Your personalized exercise/ mobility weekly routine',
        ),
        const Divider(),
        const TextWidget(
          text:
              'This is your personalized weekly workout routine to meet your health and body composition goals while staying safe and balannced.\n\n Tweak the days of the week you workout and the time you start your workouts to customize your routine.',
        ).marginOnly(bottom: 30),
        Column(
          children: List.generate(
            exercises.length,
            (index) {
              final RoutineExercise _exercise = exercises[index];
              return AssessmentRoutineWidget(
                edit: edit,
                exercise: _exercise,
                journal: resistancetraining.value == 1 ||
                        resistancetraining.value == 2
                    ? true
                    : false,
                deleteRoutine: () {
                  exercises.removeAt(index);
                  setState(() {});
                },
                workouts: (val) {
                  setState(() {
                    _exercise.workouts = val;
                  });
                },
                calendar: (val) {
                  setState(() {
                    _exercise.calendar = val;
                  });
                },
                alarm: (val) {
                  setState(() {
                    _exercise.alarm = val;
                  });
                },
                start: () async {
                  await customTimePicker(
                    context,
                    initialTime: _exercise.start == ''
                        ? TimeOfDay.now()
                        : getTimeFromString(_exercise.start!),
                  ).then((value) {
                    setState(() {
                      _exercise.start = value.format(context);
                      final _next = DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        value.hour,
                        value.minute,
                      ).add(Duration(seconds: _exercise.duration!));
                      final _nexttime =
                          TimeOfDay(hour: _next.hour, minute: _next.minute);
                      _exercise.end = _nexttime.format(context);
                    });
                  });
                },
                end: () async {
                  await customTimePicker(
                    context,
                    initialTime: _exercise.end == ''
                        ? TimeOfDay.now()
                        : getTimeFromString(_exercise.end!),
                  ).then((value) {
                    setState(() {
                      _exercise.end = value.format(context);
                      final _previous = DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day,
                        value.hour,
                        value.minute,
                      ).subtract(Duration(seconds: _exercise.duration!));
                      final _previoustime = TimeOfDay(
                          hour: _previous.hour, minute: _previous.minute);
                      _exercise.start = _previoustime.format(context);
                    });
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  clearData() {
    index.value = 0;
    importantgoal.value = -1;
    resistancetraining.value = -1;
    cardioTraining.value = -1;
    dedicatedTime.value = -1;
    weekdays.value = -1;
    exercises.clear();
  }

  RxInt index = 0.obs;
  updateIndex(int value) => index.value = value;
  previousIndex(int value) => index.value = value;

  moveToNext() {
    switch (index.value) {
      case 0:
        {
          if (importantgoal.value == -1) {
            customSnackbar(
                title: 'Invalid Choice',
                message: 'Please select a goal before moving further');
          } else {
            if (importantgoal.value == 1) {
              updateIndex(1);
            } else {
              updateIndex(2);
            }
          }
        }
        break;
      case 1:
        {
          if (resistancetraining.value == -1) {
            customSnackbar(
                title: 'Invalid choice',
                message: 'Please select an option for resistance training');
          } else {
            updateIndex(2);
          }
        }
        break;
      case 2:
        {
          if (dedicatedTime.value == -1) {
            customSnackbar(
                title: 'Invalid Choice',
                message: 'Please select dedicated time.');
          } else {
            if (importantgoal.value == 3 && dedicatedTime.value >= 4) {
              updateIndex(3);
            } else {
              updateIndex(4);
            }
          }
        }
        break;
      case 3:
        {
          if (cardioTraining.value == -1) {
            customSnackbar(
                title: 'Invalid Choice',
                message: 'Please select a type of cardio training');
          } else {
            updateIndex(4);
          }
        }
        break;
      case 4:
        {
          if (weekdays.value == -1) {
            customSnackbar(
              title: 'Invalid Choice',
              message: 'Please select number of days a week for working out.',
            );
          } else {
            exercises.clear();
            selectRoutineWorkouts(
              dedicatedTime.value,
              importantgoal.value,
              cardioTraining.value,
              resistancetraining.value,
              weekdays.value,
            );
            // exercises.add(
            //   RoutineExercise(
            //     days: selectDays(weekdays.value),
            //     duration:
            //         dedicatedTimeList[dedicatedTimeIndex(dedicatedTime.value)]
            //                 .duration! ~/
            //             2,
            //     start: '',
            //     end: '',
            //     name: cardioTrainingList[
            //                 cardioTrainingIndex(cardioTraining.value)]
            //             .title +
            //         ' - ' +
            //         (dedicatedTimeList[dedicatedTimeIndex(dedicatedTime.value)]
            //             .title
            //             .split(' ')
            //             .first),
            //     completed: false,
            //     workouts: false,
            //     alarm: false,
            //     calendar: true,
            //     rworkouts: <RoutineWorkouts>[],
            //   ),
            // );

            updateIndex(5);
          }
        }
        break;
    }
    setState(() {});
  }

  selectRoutineWorkouts(
      int time, int goal, int cardio, int resistance, int days) {
    switch (time) {
      case 0:
        // minimumWorkouts(goal, cardio, resistance, days, time);
        setMinWorkouts(goal, cardio, resistance, days, time);
        break;
      case 1:
        setProgressionWorkouts(goal, cardio, resistance, days, time);
        break;
      case 2:
        setFp1Workouts(goal, cardio, resistance, days, time);
        break;
      case 4:
        setFp2Workouts(goal, cardio, resistance, days, time);
        break;
      case 5:
        setFp3Workouts(goal, cardio, resistance, days, time);
        break;
      case 6:
        setFp4Workouts(goal, cardio, resistance, days, time);
        break;
      default:
        return <RoutineWorkouts>[];
    }
  }

  int selectStrengthType(int resistance) => resistance == 0
      ? 3
      : resistance == 1
          ? 4
          : resistance == 2
              ? 5
              : 3;

  int selectCardioType(int cardio) => cardio == 0
      ? 1
      : cardio == 1
          ? 7
          : cardio == 2
              ? 6
              : 1;

  ///0: health, 1: cardio (HIIT), 2: mobility,
  /// 3: strength anywhere(bodyweight), 4: strength freeweight, 5: strength machine
  /// 6: cardio active, 7: cardio continous
  /// goals => 0: health, 1: strenght, 2: leaner, 3: cardio, 4: mobility

  int selectgoal(int goal, int resistance, int cardio) {
    debugPrint(selectCardioType(cardio).toString());
    return goal == 0
        ? 0
        : goal == 1
            ? selectStrengthType(resistance)
            : goal == 2
                ? 0
                : goal == 3
                    ? selectCardioType(cardio)
                    : goal == 4
                        ? 2
                        : goal;
  }

  List<MRSetupModel> getMVData(int goal, int cardio, int resistance) =>
      minviableMrExercisesList
          .where(
              (element) => element.type == selectgoal(goal, resistance, cardio))
          .toList();

  String getRoutineName(int goal, int cardio, int resistance, int dedicated) =>
      '${movementGoals[movementGoalsIndex(goal)].title}${resistance == -1 ? '' : ' (${resistanceTraining[resistenceTrainingIndex(resistance)].title})'} - ${dedicatedTimeList[dedicatedTimeIndex(dedicated)].title.split(' ').first}';

  minimumWorkouts(
    int goal,
    int cardio,
    int resistance,
    int days,
    int dedicated,
  ) {
    final minviable = getMVData(goal, cardio, resistance);
    RxInt tduration = 0.obs;
    updateTotalDuration(int value) => tduration.value = tduration.value + value;
    // RxInt wIndex = 0.obs;
    RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
    for (int i = 0; i < minviable.length; i++) {
      final _viable = minviable[i];
      final int lastExerciseIndex = _viable.exercises!.length - 1;
      final routine = RoutineWorkouts(
        name: _viable.routine!,
        show: false,
        exercises: <WorkoutExercise>[],
      );
      workouts.add(routine);
      for (int j = 0; j < _viable.exercises!.length; j++) {
        final vexercise = _viable.exercises![j];
        if (vexercise.type == 0) {
          Get.log('Workout Exercise');
          // int current = j;
          final rexercise = WorkoutExercise(
            name: vexercise.name,
            sets: <WorkoutSets>[
              WorkoutSets(
                index: 0,
                duration: Sementics(type: 1, value: vexercise.time),
                reps: Sementics(type: 0, value: 1),
                rest: Sementics(type: 0, value: 0),
              ),
            ],
          );
          routine.exercises!.add(rexercise);
          print('exercises: $rexercise');
          // print(current);
          if (j != lastExerciseIndex) {
            int next = j + 1;
            final nextVExercise = _viable.exercises![next];
            if (next <= lastExerciseIndex && nextVExercise.type == 1) {
              Get.log('Next Period Rest');
              rexercise.sets![0].rest!.value = nextVExercise.time!;
            }
          }
          updateTotalDuration(vexercise.time!);
        }
      }
      // wIndex.value = wIndex.value + 1;
    }
    exercises.add(
      RoutineExercise(
        end: '',
        start: '',
        alarm: false,
        calendar: false,
        workouts: false,
        completed: false,
        duration: tduration.value,
        rworkouts: workouts,
        days: [true, false, false, false, false, false, false],
        name: getRoutineName(goal, cardio, resistance, dedicated),
      ),
    );
  }

  setMinWorkouts(
    int goal,
    int cardio,
    int resistance,
    int days,
    int dedicated,
  ) {
    final minviable = getMVData(goal, cardio, resistance);
    RxInt tduration = 0.obs;
    updateTotalDuration(int value) => tduration.value = tduration.value + value;
    // RxInt wIndex = 0.obs;
    switch (days) {
      case 0:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final int lastExerciseIndex = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('Workout Exercise $j');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                print('exercises: $rexercise');
                if (j != lastExerciseIndex) {
                  int next = j + 1;
                  final nextVExercise = _viable.exercises![next];
                  if (next <= lastExerciseIndex && nextVExercise.type == 1) {
                    Get.log('Next Period Rest: $next');
                    rexercise.sets![0].rest!.value = nextVExercise.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, false, false, false, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 1:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final int vLastExercise = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: $j');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != vLastExercise) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= vLastExercise && vnext.type == 1) {
                    Get.log('next: $next');
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, false, true, false, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 2:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final int last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: $j');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    Get.log('next: $next');
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 3:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getMVData(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final int last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: $j');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    Get.log('next: $next');
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getMVData(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final int last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (_viable.exercises![j].type == 0) {
                  Get.log('exercise: $j');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      Get.log('next: $next');
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, false, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );
          }
        }
        break;
      case 4:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getMVData(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (_viable.exercises![j].type == 0) {
                Get.log('exercise: $j');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    Get.log('rest: $next');
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wInde.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getMVData(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final int last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: $j');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      Get.log('next: $next');
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, true, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );
          }
        }
        break;
      case 5:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getMVData(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final int last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  if (next < last) {
                    final vnext = _viable.exercises![next];
                    if (vnext.type == 1) {
                      Get.log('next: $next');
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getMVData(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, true, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );

            // wIndex.value = 0;
            RxList<RoutineWorkouts> _mworkouts = <RoutineWorkouts>[].obs;
            tduration.value = 0;
            final _mobility = getMVData(4, 2, resistance);
            for (int i = 0; i < _mobility.length; i++) {
              final _viable = _mobility[i];
              final int last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _mworkouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise:  ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    if ((next) < last) {
                      final vnext = _viable.exercises![next];
                      if (vnext.type == 1) {
                        Get.log('next: $next');
                        rexercise.sets![0].rest!.value = vnext.time!;
                      }
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _mworkouts,
                duration: tduration.value,
                days: [false, false, false, false, false, true, false],
                name: 'Mobility',
              ),
            );
          }
        }
        break;
      case 6:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getMVData(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  if ((next) < last) {
                    final vnext = _viable.exercises![next];
                    if (vnext.type == 1) {
                      Get.log('next: $next');
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getMVData(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: $j');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      Get.log('next: $next');
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, false, false, true, false, true, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );

            // wIndex.value = 0;
            tduration.value = 0;
            RxList<RoutineWorkouts> _mworkouts = <RoutineWorkouts>[].obs;
            final _mobility = getMVData(4, 2, resistance);
            for (int i = 0; i < _mobility.length; i++) {
              final _viable = _mobility[i];
              final int last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _mworkouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              //   wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _mworkouts,
                duration: tduration.value,
                days: [false, true, false, false, false, false, true],
                name: 'Mobility',
              ),
            );
          }
        }
        break;
      default:
        return <RoutineWorkouts>[];
    }
  }

  List<MRSetupModel> getprogressionData(int goal, int cardio, int resistance) =>
      progressionExercisesList
          .where(
              (element) => element.type == selectgoal(goal, resistance, cardio))
          .toList();

  setProgressionWorkouts(
    int goal,
    int cardio,
    int resistance,
    int days,
    int dedicated,
  ) {
    final minviable = getprogressionData(goal, cardio, resistance);
    RxInt tduration = 0.obs;
    updateTotalDuration(int value) => tduration.value = tduration.value + value;
    // RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
    // RxInt wIndex = 0.obs;
    switch (days) {
      case 0:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value =
                        _viable.exercises![next].time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, false, false, false, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 1:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, false, true, false, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 2:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 3:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getprogressionData(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            tduration.value = 0;
            final _hiit = getprogressionData(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, false, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );
          }
        }
        break;
      case 4:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getprogressionData(goal, cardio, resistance); //goal
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getprogressionData(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, true, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );
          }
        }
        break;
      case 5:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getprogressionData(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getprogressionData(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, true, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );

            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _mworkouts = <RoutineWorkouts>[].obs;
            final _mobility = getprogressionData(4, 2, resistance);
            for (int i = 0; i < _mobility.length; i++) {
              final _viable = _mobility[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _mworkouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _mworkouts,
                duration: tduration.value,
                days: [false, false, false, false, false, true, false],
                name: 'Mobility',
              ),
            );
          }
        }
        break;
      case 6:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getprogressionData(goal, cardio, resistance); //
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getprogressionData(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, false, false, true, false, true, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );

            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _mworkouts = <RoutineWorkouts>[].obs;
            final _mobility = getprogressionData(4, 2, resistance);
            for (int i = 0; i < _mobility.length; i++) {
              final _viable = _mobility[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _mworkouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _mworkouts,
                duration: tduration.value,
                days: [false, true, false, false, false, false, true],
                name: 'Mobility',
              ),
            );
          }
        }
        break;

      default:
        return <RoutineWorkouts>[];
    }
  }

  List<MRSetupModel> getfp1Data(int goal, int cardio, int resistance) =>
      fp1ExercisesList
          .where(
              (element) => element.type == selectgoal(goal, resistance, cardio))
          .toList();

  setFp1Workouts(
    int goal,
    int cardio,
    int resistance,
    int days,
    int dedicated,
  ) {
    final minviable = getfp1Data(goal, cardio, resistance);
    RxInt tduration = 0.obs;
    updateTotalDuration(int value) => tduration.value = tduration.value + value;
    // RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
    // RxInt wIndex = 0.obs;
    switch (days) {
      case 0:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, false, false, false, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 1:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, false, true, false, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 2:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 3:
        {
          // RxInt wIndex = 0.obs;
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getfp1Data(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getfp1Data(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, false, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );
          }
        }
        break;
      case 4:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getfp1Data(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getfp1Data(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, true, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );
          }
        }
        break;
      case 5:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getfp1Data(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getfp1Data(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, true, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );

            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _mworkouts = <RoutineWorkouts>[].obs;
            final _mobility = getfp1Data(4, 2, resistance);
            for (int i = 0; i < _mobility.length; i++) {
              final _viable = _mobility[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _mworkouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _mworkouts,
                duration: tduration.value,
                days: [false, false, false, false, false, true, false],
                name: 'Mobility',
              ),
            );
          }
        }
        break;
      case 6:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getfp1Data(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getfp1Data(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, false, false, true, false, true, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );

            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _mworkouts = <RoutineWorkouts>[].obs;
            final _mobility = getfp1Data(4, 2, resistance);
            for (int i = 0; i < _mobility.length; i++) {
              final _viable = _mobility[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _mworkouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _mworkouts,
                duration: tduration.value,
                days: [false, true, false, false, false, false, true],
                name: 'Mobility',
              ),
            );
          }
        }
        break;

      default:
        return <RoutineWorkouts>[];
    }
  }

  List<MRSetupModel> getfp2Data(int goal, int cardio, int resistance) =>
      fp2ExercisesList
          .where(
              (element) => element.type == selectgoal(goal, resistance, cardio))
          .toList();
  setFp2Workouts(
      int goal, int cardio, int resistance, int days, int dedicated) {
    final minviable = getfp2Data(goal, cardio, resistance);
    RxInt tduration = 0.obs;
    updateTotalDuration(int value) => tduration.value = tduration.value + value;
    // RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
    // RxInt wIndex = 0.obs;
    switch (days) {
      case 0:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, false, false, false, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 1:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, false, true, false, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 2:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 3:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getfp2Data(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getfp2Data(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, false, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );
          }
        }
        break;
      case 4:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getfp2Data(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getfp2Data(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, true, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );
          }
        }
        break;
      case 5:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getfp2Data(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getfp2Data(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, true, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );

            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            final _mobility = getfp2Data(4, 2, resistance);
            RxList<RoutineWorkouts> _mworkouts = <RoutineWorkouts>[].obs;
            for (int i = 0; i < _mobility.length; i++) {
              final _viable = _mobility[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _mworkouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _mworkouts,
                duration: tduration.value,
                days: [false, false, false, false, false, true, false],
                name: 'Mobility',
              ),
            );
          }
        }
        break;
      case 6:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getfp2Data(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getfp2Data(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, false, false, true, false, true, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );

            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _mworkouts = <RoutineWorkouts>[].obs;
            final _mobility = getfp2Data(4, 2, resistance);
            for (int i = 0; i < _mobility.length; i++) {
              final _viable = _mobility[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _mworkouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _mworkouts,
                duration: tduration.value,
                days: [false, true, false, false, false, false, true],
                name: 'Mobility',
              ),
            );
          }
        }
        break;

      default:
        return <RoutineWorkouts>[];
    }
  }

  List<MRSetupModel> getfp3Data(int goal, int cardio, int resistance) =>
      fp3ExercisesList
          .where(
              (element) => element.type == selectgoal(goal, resistance, cardio))
          .toList();
  setFp3Workouts(
      int goal, int cardio, int resistance, int days, int dedicated) {
    final minviable = getfp3Data(goal, cardio, resistance);
    RxInt tduration = 0.obs;
    updateTotalDuration(int value) => tduration.value = tduration.value + value;
    // RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
    // RxInt wIndex = 0.obs;
    switch (days) {
      case 0:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, false, false, false, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 1:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, false, true, false, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 2:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 3:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getfp3Data(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getfp3Data(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, false, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );
          }
        }
        break;
      case 4:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getfp3Data(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getfp3Data(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, true, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );
          }
        }
        break;
      case 5:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getfp3Data(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getfp3Data(3, 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, true, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );

            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _mworkouts = <RoutineWorkouts>[].obs;
            final _mobility = getfp3Data(4, 2, resistance);
            for (int i = 0; i < _mobility.length; i++) {
              final _viable = _mobility[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _mworkouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _mworkouts,
                duration: tduration.value,
                days: [false, false, false, false, false, true, false],
                name: 'Mobility',
              ),
            );
          }
        }
        break;
      case 6:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getfp3Data(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getfp3Data(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, false, false, true, false, true, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );

            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _mworkouts = <RoutineWorkouts>[].obs;
            final _mobility = getfp3Data(4, 2, resistance);
            for (int i = 0; i < _mobility.length; i++) {
              final _viable = _mobility[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _mworkouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _mworkouts,
                duration: tduration.value,
                days: [false, true, false, false, false, false, true],
                name: 'Mobility',
              ),
            );
          }
        }
        break;

      default:
        return <RoutineWorkouts>[];
    }
  }

  List<MRSetupModel> getfp4Data(int goal, int cardio, int resistance) =>
      fp4ExercisesList
          .where(
              (element) => element.type == selectgoal(goal, resistance, cardio))
          .toList();
  setFp4Workouts(
      int goal, int cardio, int resistance, int days, int dedicated) {
    final minviable = getfp4Data(goal, cardio, resistance);
    RxInt tduration = 0.obs;
    updateTotalDuration(int value) => tduration.value = tduration.value + value;
    // RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
    // RxInt wIndex = 0.obs;
    switch (days) {
      case 0:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, false, false, false, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 1:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, false, true, false, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 2:
        {
          RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
          for (int i = 0; i < minviable.length; i++) {
            final _viable = minviable[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workouts.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workouts,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );
        }
        break;
      case 3:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getfp4Data(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getfp4Data(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, false, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );
          }
        }
        break;
      case 4:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getfp4Data(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getfp4Data(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, true, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );
          }
        }
        break;
      case 5:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getfp4Data(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getfp4Data(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, true, false, true, false, false, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );

            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            final _mobility = getfp4Data(4, 2, resistance);
            RxList<RoutineWorkouts> _mworkouts = <RoutineWorkouts>[].obs;
            for (int i = 0; i < _mobility.length; i++) {
              final _viable = _mobility[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _mworkouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _mworkouts,
                duration: tduration.value,
                days: [false, false, false, false, false, true, false],
                name: 'Mobility',
              ),
            );
          }
        }
        break;
      case 6:
        {
          RxList<RoutineWorkouts> workout = <RoutineWorkouts>[].obs;
          final _new = getfp4Data(goal, cardio, resistance); //0
          for (int i = 0; i < _new.length; i++) {
            final _viable = _new[i];
            final last = _viable.exercises!.length - 1;
            final routine = RoutineWorkouts(
              name: _viable.routine!,
              show: false,
              exercises: <WorkoutExercise>[],
            );
            workout.add(routine);
            for (int j = 0; j < _viable.exercises!.length; j++) {
              final vexercise = _viable.exercises![j];
              if (vexercise.type == 0) {
                Get.log('exercise: ${vexercise.name}');
                final rexercise = WorkoutExercise(
                  name: vexercise.name,
                  sets: <WorkoutSets>[
                    WorkoutSets(
                      index: 0,
                      duration: Sementics(type: 1, value: vexercise.time),
                      reps: Sementics(type: 0, value: 1),
                      rest: Sementics(type: 0, value: 0),
                    ),
                  ],
                );
                routine.exercises!.add(rexercise);
                if (j != last) {
                  int next = j + 1;
                  final vnext = _viable.exercises![next];
                  if ((next) <= last && vnext.type == 1) {
                    rexercise.sets![0].rest!.value = vnext.time!;
                  }
                }
                updateTotalDuration(vexercise.time!);
              }
            }
            // wIndex.value = wIndex.value + 1;
          }
          exercises.add(
            RoutineExercise(
              end: '',
              start: '',
              alarm: false,
              calendar: false,
              workouts: false,
              completed: false,
              duration: tduration.value,
              rworkouts: workout,
              days: [true, false, true, false, true, false, false],
              name: getRoutineName(goal, cardio, resistance, dedicated),
            ),
          );

          if (goal != 4) {
            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _workouts = <RoutineWorkouts>[].obs;
            final _hiit = getfp4Data(3, goal == 3 ? 1 : 0, resistance);
            for (int i = 0; i < _hiit.length; i++) {
              final _viable = _hiit[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _workouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _workouts,
                duration: tduration.value,
                days: [false, false, false, true, false, true, false],
                name: goal == 3 ? 'Cardio (Continuous)' : 'Cardio (HIIT)',
              ),
            );

            // wIndex.value = 0;
            // workouts.clear();
            tduration.value = 0;
            RxList<RoutineWorkouts> _mworkouts = <RoutineWorkouts>[].obs;
            final _mobility = getfp4Data(4, 2, resistance);
            for (int i = 0; i < _mobility.length; i++) {
              final _viable = _mobility[i];
              final last = _viable.exercises!.length - 1;
              final routine = RoutineWorkouts(
                name: _viable.routine!,
                show: false,
                exercises: <WorkoutExercise>[],
              );
              _mworkouts.add(routine);
              for (int j = 0; j < _viable.exercises!.length; j++) {
                final vexercise = _viable.exercises![j];
                if (vexercise.type == 0) {
                  Get.log('exercise: ${vexercise.name}');
                  final rexercise = WorkoutExercise(
                    name: vexercise.name,
                    sets: <WorkoutSets>[
                      WorkoutSets(
                        index: 0,
                        duration: Sementics(type: 1, value: vexercise.time),
                        reps: Sementics(type: 0, value: 1),
                        rest: Sementics(type: 0, value: 0),
                      ),
                    ],
                  );
                  routine.exercises!.add(rexercise);
                  if (j != last) {
                    int next = j + 1;
                    final vnext = _viable.exercises![next];
                    if ((next) <= last && vnext.type == 1) {
                      rexercise.sets![0].rest!.value = vnext.time!;
                    }
                  }
                  updateTotalDuration(vexercise.time!);
                }
              }
              // wIndex.value = wIndex.value + 1;
            }
            exercises.add(
              RoutineExercise(
                end: '',
                start: '',
                alarm: false,
                calendar: false,
                workouts: false,
                completed: false,
                rworkouts: _mworkouts,
                duration: tduration.value,
                days: [false, true, false, false, false, false, true],
                name: 'Mobility',
              ),
            );
          }
        }
        break;

      default:
        return <RoutineWorkouts>[];
    }
  }

  List<bool> selectDays(int day) {
    switch (day) {
      case 0:
        return [true, false, false, false, false, false, false];
      case 1:
        return [true, true, false, false, false, false, false];
      case 2:
        return [true, true, true, false, false, false, false];
      case 3:
        return [true, true, true, true, false, false, false];
      case 4:
        return [true, true, true, true, true, false, false];
      case 5:
        return [true, true, true, true, true, true, false];
      case 6:
        return [true, true, true, true, true, true, true];
      default:
        return [false, false, false, false, false, false, false];
    }
  }

  bool edit = Get.arguments[0];
  RxList<RoutineExercise> exercises = <RoutineExercise>[].obs;
  final Rx<RoutineCreator> _routine = RoutineCreator(
    userid: Get.find<AuthServices>().userid,
    id: generateId(),
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _routine.value.name = name.text;
    _routine.value.date = currentTime.text;
    _routine.value.importantgoal = importantgoal.value;
    _routine.value.resistanceTraining = resistancetraining.value;
    _routine.value.cardio = cardioTraining.value;
    _routine.value.time = dedicatedTime.value;
    _routine.value.days = weekdays.value;
    _routine.value.exercises = exercises;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _routine.value.duration = _routine.value.duration! + diff;
    } else {
      _routine.value.duration = diff;
    }
  }

  fetchData() {
    _routine.value = Get.arguments[1] as RoutineCreator;
    name.text = _routine.value.name!;
    currentTime.text = _routine.value.date!;
    importantgoal.value = _routine.value.importantgoal!;
    resistancetraining.value = _routine.value.resistanceTraining!;
    cardioTraining.value = _routine.value.cardio!;
    weekdays.value = _routine.value.days!;
    dedicatedTime.value = _routine.value.time!;
    exercises.assignAll(_routine.value.exercises!);
    index.value = 5;
    setState(() {});
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == movement);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: name.text,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _routine.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addRoutine([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    if (edit) _routine.value.id = generateId();
    await movementRef.doc(_routine.value.id).set(_routine.value.toMap());
    await addAccomplishment(end);
    Get.back();
    if (!fromsave) {
      if (Get.find<MovementController>().history.value.value == 149) {
        Get.find<MovementController>()
            .updateHistory(end.difference(initial).inSeconds);
      }
      Get.back();
    }
    await addToCalendar();
    customToast(message: 'Added successfully');
  }

  Future updateRoutine([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    await movementRef.doc(_routine.value.id).update(_routine.value.toMap());
    Get.back();
    if (!fromsave) Get.back();
    customToast(message: 'Updated successfully');
  }

  Future addToCalendar() async {
    for (int i = 0; i < exercises.length; i++) {
      final exercise = exercises[i];
      Future.delayed(Duration(seconds: i == 0 ? 0 : 10 + i), () async {
        final Event event = Event(
          title: exercise.name!,
          description: '',
          startDate: exercise.start == null || exercise.start == ''
              ? DateTime.now()
              : getDateFromStringTime(exercise.start ?? '00:00 AM'),
          endDate: exercise.end == null || exercise.end == ''
              ? DateTime.now().add(const Duration(hours: 1))
              : getDateFromStringTime(exercise.end ?? '00:00 AM'),
          recurrence: Recurrence(frequency: setFrequency(exercise.days!)),
        );
        await Add2Calendar.addEvent2Cal(event).then((value) {});
      });
    }
  }

  Frequency setFrequency(List<bool> days) {
    int count = 0;
    for (int i = 0; i < days.length; i++) {
      if (days[i]) count = count + 1;
    }
    if (count == 7) {
      return Frequency.daily;
    } else {
      return Frequency.weekly;
    }
  }

  @override
  void initState() {
    setState(() {
      if (edit) fetchData();
    });
    super.initState();
  }
}

class AssessmentRoutineWidget extends StatefulWidget {
  const AssessmentRoutineWidget({
    Key? key,
    this.deleteRoutine,
    required this.exercise,
    this.calendar,
    this.alarm,
    this.workouts,
    this.start,
    this.end,
    this.edit = false,
    required this.journal,
  }) : super(key: key);
  final VoidCallback? deleteRoutine, start, end;
  final RoutineExercise exercise;
  final Function(dynamic)? calendar, alarm, workouts;
  final bool edit, journal;

  @override
  State<AssessmentRoutineWidget> createState() =>
      _AssessmentRoutineWidgetState();
}

class _AssessmentRoutineWidgetState extends State<AssessmentRoutineWidget> {
  Future<void> delFunction(int rindex, int eindex, int index) async {
    setState(() {
      print(widget.exercise.duration);
      final set =
          widget.exercise.rworkouts![rindex].exercises![eindex].sets![index];
      if (set.duration!.type == 1) {
        widget.exercise.duration =
            widget.exercise.duration! - set.duration!.value!;
      }
      widget.exercise.rworkouts![rindex].exercises![eindex].sets!
          .removeAt(index);
    });
  }

  Future<void> updateSetTotal(int current, int newval) async {
    setState(() {
      widget.exercise.duration = widget.exercise.duration! - current;
      widget.exercise.duration = widget.exercise.duration! + newval;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: widget.deleteRoutine ?? () {},
                icon: const Icon(Icons.delete),
              ),
              Container(
                width: width * 0.79,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      maxLines: null,
                      initialValue: widget.exercise.name!,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: arail,
                      ),
                      onChanged: (val) {
                        setState(() {
                          widget.exercise.name = val;
                        });
                      },
                      decoration: decoration(hint: 'Exercise Name'),
                    ).marginOnly(bottom: 10),
                    RichText(
                      text: TextSpan(
                        text: getDurationString(widget.exercise.duration ?? 0),
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: arail,
                          color: Colors.black,
                        ),
                        children: const [
                          TextSpan(
                            text: ' (Workout Length)',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: arail,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).marginOnly(bottom: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CustomCheckBox(
                  value: widget.exercise.calendar,
                  onChanged: widget.calendar,
                  title: 'Calendar',
                  width: 100,
                ),
                timeWidget(
                  label: widget.exercise.start == ''
                      ? 'Start Time'
                      : widget.exercise.start!,
                  ontap: widget.start,
                ),
                timeWidget(
                  label: widget.exercise.end == ''
                      ? 'End Time'
                      : widget.exercise.end!,
                  ontap: widget.end,
                ),
                CustomCheckBox(
                  value: widget.exercise.alarm,
                  onChanged: widget.alarm,
                  title: 'Alarm On',
                  width: 100,
                ),
              ],
            ),
          ),
          CheckBoxRows(
            titles: dayNames,
            values: widget.exercise.days ??
                [false, false, false, false, false, false, false],
            size: 55,
          ),
          CustomCheckBox(
            value: widget.exercise.workouts,
            onChanged: widget.workouts,
            title: 'Show Workout?',
          ),
          if (widget.exercise.workouts!)
            Column(
              children: List.generate(
                widget.exercise.rworkouts!.length,
                (index) {
                  final _workout = widget.exercise.rworkouts![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomCheckBox(
                        value: _workout.show,
                        onChanged: (val) {
                          setState(() {
                            _workout.show = val!;
                          });
                        },
                        title: _workout.name!.capitalize!,
                        width: width,
                      ),
                      if (_workout.show!)
                        Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(
                                _workout.exercises!.length,
                                (indx) {
                                  final _exercise = _workout.exercises![indx];
                                  return WExerciseWidget(
                                    _exercise,
                                    edit: true,
                                    index: indx,
                                    rindex: index,
                                    delete: widget.edit,
                                    fromJournal: widget.journal,
                                    image: widget.edit ? AppIcons.delete : null,
                                    onimage: widget.edit
                                        ? () async {
                                            setState(() {
                                              int length = 0;
                                              for (int i = 0;
                                                  i < _exercise.sets!.length;
                                                  i++) {
                                                final _set = _exercise.sets![i];
                                                if (_set.duration!.type == 1) {
                                                  length = length +
                                                      _set.duration!.value!;
                                                } else if (_set
                                                        .duration!.type ==
                                                    4) {
                                                  length = length +
                                                      (_set.duration!.value! *
                                                          60);
                                                }
                                              }
                                              widget.exercise.duration =
                                                  widget.exercise.duration! -
                                                      length;
                                              if (widget.exercise.end != '') {
                                                widget.exercise
                                                    .end = TimeOfDay.fromDateTime(
                                                        getDateFromStringTime(
                                                                widget.exercise
                                                                    .start!)
                                                            .add(Duration(
                                                                seconds: widget
                                                                    .exercise
                                                                    .duration!)))
                                                    .format(context);
                                              }
                                              _workout.exercises!
                                                  .removeAt(indx);
                                            });
                                          }
                                        : () {},
                                    addSet: () async {
                                      setState(() {
                                        _exercise.sets!.add(
                                          WorkoutSets(
                                            index: _exercise.sets!.length,
                                            duration:
                                                Sementics(value: 30, type: 1),
                                            reps: Sementics(value: 1, type: 0),
                                            rest: Sementics(value: 0, type: 0),
                                          ),
                                        );
                                        widget.exercise.duration =
                                            widget.exercise.duration! + 30;
                                      });
                                    },
                                    deleteSet: delFunction,
                                    updateDuration: updateSetTotal,
                                  ).marginOnly(bottom: 10);
                                },
                              ),
                            ),
                            if (widget.edit)
                              IconTextButton(
                                text: 'Exercise',
                                icon: Icons.add,
                                onPressed: () {
                                  setState(() {
                                    _workout.exercises!.add(
                                      WorkoutExercise(
                                        name: '',
                                        sets: <WorkoutSets>[],
                                      ),
                                    );
                                  });
                                },
                              ),
                          ],
                        ),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget timeWidget({required String label, VoidCallback? ontap}) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: width * 0.2,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(border: Border.all()),
        child: TextWidget(text: label),
      ),
    );
  }
}

class PreviousAssessments extends StatelessWidget {
  const PreviousAssessments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title:
            'Personalized Exercise/ Mobility Routine Creator 30 Seconds Weekly Routine Creator',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: movementRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 0)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data.docs.isEmpty) {
            return CircularLoadingWidget(
              height: height,
              onCompleteText: 'Nothing to show...',
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              final RoutineCreator model =
                  RoutineCreator.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const MovementAssessment(),
                      arguments: [true, model]),
                  title: TextWidget(
                    text: model.name!,
                    weight: FontWeight.bold,
                    size: 15,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class PlayRoutineWorkout extends StatefulWidget {
  const PlayRoutineWorkout({Key? key}) : super(key: key);

  @override
  State<PlayRoutineWorkout> createState() => _PlayRoutineWorkoutState();
}

class _PlayRoutineWorkoutState extends State<PlayRoutineWorkout> {
  final Rx<RoutineExercise> _movementWorkout =
      (Get.arguments[0] as RoutineExercise).obs;
  final RxInt duration = 0.obs;
  final CountDownController controller = CountDownController();
  final RxInt category = 0.obs;
  final RxInt workout = 0.obs;
  final RxInt exercise = 0.obs;
  final RxInt sets = 0.obs;
  final TimeOfDay start = TimeOfDay.now();
  final RxInt rest = 0.obs;

  setData() {
    if (_movementWorkout.value.rworkouts!.isNotEmpty) {
      final workout = _movementWorkout.value.rworkouts![category.value];
      final rexercise = workout.exercises![exercise.value];
      final _duration = rexercise.sets![sets.value].duration!;
      if (_duration.type == 1) {
        duration.value = _duration.value!;
      } else if (_duration.type == 4) {
        duration.value = _duration.value! * 60;
      } else {
        duration.value = 10;
      }
      final _rest = rexercise.sets![sets.value].rest!;
      if (_rest.type == 0 && _rest.value != 0) rest.value = _rest.value ?? 0;
      Get.log('Rest: ${rest.value}');
    } else {
      duration.value = _movementWorkout.value.duration!;
    }
  }

  RxString status = ''.obs;

  enableWakelock() async {
    bool check = await Wakelock.enabled;
    if (!check) await Wakelock.enable();
    setState(() {});
  }

  disableWakelock() async {
    bool check = await Wakelock.enabled;
    if (check) await Wakelock.disable();
  }

  @override
  void initState() {
    setState(() {
      enableWakelock();
      setData();
    });
    super.initState;
  }

  @override
  void dispose() {
    controller.reset();
    _player.dispose();
    disableWakelock();
    super.dispose();
  }

  final AudioPlayer _player = AudioPlayer();

  final RxBool relaxed = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: customAppbar(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 10,
              left: 15,
              right: 15,
              bottom: 10,
            ),
            child: Column(
              children: [
                title2('Movement Journal - Move Freely (Practice)')
                    .marginOnly(bottom: 20),
                CustomCountdown(
                  controller: controller,
                  duration: duration.value,
                  caption: relaxed.value
                      ? 'Rest'
                      : _movementWorkout.value.rworkouts![category.value]
                          .exercises![exercise.value].name!,
                  bottom: height * 0.13,
                  maxline: 3,
                  onComplete: () async {
                    setState(() {
                      status.value = 'completed';
                      playAlarm(_player);
                      final workout =
                          _movementWorkout.value.rworkouts![category.value];
                      final rexercise = workout.exercises![exercise.value];
                      if (status.value == 'completed' &&
                          rest.value != 0 &&
                          relaxed.value == false) {
                        relaxed.value = true;
                        duration.value = rest.value;
                        status.value = 'play';
                        controller.restart(duration: duration.value);
                      } else {
                        relaxed.value = false;
                        if (sets.value != (rexercise.sets!.length - 1)) {
                          sets.value = sets.value + 1;
                          setData();
                          Get.log(rexercise.name!.toString());
                          status.value = 'play';
                          controller.restart(duration: duration.value);
                        } else if (exercise.value !=
                            (workout.exercises!.length - 1)) {
                          exercise.value = exercise.value + 1;
                          sets.value = 0;
                          setData();
                          Get.log(rexercise.name!.toString()); 
                          status.value = 'play';
                          controller.restart(duration: duration.value);
                        } else if (category.value !=
                            (_movementWorkout.value.rworkouts!.length - 1)) {
                          category.value = category.value + 1;
                          exercise.value = 0;
                          sets.value = 0;
                          setData();
                          Get.log(rexercise.name!.toString());
                          status.value = 'play';
                          controller.restart(duration: duration.value);
                        }
                      }
                    });
                  },
                ).marginOnly(bottom: 10),
                Row(
                  children: [
                    const Icon(Icons.volume_up_rounded),
                    SizedBox(
                      width: width * 0.73,
                      child: StreamBuilder<double>(
                        stream: _player.volumeStream,
                        builder: (context, snapshot) => SizedBox(
                          width: width * 0.7,
                          child: Slider(
                            min: 0.0,
                            max: 1.0,
                            divisions: 10,
                            value: _player.volume,
                            onChanged: (val) {
                              setState(() {
                                _player.setVolume(val);
                              });
                            },
                            inactiveColor: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ).marginOnly(left: 15, right: 15),
                CustomElevatedButton(
                  text: status.value == 'play' ? 'Pause' : 'Exercise Now',
                  onPressed: () {
                    if (status.value == '') {
                      status.value = 'play';
                      controller.start();
                    } else if (status.value == 'play') {
                      status.value = 'pause';
                      controller.pause();
                    } else if (status.value == 'pause') {
                      status.value = 'play';
                      controller.resume();
                    } else if (status.value == 'completed') {
                      status.value = 'play';
                      controller.restart(duration: duration.value);
                    } else {
                      status.value = 'play';
                      controller.restart(duration: duration.value);
                    }
                  },
                ).marginOnly(bottom: 10, left: 15, right: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // if (exercise.value != 0)
                    IconTextButton(
                      text: 'Previous Exercise',
                      icons: const Icon(Icons.reply, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          // controller.pause();
                          status.value = '';
                          controller.reset();
                          rest.value = 0;
                          duration.value = 0;
                          relaxed.value = false;
                          if (exercise.value != 0) {
                            exercise.value = exercise.value - 1;
                            sets.value = 0;
                          } else if (category.value != 0) {
                            category.value = category.value - 1;
                            exercise.value = 0;
                            sets.value = 0;
                          }
                          setData();
                        });
                      },
                    ),
                    IconTextButton(
                      text: 'Next Exercise',
                      onPressed: () {
                        setState(() {
                          status.value = '';
                          controller.reset();
                          rest.value = 0;
                          relaxed.value = false;
                          duration.value = 0;
                          if (exercise.value !=
                              _movementWorkout.value.rworkouts![category.value]
                                      .exercises!.length -
                                  1) {
                            exercise.value = exercise.value + 1;
                            sets.value = 0;
                          } else if (category.value !=
                              _movementWorkout.value.rworkouts!.length - 1) {
                            category.value = category.value + 1;
                            exercise.value = 0;
                            sets.value = 0;
                          }
                          setData();
                        });
                        // setState(() {
                        //   controller.pause();
                        //   status.value = '';
                        //   controller.reset();
                        //   rest.value = 0;
                        //   relaxed.value = false;
                        //   duration.value = 0;
                        // });
                        // if (exercise.value !=
                        //     _movementWorkout.value.rworkouts![category.value]
                        //             .exercises!.length -
                        //         1) {
                        //   exercise.value = exercise.value + 1;
                        //   sets.value = 0;
                        // } else if (category.value !=
                        //     _movementWorkout.value.rworkouts!.length - 1) {
                        //   category.value = category.value + 1;
                        //   exercise.value = 0;
                        //   sets.value = 0;
                        // }
                        setData();
                      },
                      icons: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: const Icon(Icons.reply, color: Colors.black),
                      ),
                    ),
                  ],
                ).marginOnly(left: 15, right: 15, bottom: 10),
                Row(
                  children: [
                    FlutterSwitch(
                      value: relaxed.value,
                      onToggle: (val) => relaxed.value = val,
                      inactiveColor: Colors.grey,
                    ).marginOnly(right: 10),
                    const TextWidget(text: 'Relaxed Mode'),
                  ],
                ).marginOnly(left: 15, right: 15, bottom: 10),
                CustomElevatedButton(
                  text: 'Exit to Journal',
                  onPressed: () async {
                    if (status.value != '') {
                      controller.reset();
                      status.value = '';
                    }
                    final _start = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      start.hour,
                      start.minute,
                    );
                    final _end = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      TimeOfDay.now().hour,
                      TimeOfDay.now().minute,
                    );
                    final _jouranl = MovementJournalEntry(
                      start: start.format(context),
                      end: TimeOfDay(hour: _end.hour, minute: _end.minute)
                          .format(context),
                      duration: _end.difference(_start).inDays,
                      durationSeconds: _end.difference(_start).inSeconds,
                      workouts: _movementWorkout.value.rworkouts,
                      id: '',
                      notes: '',
                      name: _movementWorkout.value.name,
                      type: 2,
                      userid: Get.find<AuthServices>().userid,
                      date: formateDate(DateTime.now()),
                    );
                    Get.off(
                      () => const BlankJournalEntry(),
                      arguments: [true, _jouranl],
                    );
                  },
                ).marginOnly(left: 15, right: 15),
              ],
            ),
          ),
        );
      },
    );
  }
}
