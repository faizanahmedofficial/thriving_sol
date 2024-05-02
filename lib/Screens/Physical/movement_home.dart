// ignore_for_file: avoid_print, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, must_be_immutable, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/time_picker.dart';
import 'package:schedular_project/Model/movement_model.dart';
import 'package:schedular_project/Widgets/checkboxes.dart';
import 'package:schedular_project/Widgets/custom_images.dart';
import 'package:schedular_project/Widgets/custom_snackbar.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:wakelock/wakelock.dart';
import 'dart:math' as math;

import '../../Controller/play_routine_controller.dart';
import '../../Functions/functions.dart';
import '../../Global/firebase_collections.dart';
import '../../Model/app_modal.dart';
import '../../Model/app_user.dart';
import '../../Services/auth_services.dart';
import '../../Theme/input_decoration.dart';
import '../../Widgets/app_bar.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/dialogs.dart';
import '../../Widgets/drop_down_button.dart';
import '../../Widgets/progress_indicator.dart';
import '../../Widgets/text_widget.dart';
import '../../Widgets/textbutton_icon.dart';
import '../../app_icons.dart';
import '../custom_bottom.dart';
import '../../Widgets/widgets.dart';
import '../readings.dart';
import '../seek_bar.dart';
import 'movement_assessment.dart';
import 'movement_widget.dart';

class MovementController extends GetxController {
  Rx<CurrentExercises> history = CurrentExercises(
    id: movement,
    index: 10,
    value: 148,
    time: DateTime.now(),
    completed: false,
    connectedPractice: 148,
    connectedReading: 148,
    previousPractice: 148,
    previousReading: 148,
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
        .doc(movement)
        .get()
        .then((value) async {
      if (value.data() == {} || value.data() == null) {
        await currentExercises(Get.find<AuthServices>().userid)
            .doc(movement)
            .set(history.value.toMap());
      } else {
        history.value = CurrentExercises.fromMap(value.data());
      }
    });
    appModel.value = movementList[movementListIndex(history.value.value!)];
  }

  Rx<AppModel> appModel = AppModel('', '').obs;
  Future updateReadingHistory(int duration) async {
    if (appModel.value.type == 1) {
      userReadings(Get.find<AuthServices>().userid)
          .update({'movement.element': history.value.value});
      addReadingAccomplishment(duration);
    }
  }

  Future addReadingAccomplishment(int duration) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == movement);
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
        .where((value) => value.id == movement);
    if (list.isNotEmpty) {
      list.first.advanced = appModel.value.title;
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future updateHistory(int duration) async {
    if (history.value.value != 153 && !history.value.completed!) {
      await updateReadingHistory(duration);
      history.value.value = history.value.value! + 1;
      _updateData();
    } else if (history.value.value == 153) {
      await updateReadingHistory(duration);
      history.value.value = 151;
      history.value.completed = true;
      _updateData();
    }
  }

  _updateData() async {
    final _intro = movementList[movementListIndex(history.value.value!)];
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
      movementList.where((element) => element.type == 1).toList();

  selectData(int value) {
    appModel.value = movementList[movementListIndex(value)];
    history.value = CurrentExercises(
      id: movement,
      index: 10,
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

class MovementHome extends StatelessWidget {
  MovementHome({Key? key}) : super(key: key);
  final MovementController controller = Get.put(MovementController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              headline('Movement').marginOnly(bottom: 30),
              TopList(
                list: movementList,
                value: controller.history.value.value!,
                onchanged: (val) {},
                // (val) {
                //   controller.selectData(val);
                // },
                play: controller.appModel.value.ontap,
              ),
              Column(
                children: [
                  AppButton(
                    onTap: () => Get.to(() => const MovementJournal(),
                        arguments: [false]),
                    title: 'Movement Journal',
                    description:
                        'Move now! Start a workout you\'ve created, choose from premade workouts, or make a custom journal entry for any type of workout.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => const MovementAssessment(),
                        arguments: [false]),
                    title: 'Movement Assessment',
                    description:
                        'Create custom movement routines based on your goals.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => MovementReadings()),
                    title: 'Movement Library',
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

class MovementReadings extends StatelessWidget {
  MovementReadings({Key? key}) : super(key: key);
  final MovementController controller = Get.find();

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
            headline('Movement Library').marginOnly(bottom: 20),
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
                      child: elementTitle('Movement'),
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

class MovementJournal extends StatefulWidget {
  const MovementJournal({Key? key}) : super(key: key);

  @override
  State<MovementJournal> createState() => _MovementJournalState();
}

class _MovementJournalState extends State<MovementJournal> {
  final RxBool yourJrnl = false.obs;

  DateTime initial = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: customAppbar(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Column(
              children: [
                ExerciseTitle(
                  title: 'Movement Journal - Move Freely (Practice)',
                  onPressed: () => Get.to(
                    () => ReadingScreen(
                      title: 'Movement Journal',
                      link:
                          'https://docs.google.com/document/d/1GuQQW1eHmqkoxk7fRQXIaQn5sKALzJAe/',
                      linked: () => Get.back(),
                      function: () {
                        if (Get.find<MovementController>()
                                .history
                                .value
                                .value ==
                            150) {
                          final end = DateTime.now();
                          Get.find<MovementController>()
                              .updateHistory(end.difference(initial).inSeconds);
                        }
                        Get.log('closed');
                      },
                    ),
                  ),
                  // () => Get.to(() => const MovementJournalReading()),
                ).marginOnly(bottom: 30),
                CustomCheckBox(
                  value: yourJrnl.value,
                  onChanged: (val) => yourJrnl.value = val,
                  title: 'Your Workouts',
                ).marginOnly(bottom: 20),
                if (yourJrnl.value)
                  StreamBuilder(
                    stream: movementRef
                        .where('userid',
                            isEqualTo: Get.find<AuthServices>().userid)
                        // .orderBy('created')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.hasError ||
                          !snapshot.hasData ||
                          snapshot.data.docs.isEmpty) {
                        return Container();
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (snapshot.data.docs[index].get('type') == 0) {
                            RoutineCreator _routine = RoutineCreator.fromMap(
                                snapshot.data.docs[index]);
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: (_routine.exercises ?? []).length,
                              itemBuilder: (context, rindex) {
                                final RoutineExercise _exercise =
                                    _routine.exercises![rindex];
                                return YJ0Widget(
                                  _exercise,
                                  journal: () {
                                    final end = DateTime.now();
                                    final MovementJournalEntry _journal =
                                        MovementJournalEntry(
                                      name: _exercise.name,
                                      start: _exercise.start,
                                      end: _exercise.end,
                                      durationSeconds: _exercise.duration,
                                      userid: Get.find<AuthServices>().userid,
                                      date: formateDate(DateTime.now()),
                                      id: '',
                                      notes: '',
                                      type: 2,
                                      workouts: _exercise.rworkouts,
                                      duration:
                                          end.difference(initial).inSeconds,
                                    );
                                    Get.to(
                                      () => const BlankJournalEntry(),
                                      arguments: [true, _journal],
                                    );
                                  },
                                  play: () {
                                    Get.to(() => const PlayRoutineWorkout(),
                                        arguments: [_exercise]);
                                  },
                                  edit: () {
                                    Get.to(
                                      () => const MovementAssessment(),
                                      arguments: [true, _routine],
                                    );
                                  },
                                );
                              },
                            );
                          } else if (snapshot.data.docs[index].get('type') ==
                              1) {
                            MovementWorkoutJournal _journal =
                                MovementWorkoutJournal.fromMap(
                                    snapshot.data.docs[index]);

                            return YJ1Widget(_journal);
                          }
                          return Container();
                        },
                      );
                    },
                  ),
                SizedBox(height: height * 0.3),
                workoutButtons(
                  title: 'New Workout',
                  ontap: () => Get.to(
                    () => const NewMovementJournal(),
                    arguments: [false],
                  ),
                ),
                workoutButtons(
                  title: 'Blank Journal Entry',
                  ontap: () => Get.to(
                    () => const BlankJournalEntry(),
                    arguments: [false],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget workoutButtons({required String title, VoidCallback? ontap}) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 70,
        margin: const EdgeInsets.only(bottom: 30),
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: title,
                  alignment: Alignment.center,
                  weight: FontWeight.bold,
                  size: 16,
                ),
              ],
            ),
            Positioned(
              right: 0,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: assetImage(AppIcons.add)),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayWorkout extends StatefulWidget {
  const PlayWorkout({Key? key}) : super(key: key);

  @override
  State<PlayWorkout> createState() => _PlayWorkoutState();
}

class _PlayWorkoutState extends State<PlayWorkout> {
  final Rx<MovementWorkoutJournal> _movementWorkout =
      (Get.arguments[0] as MovementWorkoutJournal).obs;
  final RxInt duration = 0.obs;
  final CountDownController controller = CountDownController();
  final RxInt category = 0.obs;
  final RxInt workout = 0.obs;
  final RxInt exercise = 0.obs;
  final RxInt sets = 0.obs;
  final TimeOfDay start = TimeOfDay.now();
  final RxInt rest = 0.obs;

  setData() {
    final _duration = _movementWorkout.value.exercises![category.value]
        .exercises![exercise.value].sets![sets.value].duration!;
    debugPrint(_duration.type.toString());
    if (_duration.type == 1) {
      duration.value = _duration.value!;
    } else if (_duration.type == 4) {
      duration.value = _duration.value! * 60;
      debugPrint(duration.value.toString());
    } else {
      duration.value = 10;
    }
    final _rest = _movementWorkout.value.exercises![category.value]
        .exercises![exercise.value].sets![sets.value].duration!;
    if (_rest.type == 0) rest.value = _rest.value ?? 0;
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
    // setState(() {});
  }

  @override
  void initState() {
    enableWakelock();
    setState(() {
      setData();
    });
    super.initState;
  }

  @override
  void dispose() {
    disableWakelock();
    _player.dispose();
    // controller.reset();
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
            padding:
                const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
            child: Column(
              children: [
                title2('Movement Journal - Move Freely (Practice)')
                    .marginOnly(bottom: 20),
                CustomCountdown(
                  controller: controller,
                  duration: duration.value,
                  caption: relaxed.value
                      ? 'Rest'
                      : _movementWorkout.value.exercises![category.value]
                          .exercises![exercise.value].name!,
                  onComplete: () async {
                    status.value = 'completed';
                    playAlarm(_player);
                    if (status.value == 'completed' &&
                        rest.value != 0 &&
                        relaxed.value == false) {
                      relaxed.value = true;
                      duration.value = rest.value;
                      status.value = 'play';
                      controller.reset();
                      controller.start();
                    } else {
                      relaxed.value = false;
                      if (sets.value !=
                          _movementWorkout.value.exercises![category.value]
                                  .exercises![exercise.value].sets!.length -
                              1) {
                        sets.value = sets.value + 1;

                        setData();
                        print(_movementWorkout.value.exercises![category.value]
                            .exercises![exercise.value].name);
                        status.value = 'play';
                        controller.restart(duration: duration.value);
                      } else if (exercise.value !=
                          _movementWorkout.value.exercises![category.value]
                                  .exercises!.length -
                              1) {
                        exercise.value = exercise.value + 1;
                        sets.value = 0;

                        setData();
                        print(_movementWorkout.value.exercises![category.value]
                            .exercises![exercise.value].name);
                        status.value = 'play';
                        controller.restart(duration: duration.value);
                      } else if (category.value !=
                          _movementWorkout.value.exercises!.length - 1) {
                        category.value = category.value + 1;
                        exercise.value = 0;
                        sets.value = 0;

                        setData();
                        print(_movementWorkout.value.exercises![category.value]
                            .exercises![exercise.value].name);
                        status.value = 'play';
                        controller.restart(duration: duration.value);
                      }
                    }
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
                      controller.restart(duration: duration.value);
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
                    IconTextButton(
                      text: 'Previous Exercise',
                      icons: const Icon(Icons.reply, color: Colors.black),
                      onPressed: () {
                        if (status.value != '') {
                          status.value = '';
                          controller.reset();
                        }
                        if (exercise.value != 0) {
                          exercise.value = exercise.value - 1;
                          sets.value = 0;
                        } else if (category.value != 0) {
                          category.value = category.value - 1;
                          exercise.value = 0;
                          sets.value = 0;
                        }

                        setData();
                      },
                    ),
                    IconTextButton(
                      text: 'Next Exercise',
                      onPressed: () {
                        if (status.value != '') {
                          status.value = '';
                          controller.reset();
                        }
                        if (exercise.value !=
                            _movementWorkout.value.exercises![category.value]
                                    .exercises!.length -
                                1) {
                          exercise.value = exercise.value + 1;
                          sets.value = 0;
                        } else if (category.value !=
                            _movementWorkout.value.exercises!.length - 1) {
                          category.value = category.value + 1;
                          exercise.value = 0;
                          sets.value = 0;
                        }

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
                      status.value = '';
                      controller.reset();
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
                      duration: _end.difference(_start).inSeconds,
                      durationSeconds: _end.difference(_start).inSeconds,
                      workouts: _movementWorkout.value.exercises,
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

class NewMovementJournal extends StatefulWidget {
  const NewMovementJournal({Key? key}) : super(key: key);

  @override
  State<NewMovementJournal> createState() => _NewMovementJournalState();
}

class _NewMovementJournalState extends State<NewMovementJournal> {
  RxInt calisthetics = (-1).obs;
  RxInt weighttrainging = (-1).obs;
  RxInt intervaltraining = (-1).obs;
  RxInt length = (-1).obs;

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
          bottomNavigationBar: edit
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
                              edit ? await updateJournal() : await addJournal(),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.25,
                        child: CustomOutlinedButton(
                          text: 'Back',
                          onPressed: () => edit ? Get.back() : previousIndex(3),
                        ),
                      ),
                    ],
                  ),
                )
              : index.value != 4
                  ? SizedBox(
                      height: 40,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () => moveToNext(),
                          icon: const Icon(Icons.last_page),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 10,
              bottom: 10,
            ),
            child: Column(
              children: [
                edit
                    ? Column(
                        children: [
                          title2('Movement Journal - Edit Routine (Practice)')
                              .marginOnly(bottom: 10),
                          const TextWidget(
                              text:
                                  'Your personalized exercise/ mobility weekly routine'),
                          const Divider(),
                          const TextWidget(
                            text:
                                'This is your personalized weekly workout routine to meet your health and body composition goals while staying safe and balannced.\n\n Tweak the days of the week you workout and the time you start your workouts to customize your routine.',
                          ).marginOnly(bottom: 30),
                        ],
                      )
                    : Column(
                        children: [
                          title2('Movement Journal - Move Freely (Practice)')
                              .marginOnly(bottom: 10),
                          if (index.value != 4)
                            const TextWidget(
                              text:
                                  'Never stay stagnate and keep growing by recording your journey in exercise & mobility here. This is your place to watch your progress and gains unfold whether you are doing calisthenics, weight training, interval training (HIIT), running/ jogging, playings sports, stretching, warming up, or even just walking.',
                              fontStyle: FontStyle.italic,
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                              size: 13,
                            ).marginOnly(bottom: 20),
                          if (index.value != 4)
                            TextWidget(
                              text: index.value <= 2
                                  ? 'Choose workout type'
                                  : index.value == 3
                                      ? 'Choose workout length'
                                      : '',
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                            ).marginOnly(bottom: 20),
                        ],
                      ),
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
                                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget page1() {
    return Column(
      children: List.generate(
        calisthenicsType.length,
        (index) => Stack(
          children: [
            InkWell(
              onTap: () => calisthetics.value = calisthenicsType[index].value!,
              child: CustomContainer(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, right: 12, left: 12),
                child: TextWidget(
                  text: calisthenicsType[index].title,
                  alignment: Alignment.center,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (calisthenicsType[index].value == calisthetics.value)
              const Positioned(
                right: 0,
                top: 0,
                child: Icon(Icons.check_circle, color: Colors.green),
              ),
          ],
        ).marginOnly(bottom: 15),
      ),
    );
  }

  Widget page2() {
    return Column(
      children: List.generate(
        weightTraings.length,
        (index) => Stack(
          children: [
            InkWell(
              onTap: () => weighttrainging.value = weightTraings[index].value!,
              child: CustomContainer(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, right: 12, left: 12),
                child: TextWidget(
                  text: weightTraings[index].title,
                  alignment: Alignment.center,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (weightTraings[index].value == weighttrainging.value)
              const Positioned(
                right: 0,
                top: 0,
                child: Icon(Icons.check_circle, color: Colors.green),
              ),
          ],
        ).marginOnly(bottom: 15),
      ),
    );
  }

  Widget page3() {
    return Column(
      children: List.generate(
        intervalTraings.length,
        (index) => Stack(
          children: [
            InkWell(
              onTap: () =>
                  intervaltraining.value = intervalTraings[index].value!,
              child: CustomContainer(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, right: 12, left: 12),
                child: TextWidget(
                  text: intervalTraings[index].title,
                  alignment: Alignment.center,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (intervalTraings[index].value == intervaltraining.value)
              const Positioned(
                right: 0,
                top: 0,
                child: Icon(Icons.check_circle, color: Colors.green),
              ),
          ],
        ).marginOnly(bottom: 15),
      ),
    );
  }

  Widget page4() {
    return Column(
      children: List.generate(
        dedicatedTimeList.length,
        (index) => Stack(
          children: [
            InkWell(
              onTap: () => length.value = dedicatedTimeList[index].value!,
              child: CustomContainer(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, right: 12, left: 12),
                child: TextWidget(
                  text: dedicatedTimeList[index].title,
                  alignment: Alignment.center,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (dedicatedTimeList[index].value == length.value)
              const Positioned(
                right: 0,
                top: 0,
                child: Icon(Icons.check_circle, color: Colors.green),
              ),
          ],
        ).marginOnly(bottom: 15),
      ),
    );
  }

  RxBool showWorkouts = false.obs;
  Widget page5() {
    return Column(
      children: [
        edit
            ? Row(
                children: [
                  IconButton(
                    onPressed: () {
                      movementRef.doc(_journal.value.id).delete();
                      Get.back();
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  Container(
                    width: width * 0.79,
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    decoration: BoxDecoration(border: Border.all()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          initialValue: _journal.value.name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            fontFamily: arail,
                          ),
                          onChanged: (val) {
                            setState(() {
                              _journal.value.name = val;
                            });
                          },
                          decoration: decoration(hint: 'Exercise Name'),
                        ).marginOnly(bottom: 10),
                        RichText(
                          text: TextSpan(
                            text: getDurationString(duration.value),
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
              ).marginOnly(bottom: 10)
            : Container(
                decoration: BoxDecoration(border: Border.all()),
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: name,
                            weight: FontWeight.bold,
                            size: 17,
                          ).marginOnly(bottom: 5),
                          DateWidget(
                            alignment: Alignment.centerLeft,
                            date:
                                '${duration.value == 0 ? 'HH:MM:SS' : getDurationString(duration.value)} (Workout Length)',
                            ontap: calisthetics.value == 4
                                ? () async {
                                    await customDurationPicker().then((value) {
                                      duration.value = value!.inSeconds;
                                    });
                                  }
                                : () {},
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () async => await addJournal(true),
                      icon: const Icon(Icons.play_arrow),
                      padding: EdgeInsets.zero,
                      iconSize: 60,
                    ),
                  ],
                ),
              ),
        CustomCheckBox(
          value: showWorkouts.value,
          onChanged: (val) => showWorkouts.value = val,
          title: 'Show Workouts',
        ).marginOnly(bottom: 5),
        if (showWorkouts.value)
          Column(
            children: List.generate(
              workouts.length,
              (index) {
                final _workout = workouts[index];
                return Column(
                  children: [
                    CustomCheckBox(
                      value: _workout.show,
                      onChanged: (val) {
                        setState(() {
                          _workout.show = val;
                        });
                      },
                      title: _workout.name!.capitalize!,
                      width: width,
                    ),
                    if (_workout.show!)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          _workout.exercises!.length,
                          (indx) {
                            final _exercise = _workout.exercises![indx];
                            final RxInt _setIndex = 0.obs;
                            return WExerciseWidget(
                              _exercise,
                              edit: true,
                              index: indx,
                              rindex: index,
                              delete: edit,
                              image: edit
                                  ? AppIcons.delete
                                  : calisthetics.value == 4
                                      ? AppIcons.add
                                      : null,
                              onimage: edit
                                  ? () async {
                                      setState(() {
                                        int length = 0;
                                        for (int i = 0;
                                            i < _exercise.sets!.length;
                                            i++) {
                                          final _set = _exercise.sets![i];
                                          if (_set.duration!.type == 1) {
                                            length =
                                                length + _set.duration!.value!;
                                          } else if (_set.duration!.type == 4) {
                                            length = length +
                                                (_set.duration!.value! * 60);
                                          }
                                        }
                                        duration.value =
                                            duration.value - length;

                                        _workout.exercises!.removeAt(indx);
                                      });
                                    }
                                  : calisthetics.value == 4
                                      ? () {
                                          setState(() {
                                            _exercise.sets!.add(
                                              WorkoutSets(
                                                index: _exercise.sets!.isEmpty
                                                    ? _setIndex.value
                                                    : _setIndex.value + 1,
                                                duration: Sementics(
                                                    type: 1, value: 30),
                                                reps: Sementics(
                                                    type: 1, value: 1),
                                                rest: Sementics(
                                                    type: 0, value: 00),
                                              ),
                                            );
                                            updateDuration(30);
                                          });
                                        }
                                      : () {},
                              addSet: () {
                                setState(() {
                                  _setIndex.value = _setIndex.value + 1;
                                  print(_setIndex.value);
                                  _exercise.sets!.add(
                                    WorkoutSets(
                                      index: _exercise.sets!.isEmpty
                                          ? 0
                                          : _exercise.sets!.length,
                                      duration: Sementics(type: 1, value: 30),
                                      reps: Sementics(type: 1, value: 1),
                                      rest: Sementics(type: 0, value: 00),
                                    ),
                                  );
                                  updateDuration(30);
                                });
                              },
                              deleteSet: delSet,
                              updateDuration: updateSetDuration,
                              assessment: false,
                            ).marginOnly(bottom: 10);
                          },
                        ),
                      ),
                    if (calisthetics.value == 4 || edit)
                      IconTextButton(
                        text: 'Exercise',
                        icon: Icons.add,
                        onPressed: () {
                          setState(() {
                            _workout.exercises!.add(WorkoutExercise(
                              name: '',
                              sets: <WorkoutSets>[],
                            ));
                          });
                        },
                      ),
                  ],
                );
              },
            ),
          ),
        SizedBox(height: height * 0.1),
        if (!edit)
          Column(
            children: [
              workoutButtons(
                title: 'Start Workout Now!',
                icon: const Icon(Icons.play_arrow, size: 50),
                ontap: () async => await addJournal(true),
              ),
              workoutButtons(
                title: 'Add Workout to Calendar',
                icon: assetImage(AppIcons.add),
                ontap: () async => await addToCalendar(),
              ),
              workoutButtons(
                title: 'Back',
                icon: assetImage(AppIcons.share),
                ontap: () => Get.back(),
              ),
            ],
          ),
      ],
    );
  }

  delSet(int rindex, int eindex, int index) {
    setState(() {
      print(duration.value);
      final sets = workouts[rindex].exercises![eindex].sets![index];
      if (sets.duration!.type == 1) {
        duration.value = duration.value - sets.duration!.value!;
      } else if (sets.duration!.type == 4) {
        duration.value = duration.value - (sets.duration!.value! * 60);
      }
      workouts[rindex].exercises![eindex].sets!.removeAt(index);
    });
  }

  updateSetDuration(int current, int newval) {
    reduceDuration(current);
    updateDuration(newval);
  }

  String get name =>
      ('${calisthenicsType[calisthetics.value].title}${weighttrainging.value == -1 ? '' : '(${weightTraings[weightTrainingIndex(weighttrainging.value)].title.capitalize!})'} - ${dedicatedTimeList[dedicatedTimeIndex(length.value)].title.split(' ').first}')
          .capitalize!;

  Widget workoutButtons(
      {required String title, required Widget icon, VoidCallback? ontap}) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 70,
        margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(border: Border.all()),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: title,
                  alignment: Alignment.center,
                  weight: FontWeight.bold,
                  size: 16,
                ),
              ],
            ),
            Positioned(left: 0, top: 10, child: icon),
          ],
        ),
      ),
    );
  }

  RxInt index = 0.obs;
  previousIndex(int value) => index.value = value;
  updateIndex(int value) => index.value = value;

  goback() {
    switch (index.value) {
      case 1:
      case 2:
        previousIndex(0);
        break;
      case 3:
        if (calisthetics.value == 1) {
          previousIndex(1);
        } else if (calisthetics.value == 2) {
          previousIndex(2);
        } else {
          previousIndex(0);
        }
        break;
      case 4:
        previousIndex(3);
        break;
    }
  }

  moveToNext() {
    switch (index.value) {
      case 0:
        {
          if (calisthetics.value == -1) {
            customSnackbar(
                title: 'Can\'t Proceed!', message: 'Please select an option');
          } else {
            if (calisthetics.value == 1) {
              updateIndex(1);
            } else if (calisthetics.value == 2) {
              updateIndex(2);
            } else {
              updateIndex(3);
            }
          }
        }
        break;
      case 1:
        {
          if (weighttrainging.value == -1) {
            customSnackbar(
                title: 'Can\'t Proceed!', message: 'Please select an option');
          } else {
            updateIndex(3);
          }
        }
        break;
      case 2:
        {
          if (intervaltraining.value == -1) {
            customSnackbar(
                title: 'Can\'t Proceed!', message: 'Please select an option');
          } else {
            updateIndex(3);
          }
        }
        break;
      case 3:
        {
          if (length.value == -1) {
            customSnackbar(
                title: 'Can\'t Proceed!', message: 'Please select an option');
          } else {
            workouts.clear();
            selectExercises(
              length.value,
              calisthetics.value,
              intervaltraining.value,
              weighttrainging.value,
            );
            updateIndex(4);
          }
        }
        break;
    }
  }

  RxInt duration = 0.obs;

  selectExercises(int time, int goal, int cardio, int strength) {
    switch (time) {
      case 0:
        selectMinVialable(goal, cardio, strength);
        break;
      case 1:
        selectPEVialable(goal, cardio, strength);
        break;
      case 2:
        selectfp1Vialable(goal, cardio, strength);
        break;
      case 4:
        selectfp2Vialable(goal, cardio, strength);
        break;
      case 5:
        selectfp3Vialable(goal, cardio, strength);
        break;
      case 6:
        selectfp4Vialable(goal, cardio, strength);
        break;
    }
  }

// 0: overall health, 1: strength, 2: cardio, 3: mobility, 4: custom
  /// 0: health, 1: cardio (HIIT), 2: mobility,
  /// 3: strength anywhere(bodyweight), 4: strength freeweight, 5: strength machine
  /// 6: cardio active, 7: cardio continous

  int selectgoal(int goal, int cardio, int strength) {
    return goal == 0
        ? 0
        : goal == 3
            ? 2
            : goal == 1
                ? selectStrength(strength)
                : goal == 2
                    ? selectCardio(cardio)
                    : goal;
  }

  int selectCardio(int cardio) {
    return cardio == 0
        ? 1
        : cardio == 1
            ? 7
            : cardio == 2
                ? 6
                : 1;
  }

  int selectStrength(int strength) {
    return strength == 0
        ? 3
        : strength == 1
            ? 4
            : strength == 2
                ? 5
                : 3;
  }

  updateDuration(int value) => duration.value = duration.value + value;
  reduceDuration(int value) => duration.value = duration.value - value;

  addCustomWorkouts() {
    workouts.add(
      RoutineWorkouts(
        name: 'Warm up',
        show: false,
        exercises: <WorkoutExercise>[],
      ),
    );
    workouts.add(
      RoutineWorkouts(
        name: 'Workouts',
        show: false,
        exercises: <WorkoutExercise>[],
      ),
    );
    workouts.add(
      RoutineWorkouts(
        name: 'Static Stretching',
        show: false,
        exercises: <WorkoutExercise>[],
      ),
    );
  }

  selectMinVialable(int goal, int cardio, int strength) {
    List<MRSetupModel> selectViable(int type, int cardio, int strength) =>
        minviableMrExercisesList
            .where(
                (element) => element.type == selectgoal(type, cardio, strength))
            .toList();
    RxInt wIndex = 0.obs;
    switch (goal) {
      case 0: // health
        {
          List<MRSetupModel> _viable = selectViable(goal, cardio, strength);
          for (int i = 0; i < _viable.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _viable[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _viable[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _viable[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _viable[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_viable[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 1: // strength
        {
          List<MRSetupModel> _viable = selectViable(goal, cardio, strength);
          for (int i = 0; i < _viable.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _viable[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _viable[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _viable[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _viable[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_viable[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 2: //cardio
        {
          List<MRSetupModel> _viable = selectViable(goal, cardio, strength);
          for (int i = 0; i < _viable.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _viable[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _viable[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _viable[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _viable[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_viable[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 3: // mobility
        {
          List<MRSetupModel> _workout = selectViable(goal, cardio, strength);
          for (int i = 0; i < _workout.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _workout[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _workout[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _workout[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _workout[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_workout[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 4: //custom
        {
          // List<MRSetupModel> _viable = selectViable(goal, cardio, strength);
          // for (int i = 0; i < _viable.length; i++) {
          //   workouts.add(
          //     RoutineWorkouts(
          //       name: _viable[i].routine,
          //       show: false,
          //       exercises: <WorkoutExercise>[],
          //     ),
          //   );
          //   for (int j = 0; j < _viable[i].exercises!.length; j++) {
          //     workouts[wIndex.value].exercises!.add(
          //           WorkoutExercise(
          //             name: _viable[i].exercises![j].name,
          //             sets: <WorkoutSets>[
          //               WorkoutSets(
          //                 index: 0,
          //                 duration: Sementics(
          //                   type: 1,
          //                   value: _viable[i].exercises![j].time,
          //                 ),
          //                 reps: Sementics(type: 0, value: 1),
          //               ),
          //             ],
          //           ),
          //         );
          //     updateDuration(_viable[i].exercises![j].time!);
          //   }
          //   wIndex.value = wIndex.value + 1;
          // }
          addCustomWorkouts();
          // List<MRSetupModel> _workout = minviableMrExercisesList
          //     .where((element) => element.type == 0)
          //     .toList();
          // for (int i = 0; i < _workout.length; i++) {
          //   workouts.add(
          //     RoutineWorkouts(
          //       name: _workout[i].routine,
          //       show: false,
          //       exercises: <WorkoutExercise>[],
          //     ),
          //   );
          //   for (int j = 0; j < _workout[i].exercises!.length; j++) {
          //     workouts[workouts.indexWhere(
          //             (element) => element.name == _workout[i].routine)]
          //         .exercises!
          //         .add(
          //           WorkoutExercise(
          //             name: _workout[i].exercises![j].name,
          //             sets: <WorkoutSets>[],
          //           ),
          //         );
          //     workouts[workouts.indexWhere(
          //             (element) => element.name == _workout[i].routine)]
          //         .exercises![workouts[workouts.indexWhere(
          //                 (element) => element.name == _workout[i].routine)]
          //             .exercises!
          //             .indexWhere((element) =>
          //                 element.name == _workout[i].exercises![j].name)]
          //         .sets!
          //         .add(
          //           WorkoutSets(
          //             index: 0,
          //             duration: Sementics(
          //               type: 1,
          //               value: _workout[i].exercises![j].time,
          //             ),
          //             reps: Sementics(type: 0, value: 1),
          //           ),
          //         );
          //   }
          // }
        }
        break;
    }
  }

  selectPEVialable(int goal, int cardio, int strength) {
    List<MRSetupModel> selectProgression(int goal, int cardio, int strength) =>
        progressionExercisesList
            .where(
                (element) => element.type == selectgoal(goal, cardio, strength))
            .toList();
    RxInt wIndex = 0.obs;
    switch (goal) {
      case 0: // health
        {
          List<MRSetupModel> _progression =
              selectProgression(goal, cardio, strength);
          for (int i = 0; i < _progression.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _progression[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _progression[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _progression[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _progression[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_progression[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 1: // strength
        {
          List<MRSetupModel> _progression =
              selectProgression(goal, cardio, strength);
          for (int i = 0; i < _progression.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _progression[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _progression[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _progression[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _progression[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_progression[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 2: //cardio
        {
          List<MRSetupModel> _progression =
              selectProgression(goal, cardio, strength);
          for (int i = 0; i < _progression.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _progression[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _progression[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _progression[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _progression[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_progression[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 3: // mobility
        {
          List<MRSetupModel> progression =
              selectProgression(goal, cardio, strength);
          for (int i = 0; i < progression.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: progression[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < progression[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: progression[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: progression[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(progression[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 4: //custom
        {
          // List<MRSetupModel> _progression =
          //     selectProgression(goal, cardio, strength);
          // for (int i = 0; i < _progression.length; i++) {
          //   workouts.add(
          //     RoutineWorkouts(
          //       name: _progression[i].routine,
          //       show: false,
          //       exercises: <WorkoutExercise>[],
          //     ),
          //   );
          //   for (int j = 0; j < _progression[i].exercises!.length; j++) {
          //     workouts[wIndex.value].exercises!.add(
          //           WorkoutExercise(
          //             name: _progression[i].exercises![j].name,
          //             sets: <WorkoutSets>[
          //               WorkoutSets(
          //                 index: 0,
          //                 duration: Sementics(
          //                   type: 1,
          //                   value: _progression[i].exercises![j].time,
          //                 ),
          //                 reps: Sementics(type: 0, value: 1),
          //               ),
          //             ],
          //           ),
          //         );
          //     updateDuration(_progression[i].exercises![j].time!);
          //   }
          //   wIndex.value = wIndex.value + 1;
          // }
          addCustomWorkouts();
          // List<MRSetupModel> _workout = minviableMrExercisesList
          //     .where((element) => element.type == 0)
          //     .toList();
          // for (int i = 0; i < _workout.length; i++) {
          //   workouts.add(
          //     RoutineWorkouts(
          //       name: _workout[i].routine,
          //       show: false,
          //       exercises: <WorkoutExercise>[],
          //     ),
          //   );
          //   for (int j = 0; j < _workout[i].exercises!.length; j++) {
          //     workouts[workouts.indexWhere(
          //             (element) => element.name == _workout[i].routine)]
          //         .exercises!
          //         .add(
          //           WorkoutExercise(
          //             name: _workout[i].exercises![j].name,
          //             sets: <WorkoutSets>[],
          //           ),
          //         );
          //     workouts[workouts.indexWhere(
          //             (element) => element.name == _workout[i].routine)]
          //         .exercises![workouts[workouts.indexWhere(
          //                 (element) => element.name == _workout[i].routine)]
          //             .exercises!
          //             .indexWhere((element) =>
          //                 element.name == _workout[i].exercises![j].name)]
          //         .sets!
          //         .add(
          //           WorkoutSets(
          //             index: 0,
          //             duration: Sementics(
          //               type: 1,
          //               value: _workout[i].exercises![j].time,
          //             ),
          //             reps: Sementics(type: 0, value: 1),
          //           ),
          //         );
          //   }
          // }
        }
        break;
    }
  }

  selectfp1Vialable(int goal, int cardio, int strength) {
    List<MRSetupModel> selectfp1(int goal, int cardio, int strength) =>
        fp1ExercisesList
            .where(
                (element) => element.type == selectgoal(goal, cardio, strength))
            .toList();
    RxInt wIndex = 0.obs;
    switch (goal) {
      case 0: // health
        {
          List<MRSetupModel> _fp1 = selectfp1(goal, cardio, strength);
          for (int i = 0; i < _fp1.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _fp1[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _fp1[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _fp1[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _fp1[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_fp1[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 1: // strength
        {
          List<MRSetupModel> _fp1 = selectfp1(goal, cardio, strength);
          for (int i = 0; i < _fp1.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _fp1[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _fp1[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _fp1[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _fp1[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_fp1[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 2: //cardio
        {
          List<MRSetupModel> _fp1 = selectfp1(goal, cardio, strength);
          for (int i = 0; i < _fp1.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _fp1[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _fp1[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _fp1[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _fp1[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_fp1[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 3: // mobility
        {
          List<MRSetupModel> _fp1 = selectfp1(goal, cardio, strength);
          for (int i = 0; i < _fp1.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _fp1[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _fp1[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _fp1[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _fp1[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_fp1[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 4: //custom
        {
          // List<MRSetupModel> _fp1 = selectfp1(goal, cardio, strength);
          // for (int i = 0; i < _fp1.length; i++) {
          //   workouts.add(
          //     RoutineWorkouts(
          //       name: _fp1[i].routine,
          //       show: false,
          //       exercises: <WorkoutExercise>[],
          //     ),
          //   );
          //   for (int j = 0; j < _fp1[i].exercises!.length; j++) {
          //     workouts[wIndex.value].exercises!.add(
          //           WorkoutExercise(
          //             name: _fp1[i].exercises![j].name,
          //             sets: <WorkoutSets>[
          //               WorkoutSets(
          //                 index: 0,
          //                 duration: Sementics(
          //                   type: 1,
          //                   value: _fp1[i].exercises![j].time,
          //                 ),
          //                 reps: Sementics(type: 0, value: 1),
          //               ),
          //             ],
          //           ),
          //         );
          //     updateDuration(_fp1[i].exercises![j].time!);
          //   }
          //   wIndex.value = wIndex.value + 1;
          // }
          addCustomWorkouts();
          // List<MRSetupModel> _workout = minviableMrExercisesList
          //     .where((element) => element.type == 0)
          //     .toList();
          // for (int i = 0; i < _workout.length; i++) {
          //   workouts.add(
          //     RoutineWorkouts(
          //       name: _workout[i].routine,
          //       show: false,
          //       exercises: <WorkoutExercise>[],
          //     ),
          //   );
          //   for (int j = 0; j < _workout[i].exercises!.length; j++) {
          //     workouts[workouts.indexWhere(
          //             (element) => element.name == _workout[i].routine)]
          //         .exercises!
          //         .add(
          //           WorkoutExercise(
          //             name: _workout[i].exercises![j].name,
          //             sets: <WorkoutSets>[],
          //           ),
          //         );
          //     workouts[workouts.indexWhere(
          //             (element) => element.name == _workout[i].routine)]
          //         .exercises![workouts[workouts.indexWhere(
          //                 (element) => element.name == _workout[i].routine)]
          //             .exercises!
          //             .indexWhere((element) =>
          //                 element.name == _workout[i].exercises![j].name)]
          //         .sets!
          //         .add(
          //           WorkoutSets(
          //             index: 0,
          //             duration: Sementics(
          //               type: 1,
          //               value: _workout[i].exercises![j].time,
          //             ),
          //             reps: Sementics(type: 0, value: 1),
          //           ),
          //         );
          //   }
          // }
        }
        break;
    }
  }

  selectfp2Vialable(int goal, int cardio, int strength) {
    List<MRSetupModel> selectfp2(int goal, int cardio, int strength) =>
        fp2ExercisesList
            .where(
                (element) => element.type == selectgoal(goal, cardio, strength))
            .toList();
    RxInt wIndex = 0.obs;
    switch (goal) {
      case 0: // health
        {
          List<MRSetupModel> _workout = selectfp2(goal, cardio, strength);
          for (int i = 0; i < _workout.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _workout[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _workout[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _workout[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _workout[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_workout[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 1: // strength
        {
          List<MRSetupModel> _fp2 = selectfp2(goal, cardio, strength);
          for (int i = 0; i < _fp2.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _fp2[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _fp2[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _fp2[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _fp2[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_fp2[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 2: //cardio
        {
          List<MRSetupModel> _fp2 = selectfp2(goal, cardio, strength);
          for (int i = 0; i < _fp2.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _fp2[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _fp2[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _fp2[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _fp2[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_fp2[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 3: // mobility
        {
          List<MRSetupModel> _fp2 = selectfp2(goal, cardio, strength);
          for (int i = 0; i < _fp2.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _fp2[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _fp2[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _fp2[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _fp2[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_fp2[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 4: //custom
        {
          // List<MRSetupModel> _workout = selectfp2(goal, cardio, strength);
          // for (int i = 0; i < _workout.length; i++) {
          //   workouts.add(
          //     RoutineWorkouts(
          //       name: _workout[i].routine,
          //       show: false,
          //       exercises: <WorkoutExercise>[],
          //     ),
          //   );
          //   for (int j = 0; j < _workout[i].exercises!.length; j++) {
          //     workouts[wIndex.value].exercises!.add(
          //           WorkoutExercise(
          //             name: _workout[i].exercises![j].name,
          //             sets: <WorkoutSets>[
          //               WorkoutSets(
          //                 index: 0,
          //                 duration: Sementics(
          //                   type: 1,
          //                   value: _workout[i].exercises![j].time,
          //                 ),
          //                 reps: Sementics(type: 0, value: 1),
          //               ),
          //             ],
          //           ),
          //         );
          //     updateDuration(_workout[i].exercises![j].time!);
          //   }
          //   wIndex.value = wIndex.value + 1;
          // }
          addCustomWorkouts();
          // List<MRSetupModel> _workout = minviableMrExercisesList
          //     .where((element) => element.type == 0)
          //     .toList();
          // for (int i = 0; i < _workout.length; i++) {
          //   workouts.add(
          //     RoutineWorkouts(
          //       name: _workout[i].routine,
          //       show: false,
          //       exercises: <WorkoutExercise>[],
          //     ),
          //   );
          //   for (int j = 0; j < _workout[i].exercises!.length; j++) {
          //     workouts[workouts.indexWhere(
          //             (element) => element.name == _workout[i].routine)]
          //         .exercises!
          //         .add(
          //           WorkoutExercise(
          //             name: _workout[i].exercises![j].name,
          //             sets: <WorkoutSets>[],
          //           ),
          //         );
          //     workouts[workouts.indexWhere(
          //             (element) => element.name == _workout[i].routine)]
          //         .exercises![workouts[workouts.indexWhere(
          //                 (element) => element.name == _workout[i].routine)]
          //             .exercises!
          //             .indexWhere((element) =>
          //                 element.name == _workout[i].exercises![j].name)]
          //         .sets!
          //         .add(
          //           WorkoutSets(
          //             index: 0,
          //             duration: Sementics(
          //               type: 1,
          //               value: _workout[i].exercises![j].time,
          //             ),
          //             reps: Sementics(type: 0, value: 1),
          //           ),
          //         );
          //   }
          // }
        }
        break;
    }
  }

  selectfp3Vialable(int goal, int cardio, int strength) {
    List<MRSetupModel> selectfp3(int goal, int cardio, int strength) =>
        fp3ExercisesList
            .where(
                (element) => element.type == selectgoal(goal, cardio, strength))
            .toList();
    RxInt wIndex = 0.obs;
    switch (goal) {
      case 0: // health
        {
          List<MRSetupModel> _fp3 = selectfp3(goal, cardio, strength);
          for (int i = 0; i < _fp3.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _fp3[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _fp3[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _fp3[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _fp3[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_fp3[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 1: // strength
        {
          List<MRSetupModel> _fp3 = selectfp3(goal, cardio, strength);
          for (int i = 0; i < _fp3.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _fp3[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _fp3[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _fp3[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _fp3[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_fp3[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 2: //cardio
        {
          List<MRSetupModel> _fp3 = selectfp3(goal, cardio, strength);
          for (int i = 0; i < _fp3.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _fp3[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _fp3[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _fp3[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _fp3[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_fp3[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 3: // mobility
        {
          List<MRSetupModel> _fp3 = selectfp3(goal, cardio, strength);
          for (int i = 0; i < _fp3.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _fp3[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _fp3[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _fp3[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _fp3[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_fp3[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 4: //custom
        {
          // List<MRSetupModel> _fp3 = selectfp3(goal, cardio, strength);
          // for (int i = 0; i < _fp3.length; i++) {
          //   workouts.add(
          //     RoutineWorkouts(
          //       name: _fp3[i].routine,
          //       show: false,
          //       exercises: <WorkoutExercise>[],
          //     ),
          //   );
          //   for (int j = 0; j < _fp3[i].exercises!.length; j++) {
          //     workouts[wIndex.value].exercises!.add(
          //           WorkoutExercise(
          //             name: _fp3[i].exercises![j].name,
          //             sets: <WorkoutSets>[
          //               WorkoutSets(
          //                 index: 0,
          //                 duration: Sementics(
          //                   type: 1,
          //                   value: _fp3[i].exercises![j].time,
          //                 ),
          //                 reps: Sementics(type: 0, value: 1),
          //               ),
          //             ],
          //           ),
          //         );
          //     updateDuration(_fp3[i].exercises![j].time!);
          //   }
          //   wIndex.value = wIndex.value + 1;
          // }
          addCustomWorkouts();
          // List<MRSetupModel> _workout = minviableMrExercisesList
          //     .where((element) => element.type == 0)
          //     .toList();
          // for (int i = 0; i < _workout.length; i++) {
          //   workouts.add(
          //     RoutineWorkouts(
          //       name: _workout[i].routine,
          //       show: false,
          //       exercises: <WorkoutExercise>[],
          //     ),
          //   );
          //   for (int j = 0; j < _workout[i].exercises!.length; j++) {
          //     workouts[workouts.indexWhere(
          //             (element) => element.name == _workout[i].routine)]
          //         .exercises!
          //         .add(
          //           WorkoutExercise(
          //             name: _workout[i].exercises![j].name,
          //             sets: <WorkoutSets>[],
          //           ),
          //         );
          //     workouts[workouts.indexWhere(
          //             (element) => element.name == _workout[i].routine)]
          //         .exercises![workouts[workouts.indexWhere(
          //                 (element) => element.name == _workout[i].routine)]
          //             .exercises!
          //             .indexWhere((element) =>
          //                 element.name == _workout[i].exercises![j].name)]
          //         .sets!
          //         .add(
          //           WorkoutSets(
          //             index: 0,
          //             duration: Sementics(
          //               type: 1,
          //               value: _workout[i].exercises![j].time,
          //             ),
          //             reps: Sementics(type: 0, value: 1),
          //           ),
          //         );
          //   }
          // }
        }
        break;
    }
  }

  selectfp4Vialable(int goal, int cardio, int strength) {
    List<MRSetupModel> selectfp4(int goal, int cardio, int strength) =>
        fp4ExercisesList
            .where(
                (element) => element.type == selectgoal(goal, cardio, strength))
            .toList();
    RxInt wIndex = 0.obs;
    switch (goal) {
      case 0: // health
        {
          List<MRSetupModel> _fp4 = selectfp4(goal, cardio, strength);
          for (int i = 0; i < _fp4.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _fp4[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _fp4[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _fp4[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _fp4[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_fp4[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 1: // strength
        {
          List<MRSetupModel> _fp4 = selectfp4(goal, cardio, strength);
          for (int i = 0; i < _fp4.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _fp4[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _fp4[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _fp4[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _fp4[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_fp4[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 2: //cardio
        {
          List<MRSetupModel> _fp4 = selectfp4(goal, cardio, strength);
          for (int i = 0; i < _fp4.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _fp4[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _fp4[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _fp4[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _fp4[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_fp4[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 3: // mobility
        {
          List<MRSetupModel> _fp4 = selectfp4(goal, cardio, strength);
          for (int i = 0; i < _fp4.length; i++) {
            workouts.add(
              RoutineWorkouts(
                name: _fp4[i].routine,
                show: false,
                exercises: <WorkoutExercise>[],
              ),
            );
            for (int j = 0; j < _fp4[i].exercises!.length; j++) {
              workouts[wIndex.value].exercises!.add(
                    WorkoutExercise(
                      name: _fp4[i].exercises![j].name,
                      sets: <WorkoutSets>[
                        WorkoutSets(
                          index: 0,
                          duration: Sementics(
                            type: 1,
                            value: _fp4[i].exercises![j].time,
                          ),
                          reps: Sementics(type: 0, value: 1),
                        ),
                      ],
                    ),
                  );
              updateDuration(_fp4[i].exercises![j].time!);
            }
            wIndex.value = wIndex.value + 1;
          }
        }
        break;
      case 4: //custom
        {
          // List<MRSetupModel> _fp4 = selectfp4(goal, cardio, strength);
          // for (int i = 0; i < _fp4.length; i++) {
          //   workouts.add(
          //     RoutineWorkouts(
          //       name: _fp4[i].routine,
          //       show: false,
          //       exercises: <WorkoutExercise>[],
          //     ),
          //   );
          //   for (int j = 0; j < _fp4[i].exercises!.length; j++) {
          //     workouts[wIndex.value].exercises!.add(
          //           WorkoutExercise(
          //             name: _fp4[i].exercises![j].name,
          //             sets: <WorkoutSets>[
          //               WorkoutSets(
          //                 index: 0,
          //                 duration: Sementics(
          //                   type: 1,
          //                   value: _fp4[i].exercises![j].time,
          //                 ),
          //                 reps: Sementics(type: 0, value: 1),
          //               ),
          //             ],
          //           ),
          //         );
          //     updateDuration(_fp4[i].exercises![j].time!);
          //   }
          //   wIndex.value = wIndex.value + 1;
          // }
          addCustomWorkouts();
          // List<MRSetupModel> _workout = minviableMrExercisesList
          //     .where((element) => element.type == 0)
          //     .toList();
          // for (int i = 0; i < _workout.length; i++) {
          //   workouts.add(
          //     RoutineWorkouts(
          //       name: _workout[i].routine,
          //       show: false,
          //       exercises: <WorkoutExercise>[],
          //     ),
          //   );
          //   for (int j = 0; j < _workout[i].exercises!.length; j++) {
          //     workouts[workouts.indexWhere(
          //             (element) => element.name == _workout[i].routine)]
          //         .exercises!
          //         .add(
          //           WorkoutExercise(
          //             name: _workout[i].exercises![j].name,
          //             sets: <WorkoutSets>[],
          //           ),
          //         );
          //     workouts[workouts.indexWhere(
          //             (element) => element.name == _workout[i].routine)]
          //         .exercises![workouts[workouts.indexWhere(
          //                 (element) => element.name == _workout[i].routine)]
          //             .exercises!
          //             .indexWhere((element) =>
          //                 element.name == _workout[i].exercises![j].name)]
          //         .sets!
          //         .add(
          //           WorkoutSets(
          //             index: 0,
          //             duration: Sementics(
          //               type: 1,
          //               value: _workout[i].exercises![j].time,
          //             ),
          //             reps: Sementics(type: 0, value: 1),
          //           ),
          //         );
          //   }
          // }
        }
        break;
    }
  }

  addToCalendar() async {
    await Add2Calendar.addEvent2Cal(
      Event(
        title: name,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 1)),
      ),
    );
  }

  final bool edit = Get.arguments[0];
  final Rx<MovementWorkoutJournal> _journal = MovementWorkoutJournal(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;
  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _journal.value.name = edit ? _journal.value.name : name;
    _journal.value.calisthetics = calisthetics.value;
    _journal.value.weightTraining = weighttrainging.value;
    _journal.value.intervalTraining = intervaltraining.value;
    _journal.value.length = length.value;
    _journal.value.exercises = workouts;
    _journal.value.seconds = duration.value;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _journal.value.duration = _journal.value.duration! + diff;
    } else {
      _journal.value.duration = diff;
    }
  }

  fetchData() {
    _journal.value = Get.arguments[1] as MovementWorkoutJournal;
    calisthetics.value = _journal.value.calisthetics!;
    weighttrainging.value = _journal.value.weightTraining!;
    intervaltraining.value = _journal.value.intervalTraining!;
    length.value = _journal.value.length!;
    workouts.assignAll(_journal.value.exercises!);
    duration.value = _journal.value.seconds!;
    index.value = 4;
  }

  Future addJournal([bool fromplay = false, bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    if (!fromplay) loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    if (edit) _journal.value.id = generateId();
    await movementRef.doc(_journal.value.id).set(_journal.value.toMap());
    await addAccomplishment(end);
    if (!fromplay) Get.back();
    if (!fromsave) {
      if (Get.find<MovementController>().history.value.value == 151) {
        Get.find<MovementController>()
            .updateHistory(end.difference(initial).inSeconds);
      }
      if (fromplay) {
        Get.off(() => const PlayWorkout(), arguments: [_journal.value]);
      }
      if (!fromplay) addToCalendar();
    }
    if (!fromplay) customToast(message: 'Workout generated successfully.');
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == movement);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: name,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _journal.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future updateJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    await movementRef.doc(_journal.value.id).update(_journal.value.toMap());
    Get.back();
    if (!fromsave) Get.back();
    customToast(message: 'Updated successfully');
  }

  @override
  void initState() {
    setState(() {
      if (edit) fetchData();
    });
    super.initState();
  }
}

class BlankJournalEntry extends StatefulWidget {
  const BlankJournalEntry({Key? key}) : super(key: key);

  @override
  State<BlankJournalEntry> createState() => _BlankJournalEntryState();
}

class _BlankJournalEntryState extends State<BlankJournalEntry> {
  TextEditingController name = TextEditingController(
    text: 'MovementJournalMoveFreely ${formatTitelDate(DateTime.now())}',
  );
  RxString date = formateDate(DateTime.now()).obs;
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();
  RxInt duration = 0.obs;
  TextEditingController notes = TextEditingController();

  updateDuration(int value) {
    duration.value = duration.value + value;
    updateEndTime();
  }

  removeDuration(int value) {
    duration.value = duration.value - value;
    updateEndTime();
  }

  updateEndTime() {
    end.text = TimeOfDay.fromDateTime(getDateFromStringTime(start.text)
            .add(Duration(seconds: duration.value)))
        .format(context);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: customAppbar(),
          bottomNavigationBar: SizedBox(
            height: 125,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormField(
                  controller: notes,
                  decoration: inputDecoration(hint: 'Notes'),
                  maxLines: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.3,
                      height: 40,
                      child: CustomOutlinedButton(
                        text: 'Save',
                        onPressed: () async => edit
                            ? _journal.value.id != ''
                                ? await updateJournal()
                                : await addJournal()
                            : await addJournal(),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.3,
                      height: 40,
                      child: CustomOutlinedButton(
                        text: 'Cancel',
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ).marginOnly(left: 10, right: 10, bottom: 10),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 7,
              right: 5,
              top: 10,
              bottom: 10,
            ),
            child: Column(
              children: [
                title2('Movement Journal- Move Freely (Practice)')
                    .marginOnly(bottom: 10),
                JournalTop(
                  controller: name,
                  add: () => clearData(),
                  save: () async =>
                      edit ? await updateJournal(true) : await addJournal(true),
                  drive: () => Get.off(() => const PreviousJournalEntry()),
                ).marginOnly(bottom: 20),
                const TextWidget(
                  text:
                      'Record any and all workouts in your movement journal whether they be strength, cardio, mobility, or any mix thereof.',
                  fontStyle: FontStyle.italic,
                ).marginOnly(bottom: 20, left: 10, right: 10),
                DateWidget(
                  date: date.value,
                  alignment: Alignment.centerLeft,
                  ontap: () async {
                    await customDatePicker(
                      context,
                      initialDate: dateFromString(date.value),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    ).then((value) {
                      date.value = formateDate(value);
                    });
                  },
                ).marginOnly(bottom: 20, left: 10, right: 10),
                Row(
                  children: [
                    SizedBox(
                      width: width * 0.25,
                      child: TextFormField(
                        readOnly: true,
                        controller: start,
                        decoration: inputDecoration(hint: 'Start Time'),
                        onTap: () async {
                          await customTimePicker(
                            context,
                            initialTime: start.text.isEmpty
                                ? TimeOfDay.now()
                                : getTimeFromString(start.text),
                          ).then((value) {
                            setState(() {
                              start.text = value.format(context);
                            });
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: width * 0.25,
                      child: TextFormField(
                        readOnly: true,
                        controller: end,
                        decoration: inputDecoration(hint: 'End Time'),
                        onTap: () async {
                          await customTimePicker(
                            context,
                            initialTime: end.text.isEmpty
                                ? TimeOfDay.now()
                                : getTimeFromString(end.text),
                          ).then((value) {
                            final _end = DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                              value.hour,
                              value.minute,
                            ).subtract(Duration(seconds: duration.value));
                            final _start = getDateFromStringTime(start.text);
                            if (_end.isBefore(_start)) {
                              customToast(
                                  message:
                                      'End time should greater than start time');
                            } else {
                              end.text = value.format(context);
                              duration.value = _end
                                  .difference(getDateFromStringTime(start.text))
                                  .inSeconds;
                            }
                            // start.text =
                            //     TimeOfDay(hour: _end.hour, minute: _end.minute)
                            //         .format(context);

                            setState(() {});
                          });
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // await customDurationPicker(
                        //   initialMinutes: duration.value,
                        // ).then((value) {
                        //   duration.value =
                        //       value!.inSeconds;
                        // });
                      },
                      child: Container(
                        width: width * 0.25,
                        height: 40,
                        decoration: BoxDecoration(border: Border.all()),
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, bottom: 5, top: 15),
                        child: TextWidget(
                          text: getDurationString(duration.value),
                          size: 13,
                        ),
                      ),
                    ),
                  ],
                ).marginOnly(bottom: 25, left: 10, right: 10),
                Column(
                  children: List.generate(
                    workouts.length,
                    (index) {
                      final RoutineWorkouts _workout = workouts[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomCheckBox(
                            value: _workout.show,
                            onChanged: (val) => setState(() {
                              _workout.show = val;
                            }),
                            title: (_workout.name!.split(' ')[0] +
                                    (_workout.name!.split(' ').length > 1
                                        ? _workout.name!.split(' ')[1]
                                        : ''))
                                .capitalize!,
                            width: width,
                            titleWeight: FontWeight.bold,
                          ),
                          if (_workout.show!)
                            Column(
                              children: [
                                Column(
                                  children: List.generate(
                                    (_workout.exercises ?? []).length,
                                    (indx) {
                                      final _exercise =
                                          _workout.exercises![indx];
                                      RxInt _setIndex = 0.obs;
                                      return Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: width * 0.7,
                                                child: TextFormField(
                                                  initialValue:
                                                      _exercise.name == ''
                                                          ? null
                                                          : _exercise.name,
                                                  decoration: inputDecoration(
                                                    radius: 0,
                                                    hint: 'Exercise Name',
                                                  ),
                                                  onChanged: (val) {
                                                    setState(() {
                                                      _exercise.name = val;
                                                    });
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: width * 0.2,
                                                child: IconTextButton(
                                                  text: 'Set',
                                                  icon: Icons.add,
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        _exercise.sets!.add(
                                                          WorkoutSets(
                                                            index: _exercise
                                                                    .sets!
                                                                    .isEmpty
                                                                ? _setIndex
                                                                    .value
                                                                : _setIndex
                                                                        .value +
                                                                    1,
                                                            duration: Sementics(
                                                              type: 1,
                                                              value: 30,
                                                            ),
                                                            reps: Sementics(
                                                              type: 1,
                                                              value: 1,
                                                            ),
                                                            rest: Sementics(
                                                              type: 0,
                                                              value: 00,
                                                            ),
                                                          ),
                                                        );
                                                        updateDuration(30);
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: List.generate(
                                              _exercise.sets!.length,
                                              (sets) {
                                                final _set =
                                                    _exercise.sets![sets];
                                                _setIndex.value = _set.index!;
                                                return Row(
                                                  children: [
                                                    TextWidget(
                                                      text:
                                                          '${_set.index! + 1}',
                                                    ).marginOnly(
                                                        left: width * 0.01,
                                                        right: 2),
                                                    SizedBox(
                                                      width: width * 0.1,
                                                      child: TextFormField(
                                                        initialValue: _set
                                                            .reps!.value!
                                                            .toString(),
                                                        decoration:
                                                            inputDecoration(
                                                          hint: '1',
                                                          radius: 2,
                                                        ),
                                                        onChanged: (val) {
                                                          setState(() {
                                                            _set.reps!.value =
                                                                int.parse(val);
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    CustomDropDownStruct(
                                                      child: DropdownButton(
                                                        items: workoutRepsList
                                                            .map(
                                                              (e) =>
                                                                  DropdownMenuItem(
                                                                value: e.value,
                                                                child: SizedBox(
                                                                  width: width *
                                                                      0.07,
                                                                  child:
                                                                      TextWidget(
                                                                    text: e
                                                                        .title
                                                                        .split(
                                                                            ' ')
                                                                        .first,
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                        onChanged: (val) {
                                                          setState(() {
                                                            _set.reps!.type =
                                                                val;
                                                          });
                                                        },
                                                        value: _set.reps!.type,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: width * 0.001),
                                                    SizedBox(
                                                      width: width * 0.1,
                                                      child: TextFormField(
                                                          initialValue: _set
                                                              .duration!.value!
                                                              .toString(),
                                                          decoration:
                                                              inputDecoration(
                                                            hint: '1',
                                                          ),
                                                          onChanged: (val) {
                                                            setState(() {
                                                              if (_set.duration!
                                                                      .type ==
                                                                  1) {
                                                                removeDuration(_set
                                                                    .duration!
                                                                    .value!);
                                                                updateDuration(
                                                                    int.parse(
                                                                        val));
                                                              }
                                                              _set.duration!
                                                                      .value =
                                                                  int.parse(
                                                                      val);
                                                            });
                                                          }),
                                                    ),
                                                    CustomDropDownStruct(
                                                      child: DropdownButton(
                                                        items:
                                                            workoutDurationList
                                                                .map(
                                                                  (e) =>
                                                                      DropdownMenuItem(
                                                                    value:
                                                                        e.value,
                                                                    child:
                                                                        SizedBox(
                                                                      width: width *
                                                                          0.07,
                                                                      child:
                                                                          TextWidget(
                                                                        text: e
                                                                            .title
                                                                            .split(' ')
                                                                            .first,
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                                .toList(),
                                                        onChanged: (val) {
                                                          setState(() {
                                                            _set.duration!
                                                                .type = val;
                                                          });
                                                        },
                                                        value:
                                                            _set.duration!.type,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.1,
                                                      child: TextFormField(
                                                          initialValue: _set
                                                              .rest!.value!
                                                              .toString(),
                                                          decoration:
                                                              inputDecoration(
                                                            hint: '0',
                                                          ),
                                                          onChanged: (val) {
                                                            setState(() {
                                                              _set.rest!.value =
                                                                  int.parse(
                                                                      val);
                                                            });
                                                          }),
                                                    ),
                                                    CustomDropDownStruct(
                                                      child: DropdownButton(
                                                        items: restList
                                                            .map(
                                                              (e) =>
                                                                  DropdownMenuItem(
                                                                value: e.value,
                                                                child: SizedBox(
                                                                  width: width *
                                                                      0.07,
                                                                  child:
                                                                      TextWidget(
                                                                    text: e
                                                                        .title
                                                                        .split(
                                                                            ' ')
                                                                        .first,
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                        onChanged: (val) {
                                                          setState(() {
                                                            _set.rest!.type =
                                                                val;
                                                          });
                                                        },
                                                        value: _set.rest!.type,
                                                      ),
                                                    ),
                                                    IconButton(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        icon: const Icon(
                                                            Icons.delete),
                                                        onPressed: () {
                                                          setState(() {
                                                            removeDuration(_set
                                                                .duration!
                                                                .value!);
                                                            _exercise.sets!
                                                                .removeAt(sets);
                                                          });
                                                        }),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ).marginOnly(bottom: 10);
                                    },
                                  ),
                                ),
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
                      ).marginOnly(bottom: 10);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  clearData() {
    notes.clear();
    duration.value = 0;
    start.clear();
    end.clear();
    workouts.clear();
    setWorkouts();
  }

  setWorkouts() {
    workouts.add(RoutineWorkouts(
      name: 'Warm Up',
      show: false,
      exercises: <WorkoutExercise>[],
    ));
    workouts.add(RoutineWorkouts(
      name: 'Work Outs',
      show: false,
      exercises: <WorkoutExercise>[],
    ));
    workouts.add(RoutineWorkouts(
      name: 'Static Stretching',
      show: false,
      exercises: <WorkoutExercise>[],
    ));
  }

  RxList<RoutineWorkouts> workouts = <RoutineWorkouts>[].obs;

  final bool edit = Get.arguments[0];
  final Rx<MovementJournalEntry> _journal = MovementJournalEntry(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;
  DateTime initial = DateTime.now();
  setData(DateTime _end) {
    _journal.value.name = name.text;
    _journal.value.date = date.value;
    _journal.value.notes = notes.text;
    _journal.value.start = start.text;
    _journal.value.end = end.text;
    // _journal.value.duration = getDurationString(duration.value);
    _journal.value.durationSeconds = duration.value;
    _journal.value.workouts = workouts;
    final diff = _end.difference(initial).inSeconds;
    if (edit) {
      _journal.value.duration = _journal.value.duration! + diff;
    } else {
      _journal.value.duration = diff;
    }
  }

  fetchData() async {
    _journal.value = Get.arguments[1] as MovementJournalEntry;
    name.text = _journal.value.name ??
        'MovementJournalMoveFreely ${formatTitelDate(DateTime.now())}';
    date.value = _journal.value.date!;
    notes.text = _journal.value.notes!;
    start.text = _journal.value.start!;
    end.text = _journal.value.end!;
    duration.value = _journal.value.durationSeconds!;
    workouts.assignAll(_journal.value.workouts!);
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
        id: _journal.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    if (edit) _journal.value.id = generateId();
    await movementRef.doc(_journal.value.id).set(_journal.value.toMap());
    await addAccomplishment(end);
    Get.back();
    if (!fromsave) Get.back();
    customToast(message: 'Added successfully');
  }

  Future updateJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    await movementRef.doc(_journal.value.id).update(_journal.value.toMap());
    Get.back();
    if (!fromsave) Get.back();
    customToast(message: 'Updated successfully');
  }

  @override
  void initState() {
    setState(() {
      setWorkouts();
      if (edit) fetchData();
    });
    super.initState();
  }
}

class PreviousJournalEntry extends StatelessWidget {
  const PreviousJournalEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Movement Journal - Move Freely',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: movementRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 2)
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
              final MovementJournalEntry model =
                  MovementJournalEntry.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const BlankJournalEntry(),
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
