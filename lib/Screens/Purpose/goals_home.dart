// ignore_for_file: unnecessary_null_comparison, camel_case_types, prefer_typing_uninitialized_variables, avoid_print, unused_field, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Model/bd_models.dart';
import 'package:schedular_project/Model/purpose_mode.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/checkboxRows.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/drop_down_button.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';

import '../../Controller/play_routine_controller.dart';
import '../../Functions/time_picker.dart';
import '../../Global/firebase_collections.dart';
import '../../Model/app_modal.dart';
import '../../Model/app_user.dart';
import '../../Services/auth_services.dart';
import '../../Widgets/app_bar.dart';
import '../../Widgets/checkboxes.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_images.dart';
import '../../Widgets/dialogs.dart';
import '../../Widgets/progress_indicator.dart';
import '../../Widgets/text_widget.dart';
import '../../app_icons.dart';
import '../../thriving_icons_icons.dart';
import '../custom_bottom.dart';
import '../../Widgets/widgets.dart';
import '../readings.dart';

class GoalsController extends GetxController {
  final Rx<CurrentExercises> history = CurrentExercises(
    id: goals,
    index: 6,
    value: 102,
    time: DateTime.now(),
    completed: false,
    connectedPractice: 102,
    connectedReading: 102,
    previousPractice: 102,
    previousReading: 102,
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
        .doc(goals)
        .get()
        .then((value) async {
      if (value.data() == {} || value.data() == null) {
        await currentExercises(Get.find<AuthServices>().userid)
            .doc(goals)
            .set(history.value.toMap());
      } else {
        history.value = CurrentExercises.fromMap(value.data());
      }
    });
    appModel.value = valueGoalList[goalsListIndex(history.value.value!)];
  }

  Rx<AppModel> appModel = AppModel('', '').obs;
  Future updateReadingHistory(int duration) async {
    if (appModel.value.type == 1) {
      userReadings(Get.find<AuthServices>().userid)
          .update({'goals.element': history.value.value});
      addReadingAccomplishment(duration);
    }
  }

  Future addReadingAccomplishment(int duration) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == goals);
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
        .where((value) => value.id == goals);
    if (list.isNotEmpty) {
      list.first.advanced = appModel.value.title;
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future updateHistory(int duration) async {
    if (history.value.value != 115 && !history.value.completed!) {
      await updateReadingHistory(duration);
      history.value.value = history.value.value! + 1;
      _updateData();
    } else if (history.value.value == 115) {
      await updateReadingHistory(duration);
      history.value.value = 113;
      history.value.completed = true;
      await _updateData();
    }
  }

  _updateData() async {
    final _intro = valueGoalList[goalsListIndex(history.value.value!)];
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
      valueGoalList.where((element) => element.type == 1).toList();

  selectData(int value) {
    appModel.value = valueGoalList[goalsListIndex(value)];
    history.value = CurrentExercises(
      id: goals,
      index: 6,
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

class GoalsHome extends StatelessWidget {
  GoalsHome({Key? key}) : super(key: key);
  final GoalsController controller = Get.put(GoalsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              headline('Goals').marginOnly(bottom: 30),
              TopList(
                list: valueGoalList,
                value: controller.history.value.value!,
                onchanged: (val) {}, // (val) => controller.selectData(val),
                play: controller.appModel.value.ontap,
              ),
              Column(
                children: [
                  AppButton(
                    onTap: () => Get.to(() => const PurposeJournals()),
                    title: 'Purpose Journal',
                    description:
                        'Find, clarify, plan, and execute actions that lead towards your purpose daily. A purpose that sets you on fire and resonates with your values and deepest motivations.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(() => const PurposeExercises()),
                    title: 'Exercise for Reaching Goals',
                    description:
                        'Reach your most important goals. Live by your defining values. Create a roadmap to success and a custom system that propels you towards mastery and your definition of success automatically.',
                  ).marginOnly(bottom: 30),
                  AppButton(
                    onTap: () => Get.to(
                      () => GoalsReadings(),
                    ),
                    title: 'Goals Library',
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

class GoalsReadings extends StatelessWidget {
  GoalsReadings({Key? key}) : super(key: key);
  final GoalsController controller = Get.find();

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
            headline('Goals Library').marginOnly(bottom: 20),
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
                      child: elementTitle('Goals'),
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

class PurposeJournals extends StatelessWidget {
  const PurposeJournals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            headline('Purpose Journal').marginOnly(bottom: 30),
            Column(
              children: [
                AppButton(
                  onTap: () =>
                      Get.to(() => const PJL0Screen(), arguments: [false]),
                  title: 'Lvl0- Explore',
                  description:
                      'Explore your goals, dreams, values, and aspirations. What brings you a sense of purpose?',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap: () =>
                      Get.to(() => const PJL1Screen(), arguments: [false]),
                  title: 'Lvl1- Values',
                  description:
                      'Are you honestly living up to your values? If you\'re not, then who are you and where are you going? If you are, how can you do it better?',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap: () =>
                      Get.to(() => const PJL2Screen(), arguments: [false]),
                  title: 'Lvl2- Values, Goals, & Deepest Whys',
                  description:
                      'Achieve meaningful goals tied to your values by always knowing your next move and staying highly motivated.',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap: () =>
                      Get.to(() => const PJL3Screen(), arguments: [false]),
                  title: 'Lvl3- Values, Goals, & Habits',
                  description:
                      'Achieve meaningful goals tied to your values by always knowing your next move, staying highly motivated, and systematically attaining mastery.',
                ).marginOnly(bottom: 30),
              ],
            ).marginOnly(left: 25, right: 25),
          ],
        ),
      ),
    );
  }
}

class PJL0Screen extends StatefulWidget {
  const PJL0Screen({Key? key}) : super(key: key);

  @override
  State<PJL0Screen> createState() => _PJL0ScreenState();
}

class _PJL0ScreenState extends State<PJL0Screen> {
  final TextEditingController name = TextEditingController(
    text: 'PurposeJournalLevel0${formatTitelDate(DateTime.now())}',
  );
  TextEditingController goals = TextEditingController();
  RxString date = formateDate(DateTime.now()).obs;
  @override
  Widget build(BuildContext context) {
    // return Obx(() {
    return Scaffold(
      appBar: customAppbar(),
      bottomNavigationBar: BottomButtons(
        button1: 'Done',
        button2: 'Save',
        onPressed1: () async =>
            edit ? await updateJournal() : await addJournal(),
        onPressed2: () async => await addJournal(true),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        child: Column(
          children: [
            ExerciseTitle(
              title: 'Purpose Journal Level 0: Explore (Practice)',
              onPressed: () => Get.to(
                () => ReadingScreen(
                  title: 'Purpose Journal',
                  link:
                      'https://docs.google.com/document/d/1d58xMAbmYJwsVbx615GTcs_fEaUL00Ft/',
                  linked: () => Get.back(),
                  function: () {
                    if (Get.find<GoalsController>().history.value.value ==
                        103) {
                      final end = DateTime.now();
                      Get.find<GoalsController>()
                          .updateHistory(end.difference(initial).inSeconds);
                    }
                    Get.log('closed');
                  },
                ),
              ),
              // () => Get.to(() => const PurposeJournalReading()),
            ).marginOnly(bottom: 10),
            JournalTop(
              controller: name,
              drive: () => Get.off(() => const PreviousPJL0()),
              save: () async =>
                  edit ? await updateJournal(true) : await addJournal(true),
              add: () => clearData(),
            ).marginOnly(bottom: 10),
            DateWidget(
              date: date.value,
              ontap: () async {
                await customDatePicker(
                  context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                ).then((val) {
                  date.value = formateDate(val);
                });
              },
            ).marginOnly(bottom: 10),
            const TextWidget(
              text:
                  'Free write about your goals. You can mind dump all your expectations, dreams, fears, and ideas here. You can ask yourself questions about how to move towards your goal and then answer them. You can write about how your goals relate to your values and how they are altering increasing or decreasing your authenticity. You can also simply rehash the events of the day that relate to your goals. This is your area to simply focus on your goals.',
              fontStyle: FontStyle.italic,
            ).marginOnly(bottom: 15),
            TextFormField(
              maxLines: 20,
              controller: goals,
              decoration: inputDecoration(),
            ),
          ],
        ),
      ),
    );
    // });
  }

  final bool edit = Get.arguments[0];
  final Rx<PJL0Model> _journal = PJL0Model(
    userid: Get.find<AuthServices>().userid,
    id: generateId(),
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _journal.value.name = name.text;
    _journal.value.goals = goals.text;
    _journal.value.date = date.value;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _journal.value.duration = _journal.value.duration! + diff;
    } else {
      _journal.value.duration = diff;
    }
  }

  fetchData() {
    _journal.value = Get.arguments[1] as PJL0Model;
    name.text = _journal.value.name!;
    goals.text = _journal.value.goals!;
    date.value = _journal.value.date!;
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == 'goals');
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
    await goalsRef.doc(_journal.value.id).set(_journal.value.toMap());
    await addAccomplishment(end);
    Get.back();
    if (!fromsave) {
      if (Get.find<GoalsController>().history.value.value == 104) {
        Get.find<GoalsController>()
            .updateHistory(end.difference(initial).inSeconds);
      }
      Get.back();
    }
    customToast(message: 'Added Successfully');
  }

  Future updateJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    await goalsRef.doc(_journal.value.id).update(_journal.value.toMap());
    Get.back();
    if (!fromsave) Get.back();
    customToast(message: 'Updated successfully');
  }

  clearData() {
    goals.clear();
    _journal.value = PJL0Model(
      userid: Get.find<AuthServices>().userid,
      id: generateId(),
    );
  }

  @override
  void initState() {
    setState(() {
      if (edit) fetchData();
    });
    super.initState();
  }
}

class PreviousPJL0 extends StatelessWidget {
  const PreviousPJL0({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Purpose Journal Level 0= Explore',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: goalsRef
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
              final PJL0Model model =
                  PJL0Model.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const PJL0Screen(),
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

class PJL1Screen extends StatefulWidget {
  const PJL1Screen({Key? key}) : super(key: key);

  @override
  State<PJL1Screen> createState() => _PJL1ScreenState();
}

class _PJL1ScreenState extends State<PJL1Screen> {
  final TextEditingController name = TextEditingController(
    text: 'PurposeJournalLvl1Values${formatTitelDate(DateTime.now())}',
  );
  final RxString date = formateDate(DateTime.now()).obs;

  Rx<ValuesModel> values = ValuesModel().obs;
  Rx<PJL1Model> previousJournal = PJL1Model().obs;

  RxBool completed = false.obs;
  TextEditingController freewrite = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(
          leading: backButton(
            () => index.value == 0 ? Get.back() : previousIndex(),
          ),
          implyLeading: true,
        ),
        bottomNavigationBar: BottomButtons(
          button1: index.value != 1 ? 'Continue' : ' Done',
          button2: 'Save',
          onPressed1: index.value != 1
              ? () => updateIndex()
              : () async => edit ? await updateJournal() : await addJournal(),
          onPressed2: () async => await addJournal(true),
          onPressed3: () => index.value != 0 ? previousIndex() : Get.back(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              ExerciseTitle(
                title: 'Purpose Journal Level 1: Values (Practice)',
                onPressed: () => Get.to(
                  () => ReadingScreen(
                    title: 'Go 99- Values: Authentic & Aspirational',
                    link:
                        'https://docs.google.com/document/d/12e5cPi3zDsC7O9FJXTdEpCI7ahdtAor2/',
                    linked: () => Get.back(),
                    function: () {
                      if (Get.find<GoalsController>().history.value.value ==
                          105) {
                        final end = DateTime.now();
                        Get.find<GoalsController>()
                            .updateHistory(end.difference(initial).inSeconds);
                      }
                      Get.log('closed');
                    },
                  ),
                ),
                // () => Get.to(() => const Go99Reading()),
              ).marginOnly(bottom: 10),
              JournalTop(
                controller: name,
                add: () => clearData(),
                save: () async =>
                    edit ? await updateJournal(true) : await addJournal(true),
                drive: () => Get.offAll(() => const PreviousPJL1()),
              ).marginOnly(bottom: 10),
              if (index.value == 0)
                const TextWidget(
                  text:
                      'Truly track if you are living up to your values everyday. Have your actions reflected your values or have they been a pale shadow or even a parody of your values? What did you do specifically to live up to your values today?',
                  fontStyle: FontStyle.italic,
                ).marginOnly(bottom: 20),
              DateWidget(
                date: date.value,
                ontap: () async {
                  await customDatePicker(
                    context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  ).then((val) {
                    date.value = formateDate(val);
                  });
                },
              ).marginOnly(bottom: 10),
              index.value == 0
                  ? page1()
                  : index.value == 1
                      ? page2()
                      : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget page2() {
    return Column(
      children: [
        const TextWidget(
          text:
              'Free write about your goals. You can mind dump all your expectations, dreams, fears, and ideas here. You can ask yourself questions about how to move towards your goal and then answer them. You can write about how your goals relate to your values and how they are altering, increasing, or decreasing your authenticity. You can also simply rehash the events of the day that relate to your goals. This is your area to simply focus on your goals.',
          fontStyle: FontStyle.italic,
          textAlign: TextAlign.justify,
        ).marginOnly(bottom: 10),
        TextFormField(
          maxLines: 13,
          controller: freewrite,
          decoration: inputDecoration(),
        ),
      ],
    );
  }

  Widget page1() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: width * 0.74,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(text: 'Value List', weight: FontWeight.bold),
                  CustomIconTextButton(
                    text: 'Load Values',
                    onPressed: () async {
                      // getRecentValue();
                      // loadValues.value = !loadValues.value;
                      // setState(() {});
                      Get.dialog(
                        AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: const TextWidget(
                            text: 'Select Value',
                            weight: FontWeight.bold,
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              StreamBuilder(
                                initialData: const [],
                                stream: goalsRef
                                    .where('userid',
                                        isEqualTo:
                                            Get.find<AuthServices>().userid)
                                    .where('type', isEqualTo: 4)
                                    .orderBy('created', descending: true)
                                    .snapshots(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      snapshot.hasError ||
                                      !snapshot.hasData ||
                                      snapshot.data.docs.isEmpty) {
                                    return CircularLoadingWidget(
                                      height: height * 0.2,
                                      onCompleteText: 'No values to select',
                                    );
                                  }
                                  return SizedBox(
                                    height: height * 0.6,
                                    child: ListView.builder(
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        final ValuesModel _value =
                                            ValuesModel.fromMap(
                                                snapshot.data.docs[index]);
                                        return Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                values.value = _value;
                                                Get.back();
                                                setState(() {});
                                              },
                                              child: Card(
                                                elevation: 5.0,
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: TextWidget(
                                                        text: _value.value!)
                                                    .marginAll(15),
                                              ),
                                            ),
                                            if (_value.id == values.value.id)
                                              const Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Icon(Icons.check_circle,
                                                    color: Colors.green),
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () => Get.back(),
                                  child: const TextWidget(
                                    text: 'Cancel',
                                    alignment: Alignment.centerRight,
                                    color: Colors.blue,
                                    size: 16,
                                  ),
                                ),
                              ).marginOnly(top: 15),
                            ],
                          ),
                          actionsAlignment: MainAxisAlignment.end,
                        ),
                      );
                    },
                    icon: const Icon(Icons.drive_folder_upload,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.2,
              child: const TextWidget(
                text: 'Authenticity',
                weight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: width * 0.74,
              child: TextFormField(
                key: Key(values.value.value ?? ''),
                initialValue: values.value.value,
                decoration: inputDecoration(
                  hint: 'Value (autofilled based on loaded values)',
                ),
                onChanged: (val) => setState(() => values.value.value = val),
              ),
            ),
            SizedBox(
              width: width * 0.2,
              child: TextFormField(
                key: Key(values.value.authenticity.toString()),
                initialValue: values.value.authenticity.toString(),
                decoration: inputDecoration(hint: '10'),
                keyboardType: TextInputType.number,
                onChanged: (val) => setState(
                  () => values.value.authenticity = double.parse(val),
                ),
              ),
            ),
          ],
        ),
        TextFormField(
          maxLines: 3,
          // key: Key(values.value.actionTaken ?? ''),
          initialValue: values.value.actionTaken,
          decoration: inputDecoration(hint: 'Action taken to live up to value'),
          onChanged: (val) => setState(() {
            values.value.actionTaken = val;
          }),
        ).marginOnly(bottom: 30),
        const TextWidget(
          text:
              'How will you prepare to live up to your value so that living up to your value is your easiest option, there is no friction, and you have no excuses?',
        ).marginOnly(bottom: 5),
        TextFormField(
          maxLines: 4,
          initialValue: previousJournal.value.prephow,
          decoration: inputDecoration(
            hint: 'Autofilled from last Purpose Journal Entry',
          ),
          onChanged: (val) => setState(() {
            previousJournal.value.prephow = val;
          }),
        ),
        CustomCheckBox(
          value: completed.value,
          onChanged: (val) => completed.value = val,
          title: 'Did you complete your preparation?',
          width: width,
        ),
      ],
    );
  }

  clearData() {
    index.value = 0;
    completed.value = false;
    freewrite.clear();
    values.value = ValuesModel();
    previousJournal.value = PJL1Model();
    _journal.value = PJL1Model(
      id: generateId(),
      userid: Get.find<AuthServices>().userid,
    );
    getPreviousJournal();
    setState(() {});
  }

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;
  previousIndex() => index.value = index.value - 1;

  final bool edit = Get.arguments[0];
  final Rx<PJL1Model> _journal = PJL1Model(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _journal.value.name = name.text;
    _journal.value.script = freewrite.text;
    _journal.value.date = date.value;
    _journal.value.value = PJ1Value(
      value: values.value,
      prephow: previousJournal.value.script,
      completed: completed.value,
      journalid: previousJournal.value.id,
    );
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _journal.value.duration = _journal.value.duration! + diff;
    } else {
      _journal.value.duration = diff;
    }
    setState(() {});
  }

  fetchData() async {
    _journal.value = Get.arguments[1] as PJL1Model;
    name.text = _journal.value.name!;
    date.value = _journal.value.date!;
    freewrite.text = _journal.value.script!;
    final PJ1Value _value = _journal.value.value!;
    values.value = _value.value!;
    completed.value = _value.completed!;
    await goalsRef.doc(_value.journalid).get().then((value) {
      previousJournal.value = PJL1Model.fromMap(value.data());
    });
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == goals);
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
    await goalsRef.doc(_journal.value.id).set(_journal.value.toMap());
    await addAccomplishment(end);
    Get.back();
    if (!fromsave) {
      if (Get.find<GoalsController>().history.value.value == 107) {
        Get.find<GoalsController>()
            .updateHistory(end.difference(initial).inSeconds);
      }
      Get.back();
    }
    customToast(message: 'Added successfully');
  }

  Future updateJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    await goalsRef.doc(_journal.value.id).update(_journal.value.toMap());
    Get.back();
    if (!fromsave) Get.back();
    customToast(message: 'Updated successfully');
  }

  // RxList<ValuesModel> valuesList = <ValuesModel>[].obs;
  Future getRecentValue() async {
    await goalsRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 4)
        .orderBy('created', descending: true)
        .limit(1)
        .get()
        .then((val) {
      if (val.docs.isNotEmpty) {
        for (var doc in val.docs) {
          // valuesList.add(ValuesModel.fromMap(doc));
          values.value = ValuesModel.fromMap(doc);
        }
      }
    });
  }

  // RxBool loadValues = false.obs;
  Future getPreviousJournal() async {
    await goalsRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 1)
        .orderBy('created', descending: true)
        .limit(1)
        .get()
        .then((val) {
      if (val.docs.isNotEmpty) {
        for (var doc in val.docs) {
          previousJournal.value = PJL1Model.fromMap(doc);
        }
      }
    });
  }

  @override
  void initState() {
    setState(() {
      // getRecentValue();
      getPreviousJournal();
      if (edit) fetchData();
    });
    super.initState();
  }
}

class PreviousPJL1 extends StatelessWidget {
  const PreviousPJL1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Purpose Journal Level 1: Values',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: goalsRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 1)
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
              final PJL1Model model =
                  PJL1Model.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const PJL1Screen(),
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

class PJL2Screen extends StatefulWidget {
  const PJL2Screen({Key? key}) : super(key: key);

  @override
  State<PJL2Screen> createState() => _PJL2ScreenState();
}

class _PJL2ScreenState extends State<PJL2Screen> {
  final TextEditingController name = TextEditingController(
    text:
        'PurposeJournalLvl2ValuesGoalsAndDeepestWhys${formatTitelDate(DateTime.now())}',
  );
  final RxString date = formateDate(DateTime.now()).obs;

  final Rx<ValuesModel> values = ValuesModel().obs;
  final Rx<GoalsModel> goals = GoalsModel().obs;
  final Rx<PJL2Model> previousJournal = PJL2Model().obs;
  final RxBool complete = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(
          leading: backButton(
            () => index.value == 0 ? Get.back() : previousIndex(),
          ),
          implyLeading: true,
        ),
        bottomNavigationBar: BottomButtons(
          button1: index.value != 2 ? 'Continue' : 'Done',
          onPressed2: () async => await addJournal(true),
          onPressed3: () => index.value != 0 ? previousIndex() : Get.back(),
          onPressed1: index.value != 2
              ? () => updateIndex()
              : () async => edit ? await updateJournal() : await addJournal(),
        ),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: Column(
            children: [
              ExerciseTitle(
                title:
                    'Purpose Journal Level 2: Values, Goals & Deepest Why\'s',
                onPressed: () => Get.to(
                  () => ReadingScreen(
                    title: 'Go100- Goals Setting and Your Deepest Why\'s ',
                    link:
                        'https://docs.google.com/document/d/1XBRFh4ahttXdWvy4i6COPqGVtM_mJ8fl/',
                    linked: () => Get.back(),
                    function: () {
                      if (Get.find<GoalsController>().history.value.value ==
                          108) {
                        final end = DateTime.now();
                        Get.find<GoalsController>()
                            .updateHistory(end.difference(initial).inSeconds);
                      }
                      Get.log('closed');
                    },
                  ),
                ),
                // () => Get.to(() => const Go100Reading()),
              ).marginOnly(bottom: 10),
              JournalTop(
                controller: name,
                add: () => clearData(),
                drive: () => Get.off(() => const PreviousPJL2()),
                save: () async =>
                    edit ? await updateJournal(true) : await addJournal(true),
              ).marginOnly(bottom: 10),
              index.value == 0
                  ? page1()
                  : index.value == 1
                      ? page2()
                      : index.value == 2
                          ? page3()
                          : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget page3() {
    return Column(
      children: [
        const TextWidget(
          text: 'Next Actions & Preparation',
          weight: FontWeight.bold,
        ).marginOnly(top: 20, bottom: 20),
        const TextWidget(
          text:
              'What is the next concrete action you need to take to complete your goal?',
        ),
        TextFormField(
          initialValue: previousJournal.value.nextConcreteAction ?? '',
          decoration: inputDecoration(
            hint: 'Autofilled from last purpose journal entry',
          ),
          onChanged: (val) => setState(() {
            previousJournal.value.nextConcreteAction = val;
          }),
        ).marginOnly(bottom: height * 0.1),
        const TextWidget(
          text:
              'How will you prepare to live up to your value, goal, and/ or next action so that it is your easiest option, there is no friction in your execution, and you have no excuses?',
        ).marginOnly(bottom: 10),
        TextFormField(
          initialValue: previousJournal.value.prepare ?? '',
          decoration: inputDecoration(
            hint: 'Autofilled from last purpose journal entry',
          ),
          onChanged: (val) => setState(() {
            previousJournal.value.prepare = val;
          }),
        ),
        CustomCheckBox(
          value: complete.value,
          onChanged: (val) => complete.value = val,
          title: 'Did you complete your preparation?',
          width: width,
        ),
      ],
    );
  }

  RxBool loadgoals = false.obs;
  Widget page2() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextWidget(
              text: 'Goals & Deepest Why\'s',
              weight: FontWeight.bold,
            ),
            CustomIconTextButton(
              text: 'Load Goals',
              icon: const Icon(Icons.drive_folder_upload_rounded,
                  color: Colors.black),
              onPressed: () async {
                // await getRecentGoal();
                // loadgoals.value = true;
                // setState(() {});
                Get.dialog(
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: const TextWidget(
                      text: 'Select Goals',
                      weight: FontWeight.bold,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StreamBuilder(
                          initialData: const [],
                          stream: goalsRef
                              .where('userid',
                                  isEqualTo: Get.find<AuthServices>().userid)
                              .where('type', isEqualTo: 5)
                              .orderBy('created', descending: true)
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                snapshot.hasError ||
                                !snapshot.hasData ||
                                snapshot.data.docs.isEmpty) {
                              return CircularLoadingWidget(
                                height: height * 0.2,
                                onCompleteText: 'No goals to select',
                              );
                            }
                            return SizedBox(
                              height: height * 0.6,
                              child: ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  final GoalsModel _value = GoalsModel.fromMap(
                                      snapshot.data.docs[index]);
                                  return Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          goals.value = _value;
                                          Get.back();
                                          setState(() {});
                                        },
                                        child: Card(
                                          elevation: 5.0,
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: TextWidget(text: _value.goal!)
                                              .marginAll(15),
                                        ),
                                      ),
                                      if (_value.id == goals.value.id)
                                        const Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Icon(Icons.check_circle,
                                              color: Colors.green),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => Get.back(),
                            child: const TextWidget(
                              text: 'Cancel',
                              alignment: Alignment.centerRight,
                              color: Colors.blue,
                              size: 16,
                            ),
                          ),
                        ).marginOnly(top: 15),
                      ],
                    ),
                    actionsAlignment: MainAxisAlignment.end,
                  ),
                );
              },
            ),
          ],
        ),
        // if (loadgoals.value)
        Column(
          children: [
            TextFormField(
              key: Key(goals.value.goal ?? '0'),
              initialValue: goals.value.goal,
              decoration: inputDecoration(
                hint: 'Goal (autofilled from loaded goals)',
              ),
              onChanged: (val) => setState(() {
                goals.value.goal = val;
              }),
            ),
            TextFormField(
              readOnly: true,
              key: Key(goals.value.complete ?? ''),
              initialValue: goals.value.complete,
              decoration: inputDecoration(
                hint: 'When will I complete this goal? (autofilled)',
              ),
              onChanged: (val) => setState(() {
                goals.value.complete = val;
              }),
              onTap: () async {
                await customDatePicker(
                  context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                ).then((value) {
                  goals.value.complete = formateDate(value);
                });
              },
            ),
            TextFormField(
              // keyboardType: TextInputType.number,
              key: Key(goals.value.measureNumerically ?? '1'),
              initialValue: goals.value.measureNumerically,
              decoration: inputDecoration(
                hint: 'How can I measure completion numerically? (autofilled)',
              ),
              onChanged: (val) => setState(() {
                goals.value.measureNumerically = val;
              }),
            ),
            TextFormField(
              key: Key(goals.value.deepestWhys ?? '2'),
              initialValue: goals.value.deepestWhys,
              decoration: inputDecoration(
                hint:
                    'What is my deepest why\'s to complete this goal? (autofilled)',
              ),
              onChanged: (val) => setState(() {
                goals.value.deepestWhys = val;
              }),
            ),
            TextFormField(
              maxLines: 5,
              initialValue: goals.value.freeWrite,
              decoration: inputDecoration(
                hint:
                    'Free write about this goal. You can mind dump all your expectations, dreams, fears, and ideas here. You can ask yourself questions about how to move towards your goal and then answer them. You can write about how your goals relate to your values and how they are altering increasing or decreasing your authenticity. You can also simply rehash the events of the day that relate to your goals. This is your area to simply focus on your goals.',
              ),
              onChanged: (val) => setState(() {
                goals.value.freeWrite = val;
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget page1() {
    return Column(
      children: [
        const TextWidget(
          text:
              'Truly track if you are living up to your values and goals everyday. Have your actions reflected your values and goals? ',
          fontStyle: FontStyle.italic,
        ).marginOnly(bottom: 20),
        DateWidget(
          date: date.value,
          ontap: () async {
            await customDatePicker(
              context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            ).then((val) {
              date.value = formateDate(val);
            });
          },
        ).marginOnly(bottom: 10),
        Row(
          children: [
            SizedBox(
              width: width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(text: 'Value List', weight: FontWeight.bold),
                  CustomIconTextButton(
                    icon: const Icon(Icons.drive_folder_upload,
                        color: Colors.black),
                    text: 'Load Values',
                    onPressed: () async {
                      // getRecentValue();
                      // setState(() {});
                      Get.dialog(
                        AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: const TextWidget(
                            text: 'Select Value',
                            weight: FontWeight.bold,
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              StreamBuilder(
                                initialData: const [],
                                stream: goalsRef
                                    .where('userid',
                                        isEqualTo:
                                            Get.find<AuthServices>().userid)
                                    .where('type', isEqualTo: 4)
                                    .orderBy('created', descending: true)
                                    .snapshots(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      snapshot.hasError ||
                                      !snapshot.hasData ||
                                      snapshot.data.docs.isEmpty) {
                                    return CircularLoadingWidget(
                                      height: height * 0.2,
                                      onCompleteText: 'No values to select',
                                    );
                                  }
                                  return SizedBox(
                                    height: height * 0.6,
                                    child: ListView.builder(
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        final ValuesModel _value =
                                            ValuesModel.fromMap(
                                                snapshot.data.docs[index]);
                                        return Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                values.value = _value;
                                                authenticity.text = _value
                                                    .authenticity
                                                    .toString();
                                                Get.back();
                                                setState(() {});
                                              },
                                              child: Card(
                                                elevation: 5.0,
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: TextWidget(
                                                        text: _value.value!)
                                                    .marginAll(15),
                                              ),
                                            ),
                                            if (_value.id == values.value.id)
                                              const Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Icon(Icons.check_circle,
                                                    color: Colors.green),
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () => Get.back(),
                                  child: const TextWidget(
                                    text: 'Cancel',
                                    alignment: Alignment.centerRight,
                                    color: Colors.blue,
                                    size: 16,
                                  ),
                                ),
                              ).marginOnly(top: 15),
                            ],
                          ),
                          actionsAlignment: MainAxisAlignment.end,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.2,
              child: const TextWidget(
                text: 'Authenticity',
                weight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: width * 0.71,
              child: TextFormField(
                key: Key(values.value.value.toString()),
                initialValue: values.value.value,
                decoration: inputDecoration(
                  hint: 'Value (autofilled based on loaded values)',
                ),
                onChanged: (val) => setState(() => values.value.value = val),
              ),
            ),
            SizedBox(
              width: width * 0.2,
              child: TextFormField(
                // key: Key(values.value.authenticity.toString()),
                // initialValue: values.value.authenticity.toString(),
                controller: authenticity,
                decoration: inputDecoration(hint: '10'),
                keyboardType: TextInputType.number,
                onChanged: (val) => setState(
                  () => values.value.authenticity = double.parse(val),
                ),
              ),
            ),
          ],
        ),
        TextFormField(
          maxLines: 3,
          initialValue: values.value.actionTaken,
          decoration: inputDecoration(hint: 'Action taken to live up to value'),
          onChanged: (val) => setState(() {
            values.value.actionTaken = val;
          }),
        ).marginOnly(bottom: 10),
      ],
    );
  }

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;
  previousIndex() => index.value = index.value - 1;

  TextEditingController authenticity = TextEditingController();

  Future getRecentValue() async {
    await goalsRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 4)
        .orderBy('created', descending: true)
        .limit(1)
        .get()
        .then((val) {
      if (val.docs.isNotEmpty) {
        for (var doc in val.docs) {
          values.value = ValuesModel.fromMap(doc);
          authenticity.text = values.value.authenticity.toString();
        }
      }
    });
  }

  Future getRecentGoal() async {
    await goalsRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 5)
        .orderBy('created', descending: true)
        .limit(1)
        .get()
        .then((val) {
      if (val.docs.isNotEmpty) {
        for (var doc in val.docs) {
          goals.value = GoalsModel.fromMap(doc);
        }
      }
    });
  }

  Future getPreviousJournal() async {
    await goalsRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 2)
        .orderBy('created', descending: true)
        .limit(1)
        .get()
        .then((val) {
      if (val.docs.isNotEmpty) {
        for (var doc in val.docs) {
          previousJournal.value = PJL2Model.fromMap(doc);
        }
      }
    });
  }

  final bool edit = Get.arguments[0];
  final Rx<PJL2Model> _journal = PJL2Model(
    userid: Get.find<AuthServices>().userid,
    id: generateId(),
  ).obs;

  clearData() {
    index.value == 0;
    complete.value = false;
    values.value = ValuesModel();
    goals.value = GoalsModel();
    previousJournal.value = PJL2Model();
    _journal.value = PJL2Model(
      userid: Get.find<AuthServices>().userid,
      id: generateId(),
    );
    getPreviousJournal();
    setState(() {});
  }

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _journal.value.name = name.text;
    _journal.value.date = date.value;
    _journal.value.complete = complete.value;
    _journal.value.goal = goals.value;
    _journal.value.value = values.value;
    _journal.value.prepare = previousJournal.value.prepare;
    _journal.value.nextConcreteAction =
        previousJournal.value.nextConcreteAction;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _journal.value.duration = _journal.value.duration! + diff;
    } else {
      _journal.value.duration = diff;
    }
  }

  fetchData() {
    _journal.value = Get.arguments[1] as PJL2Model;
    name.text = _journal.value.name!;
    date.value = _journal.value.date!;
    complete.value = _journal.value.complete!;
    goals.value = _journal.value.goal!;
    values.value = _journal.value.value!;
    previousJournal.value.prepare = _journal.value.prepare!;
    previousJournal.value.nextConcreteAction =
        _journal.value.nextConcreteAction!;
    authenticity.text = values.value.authenticity.toString();
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == 'goals');
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
    await goalsRef.doc(_journal.value.id).set(_journal.value.toMap());
    await addAccomplishment(end);
    Get.back();
    if (!fromsave) {
      if (Get.find<GoalsController>().history.value.value == 110) {
        Get.find<GoalsController>()
            .updateHistory(end.difference(initial).inSeconds);
      }
      Get.back();
    }
    customToast(message: 'Added successfully');
  }

  Future updateJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    await goalsRef.doc(_journal.value.id).update(_journal.value.toMap());
    Get.back();
    if (!fromsave) Get.back();
    customToast(message: 'Updated successfully');
  }

  @override
  void initState() {
    setState(() {
      getPreviousJournal();
      if (edit) fetchData();
    });
    super.initState();
  }
}

class PreviousPJL2 extends StatelessWidget {
  const PreviousPJL2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Purpose Journal Level 2: Values, Goals, & Deepest Why\'s',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: goalsRef
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
              final PJL2Model model =
                  PJL2Model.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const PJL2Screen(),
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

class PJL3Screen extends StatefulWidget {
  const PJL3Screen({Key? key}) : super(key: key);

  @override
  State<PJL3Screen> createState() => _PJL3ScreenState();
}

class _PJL3ScreenState extends State<PJL3Screen> {
  final TextEditingController name = TextEditingController(
      text:
          'PurposeJournalLvl3ValuesGoalsAndHabits${formatTitelDate(DateTime.now())}');
  final RxString date = formateDate(DateTime.now()).obs;
  final Rx<ValuesModel> values = ValuesModel().obs;
  final Rx<GoalsModel> goals = GoalsModel().obs;
  final Rx<RoadmapModel> roadmap = RoadmapModel(id: '').obs;
  final Rx<PJL3Model> previousJournal = PJL3Model().obs;
  final RxBool complete = false.obs;

  final RxBool _roadmap = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: customAppbar(
            leading: backButton(
              () => index.value == 0 ? Get.back() : previousIndex(),
            ),
            implyLeading: true,
          ),
          bottomNavigationBar: BottomButtons(
            button1: index.value != 2 ? 'Continue' : 'Done',
            onPressed2: () async => await addJournal(true),
            onPressed3: () => index.value != 0 ? previousIndex() : Get.back(),
            onPressed1: index.value != 2
                ? () => updateIndex()
                : () async => edit ? await updateJournal() : await addJournal(),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 10,
              bottom: 10,
            ),
            child: Column(
              children: [
                ExerciseTitle(
                  title:
                      'Purpose Journal Level 3: Values, Goals & Habits (Practice)',
                  onPressed: () => Get.to(
                    () => ReadingScreen(
                      title: 'G0101- Creating a Roadmap & System',
                      link:
                          'https://docs.google.com/document/d/1qGvSLsdFlhnNaS441cac0YpD2p9rxGEx/',
                      linked: () => Get.back(),
                      function: () {
                        if (Get.find<GoalsController>().history.value.value ==
                            111) {
                          final end = DateTime.now();
                          Get.find<GoalsController>()
                              .updateHistory(end.difference(initial).inSeconds);
                        }
                        Get.log('closed');
                      },
                    ),
                  ),
                  // () => Get.to(() => const Go101Reading()),
                ).marginOnly(bottom: 10),
                JournalTop(
                  controller: name,
                  drive: () => Get.off(() => const PreviousPJL3()),
                  save: () async =>
                      edit ? await updateJournal(true) : await addJournal(true),
                  add: () => clearData(),
                ).marginOnly(bottom: 10),
                index.value == 0
                    ? page1()
                    : index.value == 1
                        ? page2()
                        : index.value == 2
                            ? page3()
                            : Container(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget page3() {
    return Column(
      children: [
        const TextWidget(
          text: 'Next Actions & Preparation',
          weight: FontWeight.bold,
        ).marginOnly(top: 20, bottom: 20),
        const TextWidget(
          text:
              'What is the next concrete action you need to take to complete your goal?',
        ),
        TextFormField(
          initialValue: previousJournal.value.nextConcreteAction ?? '',
          decoration: inputDecoration(
            hint: 'Autofilled from last purpose journal entry',
          ),
          onChanged: (val) => setState(() {
            previousJournal.value.nextConcreteAction = val;
          }),
        ).marginOnly(bottom: height * 0.1),
        const TextWidget(
          text:
              'How will you prepare to live up to your value, goal, and/ or next action so that it is your easiest option, there is no friction in your execution, and you have no excuses?',
        ).marginOnly(bottom: 10),
        TextFormField(
          initialValue: previousJournal.value.prepare ?? '',
          decoration: inputDecoration(
            hint: 'Autofilled from last purpose journal entry',
          ),
          onChanged: (val) => setState(() {
            previousJournal.value.prepare = val;
          }),
        ),
        CustomCheckBox(
          value: complete.value,
          onChanged: (val) => complete.value = val,
          title: 'Did you complete your preparation?',
          width: width,
        ),
      ],
    );
  }

  Widget page2() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextWidget(
              text: 'Goals & Deepest Why\'s',
              weight: FontWeight.bold,
            ),
            CustomIconTextButton(
              text: 'Load Goals',
              icon: const Icon(Icons.drive_folder_upload_rounded,
                  color: Colors.black),
              onPressed: () async {
                // await getRecentGoal();
                // setState(() {});
                Get.dialog(
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: const TextWidget(
                      text: 'Select Goal',
                      weight: FontWeight.bold,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StreamBuilder(
                          initialData: const [],
                          stream: goalsRef
                              .where('userid',
                                  isEqualTo: Get.find<AuthServices>().userid)
                              .where('type', isEqualTo: 5)
                              .orderBy('created', descending: true)
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                snapshot.hasError ||
                                !snapshot.hasData ||
                                snapshot.data.docs.isEmpty) {
                              return CircularLoadingWidget(
                                height: height * 0.2,
                                onCompleteText: 'No values to select',
                              );
                            }
                            return SizedBox(
                              height: height * 0.6,
                              child: ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  final GoalsModel _value = GoalsModel.fromMap(
                                      snapshot.data.docs[index]);
                                  return Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          goals.value = _value;
                                          selectRoadmap(_value.id!);
                                          // Get.back();
                                          // setState(() {});
                                        },
                                        child: Card(
                                          elevation: 5.0,
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: TextWidget(text: _value.goal!)
                                              .marginAll(15),
                                        ),
                                      ),
                                      if (_value.id == goals.value.id)
                                        const Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Icon(Icons.check_circle,
                                              color: Colors.green),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => Get.back(),
                            child: const TextWidget(
                              text: 'Cancel',
                              alignment: Alignment.centerRight,
                              color: Colors.blue,
                              size: 16,
                            ),
                          ),
                        ).marginOnly(top: 15),
                      ],
                    ),
                    actionsAlignment: MainAxisAlignment.end,
                  ),
                );
              },
            ),
          ],
        ),
        TextFormField(
          key: Key(goals.value.goal ?? '1'),
          initialValue: goals.value.goal,
          decoration:
              inputDecoration(hint: 'Goal (autofilled from loaded goals)'),
          onChanged: (val) => setState(() {
            goals.value.goal = val;
          }),
        ),
        TextFormField(
          readOnly: true,
          key: Key(goals.value.complete ?? '2'),
          initialValue: goals.value.complete,
          decoration: inputDecoration(
            hint: 'When will I complete this goal? (autofilled)',
          ),
          onChanged: (val) => setState(() {
            goals.value.complete = val;
          }),
          onTap: () async {
            await customDatePicker(
              context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            ).then((value) {
              goals.value.complete = formateDate(value);
            });
          },
        ),
        TextFormField(
          // keyboardType: TextInputType.number,
          key: Key(goals.value.measureNumerically ?? '3'),
          initialValue: goals.value.measureNumerically.toString(),
          decoration: inputDecoration(
            hint: 'How can I measure completion numerically? (autofilled)',
          ),
          onChanged: (val) => setState(() {
            goals.value.measureNumerically = val;
          }),
        ),
        TextFormField(
          key: Key(goals.value.deepestWhys ?? '4'),
          initialValue: goals.value.deepestWhys,
          decoration: inputDecoration(
            hint:
                'What is my deepest why\'s to complete this goal? (autofilled)',
          ),
          onChanged: (val) => setState(() {
            goals.value.deepestWhys = val;
          }),
        ),
        TextFormField(
          maxLines: 8,
          initialValue: edit ? goals.value.freeWrite : null,
          decoration: inputDecoration(
            hint:
                'Free write about this goal. You can mind dump all your expectations, dreams, fears, and ideas here. You can ask yourself questions about how to move towards your goal and then answer them. You can write about how your goals relate to your values and how they are altering increasing or decreasing your authenticity. You can also simply rehash the events of the day that relate to your goals. This is your area to simply focus on your goals.',
          ),
          onChanged: (val) => setState(() {
            goals.value.freeWrite = val;
          }),
        ).marginOnly(bottom: 20),
        if (roadmap.value.id != '')
          Column(
            children: [
              const TextWidget(text: 'System', weight: FontWeight.bold)
                  .marginOnly(bottom: 10),
              TextFormField(
                initialValue: roadmap.value.habit!.name,
                decoration: inputDecoration(
                  hint:
                      'System Habit (Name of Habit autofilled from "System Habits"',
                ),
                onChanged: (val) => setState(() {
                  roadmap.value.habit!.name = val;
                }),
              ),
              CustomCheckBox(
                value: roadmap.value.habit!.complete,
                onChanged: (val) => setState(() {
                  roadmap.value.habit!.complete = val;
                }),
                title: 'Complete',
                width: width,
              ).marginOnly(bottom: 15),
              CustomCheckBox(
                value: _roadmap.value,
                onChanged: (val) => setState(() {
                  _roadmap.value = val;
                }),
                title: 'Roadmap (Milestones)',
                width: width,
              ),
              if (_roadmap.value)
                LinearProgressIndicator(value: progressValue())
                    .marginOnly(bottom: 10),
              if (_roadmap.value)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      roadmap.value.milestone!.length,
                      (index) => milestoneWidget(index),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  selectRoadmap(String goalid) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const TextWidget(
          text: 'Select Roadmap',
          weight: FontWeight.bold,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder(
              initialData: const [],
              stream: goalsRef
                  .where('userid', isEqualTo: Get.find<AuthServices>().userid)
                  .where('type', isEqualTo: 6)
                  .where('goal.goal_id', isEqualTo: goalid)
                  .orderBy('created', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot _snapshot) {
                if (_snapshot.connectionState == ConnectionState.waiting ||
                    _snapshot.hasError ||
                    !_snapshot.hasData ||
                    _snapshot.data.docs.isEmpty) {
                  return CircularLoadingWidget(
                    height: height * 0.2,
                    onCompleteText: 'No roadmaps to select',
                  );
                }
                return SizedBox(
                  height: height * 0.6,
                  child: ListView.builder(
                    itemCount: _snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      final RoadmapModel _map =
                          RoadmapModel.fromMap(_snapshot.data.docs[index]);
                      return Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              roadmap.value = _map;
                              Get.back();
                              Get.back();
                              setState(() {});
                            },
                            child: Card(
                              elevation: 5.0,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: TextWidget(text: _map.name!).marginAll(15),
                            ),
                          ),
                          if (_map.id == roadmap.value.id)
                            const Positioned(
                              top: 0,
                              right: 0,
                              child:
                                  Icon(Icons.check_circle, color: Colors.green),
                            ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => Get.back(),
                child: const TextWidget(
                  text: 'Cancel',
                  alignment: Alignment.centerRight,
                  color: Colors.blue,
                  size: 16,
                ),
              ),
            ).marginOnly(top: 15),
          ],
        ),
        actionsAlignment: MainAxisAlignment.end,
      ),
    );
  }

  Widget milestoneWidget(int indx) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: width * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCheckBox(
                value: roadmap.value.milestone![indx].complete,
                onChanged: (val) {
                  setState(() {
                    roadmap.value.milestone![indx].complete = val;
                  });
                },
                title: 'Complete?',
              ),
              TextFormField(
                readOnly: true,
                initialValue: roadmap.value.milestone![indx].completion,
                decoration: inputDecoration(hint: 'Deadline'),
                onChanged: (val) => setState(
                    () => roadmap.value.milestone![indx].completion = val),
              ),
              TextFormField(
                readOnly: true,
                initialValue: roadmap.value.milestone![indx].milestone,
                decoration: inputDecoration(hint: 'Goal or Milestone'),
                onChanged: (val) => setState(
                    () => roadmap.value.milestone![indx].milestone = val),
              ),
              TextFormField(
                readOnly: true,
                // keyboardType: TextInputType.number,
                initialValue:
                    roadmap.value.milestone![indx].measureCompletion.toString(),
                decoration: inputDecoration(hint: 'Measure Completion'),
                onChanged: (val) => setState(() =>
                    roadmap.value.milestone![indx].measureCompletion = val),
              ),
            ],
          ),
        ),
        const SizedBox(width: 100, child: Divider()),
      ],
    );
  }

  double progressValue() {
    if (roadmap.value.milestone!.isNotEmpty) {
      int _completed = roadmap.value.milestone!
          .where((element) => element.complete == true)
          .toList()
          .length;
      return _completed / (roadmap.value.milestone!.length);
    } else {
      return 0.0;
    }
  }

  TextEditingController authenticity = TextEditingController();
  Widget page1() {
    return Column(
      children: [
        const TextWidget(
          text:
              'Truly track if you are living up to your values and goals everyday. Have your actions reflected your values and goals? ',
          fontStyle: FontStyle.italic,
        ).marginOnly(bottom: 20),
        DateWidget(
          date: date.value,
          ontap: () async {
            await customDatePicker(
              context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            ).then((val) {
              date.value = formateDate(val);
            });
          },
        ).marginOnly(bottom: 10),
        Row(
          children: [
            SizedBox(
              width: width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(text: 'Value List', weight: FontWeight.bold),
                  CustomIconTextButton(
                    text: 'Load Values',
                    onPressed: () async {
                      // getRecentValue();
                      // setState(() {});
                      Get.dialog(
                        AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: const TextWidget(
                            text: 'Select Value',
                            weight: FontWeight.bold,
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              StreamBuilder(
                                initialData: const [],
                                stream: goalsRef
                                    .where('userid',
                                        isEqualTo:
                                            Get.find<AuthServices>().userid)
                                    .where('type', isEqualTo: 4)
                                    .orderBy('created', descending: true)
                                    .snapshots(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      snapshot.hasError ||
                                      !snapshot.hasData ||
                                      snapshot.data.docs.isEmpty) {
                                    return CircularLoadingWidget(
                                      height: height * 0.2,
                                      onCompleteText: 'No values to select',
                                    );
                                  }
                                  return SizedBox(
                                    height: height * 0.6,
                                    child: ListView.builder(
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        final ValuesModel _value =
                                            ValuesModel.fromMap(
                                                snapshot.data.docs[index]);
                                        return Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                values.value = _value;
                                                authenticity.text = _value
                                                    .authenticity
                                                    .toString();
                                                loadvalue.value = true;
                                                Get.back();
                                                setState(() {});
                                              },
                                              child: Card(
                                                elevation: 5.0,
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: TextWidget(
                                                        text: _value.value!)
                                                    .marginAll(15),
                                              ),
                                            ),
                                            if (_value.id == values.value.id)
                                              const Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Icon(Icons.check_circle,
                                                    color: Colors.green),
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () => Get.back(),
                                  child: const TextWidget(
                                    text: 'Cancel',
                                    alignment: Alignment.centerRight,
                                    color: Colors.blue,
                                    size: 16,
                                  ),
                                ),
                              ).marginOnly(top: 15),
                            ],
                          ),
                          actionsAlignment: MainAxisAlignment.end,
                        ),
                      );
                    },
                    icon: const Icon(Icons.drive_folder_upload,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.2,
              child: const TextWidget(
                text: 'Authenticity',
                weight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: width * 0.7,
              child: TextFormField(
                key: Key(values.value.value ?? ''),
                initialValue: values.value.value,
                decoration: inputDecoration(
                  hint: 'Value (autofilled based on loaded values)',
                ),
                onChanged: (val) => setState(() => values.value.value = val),
              ),
            ),
            SizedBox(
              width: width * 0.21,
              child: TextFormField(
                // key: Key(values.value.authenticity.toString()),
                // initialValue:
                //     !edit ? null : values.value.authenticity.toString(),
                controller: authenticity,
                decoration: inputDecoration(hint: '10'),
                keyboardType: TextInputType.number,
                onChanged: (val) => setState(
                  () => values.value.authenticity = double.parse(val),
                ),
              ),
            ),
          ],
        ),
        TextFormField(
          maxLines: 3,
          initialValue: values.value.actionTaken,
          decoration: inputDecoration(hint: 'Action taken to live up to value'),
          onChanged: (val) => setState(() {
            values.value.actionTaken = val;
          }),
        ).marginOnly(bottom: 10),
      ],
    );
  }

  RxBool loadvalue = false.obs;

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;
  previousIndex() => index.value = index.value - 1;

  Future getRecentValue() async {
    await goalsRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 4)
        .orderBy('created', descending: true)
        .limit(1)
        .get()
        .then((val) {
      if (val.docs.isNotEmpty) {
        for (var doc in val.docs) {
          values.value = ValuesModel.fromMap(doc);
          authenticity.text = values.value.authenticity.toString();
        }
      }
    });
  }

  Future getRecentGoal() async {
    await goalsRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 6)
        .orderBy('created', descending: true)
        .limit(1)
        .get()
        .then((val) async {
      if (val.docs.isNotEmpty) {
        for (var doc in val.docs) {
          roadmap.value = RoadmapModel.fromMap(doc);
          await goalsRef.doc(roadmap.value.goal!.goalid).get().then((_goal) {
            goals.value = GoalsModel.fromMap(_goal);
          });
        }
      }
    });
  }

  Future getPreviousJournal() async {
    await goalsRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 3)
        .orderBy('created', descending: true)
        .limit(1)
        .get()
        .then((val) {
      if (val.docs.isNotEmpty) {
        for (var doc in val.docs) {
          previousJournal.value = PJL3Model.fromMap(doc);
          values.value = previousJournal.value.value!;
          goals.value = previousJournal.value.goal!;
          roadmap.value = previousJournal.value.roadmap!;
          authenticity.text = values.value.authenticity.toString();
        }
      }
    });
  }

  final bool edit = Get.arguments[0];
  final Rx<PJL3Model> _journal = PJL3Model(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  clearData() {
    index.value = 0;
    complete.value = false;
    _roadmap.value = false;
    values.value = ValuesModel();
    goals.value = GoalsModel();
    roadmap.value = RoadmapModel();
    previousJournal.value = PJL3Model();
    _journal.value = PJL3Model(
      id: generateId(),
      userid: Get.find<AuthServices>().userid,
    );
    setState(() {});
  }

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _journal.value.name = name.text;
    _journal.value.date = date.value;
    _journal.value.value = values.value;
    _journal.value.roadmap = roadmap.value;
    _journal.value.goal = goals.value;
    _journal.value.systemHabit = roadmap.value.habit;
    _journal.value.nextConcreteAction =
        previousJournal.value.nextConcreteAction ?? '';
    _journal.value.prepare = previousJournal.value.prepare ?? '';
    _journal.value.complete = complete.value;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _journal.value.duration = _journal.value.duration! + diff;
    } else {
      _journal.value.duration = diff;
    }
  }

  fetchData() {
    _journal.value = Get.arguments[1] as PJL3Model;
    name.text = _journal.value.name!;
    date.value = _journal.value.date!;
    values.value = _journal.value.value!;
    roadmap.value = _journal.value.roadmap!;
    goals.value = _journal.value.goal!;
    previousJournal.value.nextConcreteAction =
        _journal.value.nextConcreteAction!;
    previousJournal.value.prepare = _journal.value.prepare!;
    complete.value = _journal.value.complete!;
    authenticity.text = values.value.authenticity.toString();
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == 'goals');
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
    await goalsRef.doc(_journal.value.id).set(_journal.value.toMap());
    await addAccomplishment(end);
    Get.back();
    if (!fromsave) {
      if (Get.find<GoalsController>().history.value.value == 113) {
        Get.find<GoalsController>()
            .updateHistory(end.difference(initial).inSeconds);
      }
      Get.back();
    }
    customToast(message: 'Added successfully');
  }

  Future updateJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    if (edit) _journal.value.id = generateId();
    await goalsRef.doc(_journal.value.id).update(_journal.value.toMap());
    Get.back();
    if (!fromsave) Get.back();
    customToast(message: 'Updated successfully');
  }

  @override
  void initState() {
    setState(() {
      // getRecentValue();
      // getRecentGoal();
      getPreviousJournal();
      if (edit) fetchData();
    });
    super.initState();
  }
}

class PreviousPJL3 extends StatelessWidget {
  const PreviousPJL3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Purpose Journal Level 3: Values, Goals, & Habits',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: goalsRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 3)
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
              final PJL3Model model =
                  PJL3Model.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const PJL3Screen(),
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

class PurposeExercises extends StatelessWidget {
  const PurposeExercises({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            headline('Exercises for Reaching Goals').marginOnly(bottom: 30),
            Column(
              children: [
                AppButton(
                  onTap: () =>
                      Get.to(() => const ValueScreen(), arguments: [false]),
                  title: 'Values',
                  description:
                      'What are your most important values? Are you living up to them?',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap: () => Get.to(
                    () => const GoalsSettingScreen(),
                    arguments: [false],
                  ),
                  title: 'Goal Setting & Your Deepest Whys',
                  description:
                      'Create clearly defined goals that align with your values and set yourself on fire by identifying your deepest whys.',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap: () =>
                      Get.to(() => const RoadmapScreen(), arguments: [false]),
                  title: 'Roadmap',
                  description:
                      'Know the exact steps that need to be taken to complete your goal and identify the keystone habit that leads to mastering your craft. Use behavioral science to make the ',
                ).marginOnly(bottom: 30),
                AppButton(
                  onTap: () => Get.to(() => const PeriodicReviewScreen(),
                      arguments: [false]),
                  title: 'Periodic Review',
                  description:
                      'Review your progress. Create strategies to remove obstacles to success and overcome any challenges in your path. ',
                ).marginOnly(bottom: 30),
                // AppButton(
                //   onTap: () => {},
                //   title: 'Copy the Best',
                //   description:
                //       'Copy the highest achievers in your industry to mimic their success.',
                // ).marginOnly(bottom: 30),
                // AppButton(
                //   onTap: () => {},
                //   title: 'Creating a System',
                //   description:
                //       'Start creating a custom system of habits that will consistently edge you towards mastering your craft and completing your goal like clockwork.',
                // ).marginOnly(bottom: 30),
              ],
            ).marginOnly(left: 25, right: 25),
          ],
        ),
      ),
    );
  }
}

class ValueScreen extends StatefulWidget {
  const ValueScreen({Key? key}) : super(key: key);

  @override
  State<ValueScreen> createState() => _ValueScreenState();
}

class _ValueScreenState extends State<ValueScreen> {
  final TextEditingController name = TextEditingController(
    text: 'ValuesAuthenticAndAspirational${formatTitelDate(DateTime.now())}',
  );

  RxList<TextEditingController> values = <TextEditingController>[].obs;
  RxList<TextEditingController> authenticity = <TextEditingController>[].obs;
  RxList<TextEditingController> importance = <TextEditingController>[].obs;

  RxInt selected = (-1).obs;

  addValue() {
    values.add(TextEditingController());
    authenticity.add(TextEditingController());
    importance.add(TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(
          leading: backButton(
            () => index.value == 0 ? Get.back() : previousIndex(),
          ),
          implyLeading: true,
        ),
        bottomNavigationBar: BottomButtons(
          button1: index.value == 0
              ? 'Continue'
              : index.value == 1
                  ? 'Final Review'
                  : 'Done',
          button2: 'Save',
          onPressed3: () => index.value != 0 ? previousIndex() : Get.back(),
          onPressed2: () async => await addJournal(true),
          onPressed1: index.value != 2
              ? () => updateIndex()
              : () async => edit ? await updateJournal() : await addJournal(),
        ),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: Column(
            children: [
              ExerciseTitle(
                title: 'Values, Authentic & Aspirational (Practice)',
                onPressed: () => Get.to(
                  () => ReadingScreen(
                    title: 'Go 99- Values: Authentic & Aspirational',
                    link:
                        'https://docs.google.com/document/d/12e5cPi3zDsC7O9FJXTdEpCI7ahdtAor2/',
                    linked: () => Get.back(),
                    function: () {
                      if (Get.find<GoalsController>().history.value.value ==
                          105) {
                        final end = DateTime.now();
                        Get.find<GoalsController>()
                            .updateHistory(end.difference(initial).inSeconds);
                      }
                      Get.log('closed');
                    },
                  ),
                ),
                // () => Get.to(() => const Go99Reading()),
              ).marginOnly(bottom: 10),
              JournalTop(
                controller: name,
                add: () => clearData(),
                drive: () => Get.off(() => const PreviousValues()),
                save: () async =>
                    edit ? await updateJournal(true) : await addJournal(true),
              ).marginOnly(bottom: 10),
              index.value == 0
                  ? page1()
                  : index.value == 1
                      ? page2()
                      : index.value == 2
                          ? page3()
                          : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget page3() {
    return Column(
      children: [
        titles('Final Review', alignment: Alignment.center)
            .marginOnly(bottom: 10),
        const TextWidget(
          text:
              'Congratulations, you have identified your most important value and taken a huge step forward in living an authentic and purposeful life. This can lead to huge boosts in happiness over the long term so pat yourself on the back. ',
          textAlign: TextAlign.justify,
        ).marginOnly(bottom: 20),
        const TextWidget(
          text:
              'Review your value and go back to edit any details if neccessary before finalizing your selection.',
          textAlign: TextAlign.justify,
          fontStyle: FontStyle.italic,
        ).marginOnly(bottom: 30),
        valuesTitle(),
        valueWidget(selected.value),
      ],
    );
  }

  Widget page2() {
    return Column(
      children: [
        titles('Final Values Selection', alignment: Alignment.center)
            .marginOnly(bottom: 10),
        const TextWidget(
          text:
              'Reduce your list of values to just one value that is the most important to you. This is the value that you want to live up to every day. The values that when lived up to will make you the kind of person you want to be and achieve the things that you want to achieve in life.\n*Click on the star next to the value to mark it as your most important value.*',
          weight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ).marginOnly(bottom: 10),
        const TextWidget(
          text:
              'If you are having trouble identifying your values answer one or all of the following questions. ',
          fontStyle: FontStyle.italic,
          weight: FontWeight.bold,
          color: Colors.grey,
        ).marginOnly(bottom: 20),
        valueQuestions('What do you value the most highly in this life? '),
        valueQuestions(
            'By what guiding principles do you (want to) live your life?'),
        valueQuestions(
          'If nothing was holding you back how would you carry yourself? How would you spend your time and why?',
        ),
        valueQuestions(
          'What would you want people to say at your eulogy about how you carried yourself and what you contributed?',
        ),
        valuesTitle(),
        Column(
          children: List.generate(values.length, (index) => valueWidget(index)),
        ),
      ],
    );
  }

  Widget page1() {
    return Column(
      children: [
        titles('Your Values', alignment: Alignment.center)
            .marginOnly(bottom: 5),
        valuesText(
          'Step 1: ',
          'Brainstorm and list your values under the column titled "Values List". List your 5 most important values. These values are the values you aspire to and don\'t necessarily have to be values you are currently living up to. ',
        ),
        valuesText(
          'Step 2: ',
          'Rate the value\'s importance to you personally in the second column from 1-10, with 1 meaning not important at all and 10 meaning extremely important to you). ',
        ),
        valuesText(
          'Step 3: ',
          'In the third column rate how closely you have lived up to this value based on your real life actions (be honest). Rate your Authenticity',
        ),
        const TextWidget(
          text:
              'If you are having trouble identifying your values answer one or all of the following questions. ',
          fontStyle: FontStyle.italic,
          weight: FontWeight.bold,
          color: Colors.grey,
        ).marginOnly(bottom: 20),
        valueQuestions('What do you value the most highly in this life? '),
        valueQuestions(
            'By what guiding principles do you (want to) live your life?'),
        valueQuestions(
          'If nothing was holding you back how would you carry yourself? How would you spend your time and why?',
        ),
        valueQuestions(
          'What would you want people to say at your eulogy about how you carried yourself and what you contributed?',
        ),
        valuesTitle(),
        Column(
          children: List.generate(values.length, (index) => valueWidget(index)),
        ),
      ],
    );
  }

  Widget valuesTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: index.value == 1 ? width * 0.5 : width * 0.55,
          child: TextWidget(
            text: index.value != 2 ? 'Values List' : 'Your Top Value',
            fontStyle: FontStyle.italic,
            weight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: width * 0.13,
              child: const TextWidget(text: 'Importance', maxline: 2),
            ),
            SizedBox(
              width: width * 0.15,
              child: const TextWidget(text: 'Authenticity', maxline: 2),
            ),
            if (index.value == 1) SizedBox(width: width * 0.13),
          ],
        ),
      ],
    ).marginOnly(bottom: 10);
  }

  Widget valueWidget(int indx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: index.value == 1 ? width * 0.49 : width * 0.6,
          child: TextFormField(
            controller: values[indx],
            decoration: inputDecoration(hint: 'Value'),
          ),
        ),
        SizedBox(
          width: width * 0.15,
          child: TextFormField(
            controller: importance[indx],
            decoration: inputDecoration(hint: '6'),
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          width: width * 0.15,
          child: TextFormField(
            controller: authenticity[indx],
            decoration: inputDecoration(hint: '10'),
            keyboardType: TextInputType.number,
          ),
        ),
        if (index.value == 1)
          IconButton(
            onPressed: () {
              setState(() {
                selected.value = indx;
              });
            },
            icon: indx == selected.value
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border),
          ),
      ],
    ).marginOnly(bottom: 10);
  }

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;
  previousIndex() => index.value = index.value - 1;

  clearValue() {
    values.clear();
    authenticity.clear();
    importance.clear();
    selected.value = -1;
  }

  clearData() {
    index.value = 0;
    clearValue();
    _valuesModel.value = ValuesModel(
      id: generateId(),
      userid: Get.find<AuthServices>().userid,
    );
  }

  final bool edit = Get.arguments[0];
  final Rx<ValuesModel> _valuesModel = ValuesModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _valuesModel.value.name = name.text;
    _valuesModel.value.value = values[selected.value].text;
    _valuesModel.value.importance = importance[selected.value].text.isEmpty
        ? 0.0
        : double.parse(importance[selected.value].text);
    _valuesModel.value.authenticity = authenticity[selected.value].text.isEmpty
        ? 0.0
        : double.parse(authenticity[selected.value].text);
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _valuesModel.value.duration = _valuesModel.value.duration! + diff;
    } else {
      _valuesModel.value.duration = diff;
    }
  }

  fetchData() {
    _valuesModel.value = Get.arguments[1] as ValuesModel;
    name.text = _valuesModel.value.name!;
    clearValue();
    addValue();
    values[0].text = _valuesModel.value.value!;
    importance[0].text = _valuesModel.value.importance!.toString();
    authenticity[0].text = _valuesModel.value.authenticity!.toString();
  }

  Future addJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    if (edit) _valuesModel.value.id = generateId();
    await goalsRef.doc(_valuesModel.value.id).set(_valuesModel.value.toMap());
    await addAccomplishment(end);
    Get.back();
    if (!fromsave) {
      if (Get.find<GoalsController>().history.value.value == 106) {
        Get.find<GoalsController>()
            .updateHistory(end.difference(initial).inSeconds);
      }
      Get.back();
    }
    customToast(message: 'Added successfully');
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == goals);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: name.text,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _valuesModel.value.id,
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
    await goalsRef
        .doc(_valuesModel.value.id)
        .update(_valuesModel.value.toMap());
    Get.back();
    if (!fromsave) Get.back();
    customToast(message: 'Updated successfully');
  }

  @override
  void initState() {
    setState(() {
      for (int i = 0; i < 5; i++) {
        addValue();
      }
      if (edit) fetchData();
    });
    super.initState();
  }
}

class PreviousValues extends StatelessWidget {
  const PreviousValues({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Values, Authentic & Aspirational',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: goalsRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 4)
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
              final ValuesModel model =
                  ValuesModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const ValueScreen(),
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

class GoalsSettingScreen extends StatefulWidget {
  const GoalsSettingScreen({Key? key}) : super(key: key);

  @override
  State<GoalsSettingScreen> createState() => _GoalsSettingScreenState();
}

class _GoalsSettingScreenState extends State<GoalsSettingScreen> {
  TextEditingController name = TextEditingController(
    text: 'GoalSettingAndDeepestWhys${formatTitelDate(DateTime.now())}',
  );

  List<TextEditingController> goals = <TextEditingController>[].obs;
  RxInt selected = 0.obs;
  Rx<ValuesModel> values = ValuesModel(value: 'Select Value', id: '').obs;
  TextEditingController measure = TextEditingController();
  TextEditingController complete = TextEditingController();
  TextEditingController important = TextEditingController();
  TextEditingController deepestWhys = TextEditingController();
  RxList<TextEditingController> aboveAnswers = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ].obs;

  addgoals() {
    for (int i = 0; i < 3; i++) {
      goals.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: customAppbar(
            leading: backButton(
              () => index.value == 0 ? Get.back() : previousIndex(),
            ),
            implyLeading: true,
          ),
          bottomNavigationBar: BottomButtons(
            button2: 'Save',
            button1: index.value == 3
                ? 'Final Review'
                : index.value == 4
                    ? 'Done'
                    : 'Continue',
            onPressed1: index.value != 4
                ? () {
                    if (index.value == 3) {
                      deepestWhys.text = aboveAnswers[4].text;
                    }
                    updateIndex();
                  }
                : () async => edit ? await updateGoal() : await addGoal(),
            onPressed2: () async => await addGoal(true),
            onPressed3: () => index.value != 0 ? previousIndex() : Get.back(),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
              left: 15,
              right: 15,
            ),
            child: Column(
              children: [
                ExerciseTitle(
                  title: 'Goal Setting & Deepest Why\'s',
                  onPressed: () => Get.to(
                    () => ReadingScreen(
                      title: 'Go100- Goals Setting and Your Deepest Why\'s ',
                      link:
                          'https://docs.google.com/document/d/1XBRFh4ahttXdWvy4i6COPqGVtM_mJ8fl/',
                      linked: () => Get.back(),
                      function: () {
                        if (Get.find<GoalsController>().history.value.value ==
                            108) {
                          final end = DateTime.now();
                          Get.find<GoalsController>()
                              .updateHistory(end.difference(initial).inSeconds);
                        }
                        Get.log('closed');
                      },
                    ),
                  ),
                  // () => Get.to(() => const Go100Reading()),
                ).marginOnly(bottom: 10),
                JournalTop(
                  controller: name,
                  add: () => clearData(),
                  save: () async =>
                      edit ? await updateGoal(true) : addGoal(true),
                  drive: () => Get.off(() => const PreviousGoalSetting()),
                ).marginOnly(bottom: 10),
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

  Widget page5() {
    return Column(
      children: [
        titles(
          'Your Most Important Goals & Deepest Why\'s',
          alignment: Alignment.center,
        ).marginOnly(bottom: 10),
        TextFormField(
          controller: goals[selected.value],
          decoration: inputDecoration(
            hint: 'Goal (autofilled from last page)',
          ),
        ),
        TextFormField(
          readOnly: true,
          controller: complete,
          keyboardType: TextInputType.datetime,
          decoration: inputDecoration(
            hint: 'When will I complete this goal? (autofilled)',
          ),
          onTap: () async {
            await customDatePicker(
              context,
              initialDate: complete.text.isEmpty
                  ? DateTime.now()
                  : dateFromString(complete.text),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            ).then((value) {
              complete.text = formateDate(value);
            });
          },
        ),
        TextFormField(
          controller: measure,
          // keyboardType: TextInputType.number,
          decoration: inputDecoration(
            hint: 'How can I measure completion numerically? (autofilled)',
          ),
        ),
        TextFormField(
          controller: deepestWhys,
          decoration: inputDecoration(
            hint: 'What is my deepest why for completing this goal?',
          ),
        ),
        valuedropdown(),
      ],
    );
  }

  Widget page4() {
    return Column(
      children: [
        titles('Deepest Why\'s', alignment: Alignment.center)
            .marginOnly(bottom: 10),
        const TextWidget(
          text:
              'Grit is what keeps you going in tough times. Grit is that fire inside that pulls you up when you fall down and are broken and battered. By finding and defining your deepest motivations you are providing yourself with the ammo to dig deep and access the grit needed to change your life.',
          fontStyle: FontStyle.italic,
        ).marginOnly(bottom: 10),
        page4GoalWidget(),
      ],
    );
  }

  Widget page4GoalWidget() {
    return Column(
      children: [
        TextFormField(
          controller: goals[selected.value],
          decoration: inputDecoration(
            hint: 'Goal (autofilled from last page)',
          ),
        ),
        TextFormField(
          controller: important,
          decoration: inputDecoration(
            hint:
                'Why is completing this goal important to me? (autofilled from last page)',
          ),
        ),
        Column(
          children: List.generate(
            aboveAnswers.length,
            (index) => TextFormField(
              controller: aboveAnswers[index],
              decoration: inputDecoration(
                hint: 'Why is the “above answer” important to me?',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget page3() {
    return Column(
      children: [
        titles('How, When, & Why', alignment: Alignment.center)
            .marginOnly(bottom: 10),
        const TextWidget(
          text:
              'If you want to realistically finish your goal you need a way to measure your project\'s progress and your project\'s completion numerically . Even more importantly, you need a reason that sets you on fire with purpose so you don\'t waiver when things get tough.',
          fontStyle: FontStyle.italic,
        ).marginOnly(bottom: 10),
        const TextWidget(
          text: 'Identify a:',
          fontStyle: FontStyle.italic,
        ).marginOnly(bottom: 30),
        const TextWidget(
          text: '- Deadline',
          fontStyle: FontStyle.italic,
          weight: FontWeight.bold,
        ),
        valueQuestions(
          'How long has it taken others to reach similar goals? ',
        ),
        valueQuestions(
          'What is a realistic completion date given my resources (time, money, knowledge, prior experience, people, etc.)?',
        ),
        const TextWidget(
          text: '- Why to measure goal completion with hard numbers',
          weight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ).marginOnly(top: 10),
        valueQuestions(
          'What does success mean to you and how can you measure it?',
        ),
        valueQuestions(
          'How much do I need to increase/ decrease something (kilograms, dollars, sales, friends, emotional outbursts) to reach my goal?',
        ),
        const TextWidget(
          text: '- Motivation for completing the goal',
          weight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ).marginOnly(top: 10),
        valueQuestions(
          'What is the driving force behind reaching this goal? Does this motivation align with my values?',
        ),
        const TextWidget(text: 'Top Goal', weight: FontWeight.bold)
            .marginOnly(bottom: 10, top: 15),
        page3GoalWidget(),
      ],
    );
  }

  Widget page3GoalWidget() {
    return Column(
      children: [
        TextFormField(
          controller: goals[selected.value],
          decoration: inputDecoration(hint: 'Goal'),
        ),
        TextFormField(
          readOnly: true,
          controller: complete,
          keyboardType: TextInputType.datetime,
          decoration: inputDecoration(
            hint: 'When will I complete this goal (MM/DD/YY)',
          ),
          onTap: () async {
            await customDatePicker(
              context,
              initialDate: complete.text.isEmpty
                  ? DateTime.now()
                  : dateFromString(complete.text),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            ).then((value) {
              complete.text = formateDate(value);
            });
          },
        ),
        TextFormField(
          controller: measure,
          // keyboardType: TextInputType.number,
          decoration: inputDecoration(
            hint: 'How can I measure completion numerically?',
          ),
        ),
        TextFormField(
          controller: important,
          decoration: inputDecoration(
            hint: 'Why is completing this goal important to me?',
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
              'Choose one goal from your most important goals list and eliminate all the others from your mind. Choose the goal that fits with your values and long-term vision. Choose at least one value that your goal will help you live up to. ',
          fontStyle: FontStyle.italic,
          textAlign: TextAlign.justify,
        ).marginOnly(bottom: 20),
        const TextWidget(
          text:
              'If you are having trouble identifying your goals answer one or all of the following questions. ',
          weight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        valueQuestions(
          'Which outcomes are crucial to your vision for your life and future self?',
          fromgoal: true,
        ),
        valueQuestions('Which goal could you not live without? ',
            fromgoal: true),
        valueQuestions(
          'Which goal aligns most closely with your values?',
          fromgoal: true,
        ),
        const TextWidget(text: 'Top Goal', weight: FontWeight.bold)
            .marginOnly(top: 20, bottom: 10),
        goaldropdown(),
        valuedropdown(),
      ],
    );
  }

  Widget valuedropdown() {
    return valuesList.isEmpty
        ? Container()
        : CustomDropDownStruct(
            child: DropdownButton(
              value: values.value.id,
              onChanged: (val) {
                setState(() {
                  values.value = valuesList.where((p0) => p0.id == val).first;
                });
              },
              items: valuesList.map(
                (e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: SizedBox(
                      width: width * 0.8,
                      child: TextWidget(
                        text: e.value!.toString(),
                        alignment: Alignment.centerLeft,
                        maxline: 2,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ).marginOnly(bottom: 5);
  }

  Widget goaldropdown() {
    return CustomDropDownStruct(
      child: DropdownButton(
        value: selected.value,
        onChanged: (val) => selected.value = val,
        items: ((goals.where((e) => e.text.isEmpty).toList().length ==
                    goals.length)
                ? <TextEditingController>[
                    TextEditingController(text: 'Choose Goal')
                  ]
                : goals)
            .map(
              (e) => DropdownMenuItem(
                value: ((goals.where((e) => e.text.isEmpty).toList().length ==
                            goals.length)
                        ? <TextEditingController>[
                            TextEditingController(text: 'Choose Goal')
                          ]
                        : goals)
                    .indexWhere(
                  (element) => element.text == e.text,
                ),
                child: SizedBox(
                  width: width * 0.8,
                  child: TextWidget(
                    text: e.text,
                    alignment: Alignment.centerLeft,
                    maxline: 2,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    ).marginOnly(bottom: 5);
  }

  Widget page1() {
    return Column(
      children: [
        const TextWidget(
          text:
              'Start by writing down your goals. These are massive goals that will change your life and get you fired up. Write at least 3 and a maximum of 5. ',
          textAlign: TextAlign.justify,
          fontStyle: FontStyle.italic,
        ).marginOnly(bottom: 10),
        const TextWidget(
          text:
              'If you are having trouble identifying your goals answer one or all of the following questions. ',
          weight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ).marginOnly(bottom: 5),
        valueQuestions(
          'If you had no impediments and could be exactly who you wanted to be what would your life look like?',
          fromgoal: true,
        ),
        valueQuestions(
          'What is your ideal lifestyle? How can you live it?',
          fromgoal: true,
        ),
        valueQuestions(
          'If you didn\'t care what other people thought what would you do everyday?',
          fromgoal: true,
        ),
        valueQuestions(
          'What do you want financially, spiritually, and romanticly?',
          fromgoal: true,
        ),
        valueQuestions('What are your dreams for the future?', fromgoal: true),
        const TextWidget(text: 'Goal List', weight: FontWeight.bold)
            .marginOnly(bottom: 5),
        Column(
          children: List.generate(
            goals.length,
            (index) => goalListWidget(index),
          ),
        ),
        CustomIconTextButton(
          text: 'Add Goal',
          onPressed: () {
            setState(() {
              goals.add(TextEditingController());
            });
          },
        ),
      ],
    );
  }

  Widget goalListWidget(int indx) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(text: '${indx + 1})', size: 17).marginOnly(right: 7),
        SizedBox(
          width: width * 0.85,
          child: TextFormField(
            controller: goals[indx],
            decoration: inputDecoration(hint: 'Goal'),
          ),
        ),
      ],
    ).marginOnly(bottom: 7);
  }

  clearData() {
    index.value = 0;
    _goals.value = GoalsModel(
      id: generateId(),
      userid: Get.find<AuthServices>().userid,
    );
    selected.value = -1;
    goals.clear();
    measure.clear();
    complete.clear();
    aboveAnswers.clear();
    deepestWhys.clear();
    important.clear();
    values.value = ValuesModel(value: 'Select Value', id: '');
  }

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;
  previousIndex() => index.value = index.value - 1;

  final bool edit = Get.arguments[0];
  final Rx<GoalsModel> _goals = GoalsModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  RxList<ValuesModel> valuesList =
      <ValuesModel>[ValuesModel(value: 'Select Value', id: '')].obs;
  Future fetchValues() async {
    await goalsRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 4)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          valuesList.add(ValuesModel.fromMap(doc));
        }
      }
    }).whenComplete(() {
      // print(valuesList);
      if (edit) fetchData();
    });
  }

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _goals.value.name = name.text;
    _goals.value.aboveAnswerImportant = [];
    for (int i = 0; i < aboveAnswers.length; i++) {
      _goals.value.aboveAnswerImportant!.add(aboveAnswers[i].text);
    }
    _goals.value.goal = goals[selected.value].text;
    _goals.value.complete = complete.text;
    _goals.value.deepestWhys = deepestWhys.text;
    _goals.value.importance = important.text;
    _goals.value.measureNumerically = measure.text;
    _goals.value.valueid = values.value.id!;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _goals.value.duration = _goals.value.duration! + diff;
    } else {
      _goals.value.duration = diff;
    }
  }

  fetchData() {
    _goals.value = Get.arguments[1] as GoalsModel;
    name.text = _goals.value.name!;
    for (int i = 0; i < _goals.value.aboveAnswerImportant!.length; i++) {
      aboveAnswers[i].text = _goals.value.aboveAnswerImportant![i];
    }
    goals.clear();
    goals.add(TextEditingController(text: _goals.value.goal!));
    selected.value = 0;
    complete.text = _goals.value.complete!;
    deepestWhys.text = _goals.value.deepestWhys!;
    important.text = _goals.value.importance!;
    measure.text = _goals.value.measureNumerically!.toString();
    values.value =
        valuesList.where((p0) => p0.id == _goals.value.valueid).first;
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == 'goals');
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: name.text,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _goals.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addGoal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    if (edit) _goals.value.id = generateId();
    await goalsRef.doc(_goals.value.id).set(_goals.value.toMap());
    await addAccomplishment(end);
    Get.back();
    if (!fromsave) {
      if (Get.find<GoalsController>().history.value.value == 109) {
        Get.find<GoalsController>()
            .updateHistory(end.difference(initial).inSeconds);
      }
      Get.back();
    }
    customToast(message: 'Added successfully');
  }

  Future updateGoal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    await goalsRef.doc(_goals.value.id).update(_goals.value.toMap());
    Get.back();
    if (!fromsave) Get.back();
    customToast(message: 'Updated successfully');
  }

  @override
  void initState() {
    setState(() {
      addgoals();
      fetchValues();
    });
    super.initState();
  }
}

class PreviousGoalSetting extends StatelessWidget {
  const PreviousGoalSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Goal Setting & Your Deepest Why\'',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: goalsRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 5)
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
              final GoalsModel model =
                  GoalsModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const GoalsSettingScreen(),
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

class RoadmapScreen extends StatefulWidget {
  const RoadmapScreen({Key? key}) : super(key: key);

  @override
  State<RoadmapScreen> createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  TextEditingController name = TextEditingController(
    text: 'CreatingASystemRoadmap${formatTitelDate(DateTime.now())}',
  );

  Rx<GoalsModel> goal = GoalsModel(goal: 'Choose Goal', id: '').obs;
  TextEditingController measuregoal = TextEditingController();
  TextEditingController completegoal = TextEditingController();
  RxList<List<TextEditingController>> habits = <List<TextEditingController>>[
    <TextEditingController>[TextEditingController()],
  ].obs;

  RxList<TextEditingController> milestones = <TextEditingController>[].obs;
  RxList<TextEditingController> measuremilestone =
      <TextEditingController>[].obs;
  RxList<TextEditingController> completemilestone =
      <TextEditingController>[].obs;

  void addmilestone() {
    milestones.add(TextEditingController());
    measuremilestone.add(TextEditingController());
    completemilestone.add(TextEditingController());
    habits.add([TextEditingController()]);
  }

  void addHabits(int index) {
    habits[index].add(TextEditingController());
  }

  RxInt selectParent = (-1).obs;
  RxInt selectedHabit = (-1).obs;

  void setHabit() {
    _habit.value = SystemHabit(
      name: habits[selectParent.value][selectedHabit.value].text,
      complete: false,
      days: [false, false, false, false, false, false, false],
      duration: PHabitDuration(start: '', end: '', duration: '', seconds: 0),
      nudge: NudgeModel(
        alarm: 0,
        reward: 0,
        cue: 0,
        setups: '',
        chain: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(
          leading: backButton(
            () => index.value == 0 ? Get.back() : previousIndex(),
          ),
          implyLeading: true,
        ),
        bottomNavigationBar: index.value == 0 || index.value == 2
            ? SizedBox(
                height: 50,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.last_page_outlined),
                    onPressed: () {
                      updateIndex();
                    },
                  ),
                ),
              )
            : BottomButtons(
                button1: index.value == 1
                    ? 'Final Review'
                    : index.value == 3 || index.value == 4
                        ? 'Continue'
                        : 'Done',
                button2: 'Save',
                onPressed2: () async => await addJournal(true),
                onPressed3: () =>
                    index.value != 0 ? previousIndex() : Get.back(),
                onPressed1:
                    index.value == 1 || index.value == 3 || index.value == 4
                        ? () {
                            if (index.value == 1) {
                              print(index.value);
                              for (int i = 0; i < milestones.length; i++) {
                                sortByDateAscending(i);
                              }
                            }
                            updateIndex();
                          }
                        : () async =>
                            edit ? await updateJournal() : await addJournal(),
              ),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: Column(
            children: [
              ExerciseTitle(
                title: 'Creating a System: Roadmap (Practice)',
                onPressed: () => Get.to(
                  () => ReadingScreen(
                    title: 'G0101- Creating a Roadmap & System',
                    link:
                        'https://docs.google.com/document/d/1qGvSLsdFlhnNaS441cac0YpD2p9rxGEx/',
                    linked: () => Get.back(),
                    function: () {
                      if (Get.find<GoalsController>().history.value.value ==
                          111) {
                        final end = DateTime.now();
                        Get.find<GoalsController>()
                            .updateHistory(end.difference(initial).inSeconds);
                      }
                      Get.log('closed');
                    },
                  ),
                ),
                //  () => Get.to(() => const Go101Reading()),
              ).marginOnly(bottom: 10),
              JournalTop(
                controller: name,
                add: () => clearData(),
                drive: () => Get.off(() => const PreviousRoadmap()),
                save: () async =>
                    edit ? await updateJournal(true) : await addJournal(true),
              ).marginOnly(bottom: 10),
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
      ),
    );
  }

  RxBool habit = false.obs;
  final RxBool _duration = false.obs;
  final RxBool _nudge = false.obs;
  final RxBool _nudges = true.obs;

  Widget page6() {
    return Column(
      children: [
        Column(
          children: [
            titles('Foolproof Your Habits').marginOnly(bottom: 20),
            const TextWidget(
              text:
                  'This is your ticket to turning to regular activities into systems. By incorporating behavioral design you can turn any group of activities into lifelong habits. When those lifelong habits move you towards your most important goals and values each day you begin creating unstoppable momentum towards your best life. ',
              fontStyle: FontStyle.italic,
            ).marginOnly(bottom: 25),
            const TextWidget(
              text:
                  'In the next and final step, you will apply behavioral psychology techniques to bypass willpower and procrastination creating lifelong habits.',
              size: 16,
            ).marginOnly(bottom: 10),
            const TextWidget(
              text:
                  'Using the techniques described in the Behavioral Design 101 lesson we will design a path of least resistance for your habit to maximize your chances of following through. We’ll make sure you show up day after day and  week after week to do the simple work that leads to reaching your goal and living by your values. ',
            ),
          ],
        ).marginOnly(left: 10, right: 10, top: 20, bottom: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: _habit.value.name,
              decoration: inputDecoration(
                hint: 'Habit/ Recurring Activity (autofilled)',
              ),
              onChanged: (val) => setState(() => _habit.value.name = val),
            ),
            Row(
              children: [
                // Checkbox(
                //   value: _duration.value,
                //   onChanged: (val) => _duration.value = val!,
                //   visualDensity: VisualDensity.compact,
                // ),
                Container(
                  width: width * 0.277,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all()),
                  child: DateWidget(
                    date: _habit.value.duration!.start == ''
                        ? 'Start Time'
                        : _habit.value.duration!.start!,
                    ontap: () async {
                      await customTimePicker(
                        context,
                        initialTime: _habit.value.duration!.start == ''
                            ? TimeOfDay.now()
                            : getTimeFromString(_habit.value.duration!.start!),
                      ).then((value) {
                        _habit.value.duration!.start = value.format(context);
                        setState(() {});
                      });
                    },
                  ),
                ),
                Container(
                  width: width * 0.277,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all()),
                  child: DateWidget(
                    date: _habit.value.duration!.end == ''
                        ? 'End Time'
                        : _habit.value.duration!.end!,
                    ontap: () async {
                      await customTimePicker(
                        context,
                        initialTime: _habit.value.duration!.end == ''
                            ? TimeOfDay.now()
                            : getTimeFromString(_habit.value.duration!.end!),
                      ).then((value) {
                        if (value != null && checkTime(value)) {
                          _habit.value.duration!.end = value.format(context);
                          getDuration(value);
                        } else {
                          customToast(
                              message:
                                  'End Time should be greater than start time');
                        }
                        setState(() {});
                      });
                    },
                  ),
                ),
                Container(
                  width: width * 0.277,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(border: Border.all()),
                  child: DateWidget(
                    date: _habit.value.duration!.duration == ''
                        ? 'HH:MM:SS'
                        : _habit.value.duration!.duration!,
                    ontap: () async {
                      await customDurationPicker(
                        initialMinutes: _habit.value.duration!.seconds!,
                      ).then((value) {
                        _habit.value.duration!.seconds = value!.inSeconds;
                        _habit.value.duration!.duration =
                            getDurationString(value.inSeconds);
                        setEndTime();
                        setState(() {});
                      });
                    },
                  ),
                ),
              ],
            ),
            CheckBoxRows(
              titles: dayNames,
              values: _habit.value.days!,
              size: 55,
              titleAlignment: Alignment.centerLeft,
            ).marginOnly(bottom: 10),
            // CustomCheckBox(
            //   value: _nudge.value,
            //   onChanged: (val) => _nudge.value = val,
            //   title: 'Nudges',
            //   titleWeight: FontWeight.bold,
            //   width: 120,
            // ),
            CustomCheckBox(
              width: width,
              value: _duration.value,
              onChanged: (val) => _duration.value = val!,
              title: 'Add to Calendar',
              titleWeight: FontWeight.bold,
            ),
            nudgeWidget(
              'Alarm',
              list: alarmSoundList,
              value: _habit.value.nudge!.alarm!,
              onchanged: (val) {
                setState(() {
                  _habit.value.nudge!.alarm = val;
                });
              },
            ),
            nudgeWidget(
              'Cue',
              list: cueList,
              value: _habit.value.nudge!.cue!,
              onchanged: (val) {
                setState(() {
                  _habit.value.nudge!.cue = val;
                });
              },
            ),
            if (_habit.value.nudge!.cue == 3)
              SizedBox(
                width: width * 0.6,
                child: TextFormField(
                  initialValue: _habit.value.nudge!.cueWritein,
                  onChanged: (val) => setState(() {
                    _habit.value.nudge!.cueWritein = val;
                  }),
                  decoration: inputDecoration(hint: 'Write in...'),
                ),
              ).marginOnly(left: width * 0.2),
            nudgeWidget(
              'Chain',
              list: chainList,
              value: _habit.value.nudge!.chain!,
              onchanged: (val) {
                setState(() {
                  _habit.value.nudge!.chain = val;
                });
              },
            ),
            if (_habit.value.nudge!.chain == 0)
              SizedBox(
                width: width * 0.6,
                child: TextFormField(
                  initialValue: _habit.value.nudge!.chainWritein,
                  onChanged: (val) => setState(() {
                    _habit.value.nudge!.chainWritein = val;
                  }),
                  decoration: inputDecoration(hint: 'Write in...'),
                ),
              ).marginOnly(left: width * 0.2),
            nudgeWidget(
              'Reward',
              list: rewardList,
              value: _habit.value.nudge!.reward!,
              onchanged: (val) {
                setState(() {
                  _habit.value.nudge!.reward = val;
                });
              },
            ),
            if (_habit.value.nudge!.reward == 8)
              SizedBox(
                width: width * 0.6,
                child: TextFormField(
                  initialValue: _habit.value.nudge!.rewardWritein,
                  onChanged: (val) => setState(() {
                    _habit.value.nudge!.rewardWritein = val;
                  }),
                  decoration: inputDecoration(hint: 'Write in...'),
                ),
              ).marginOnly(left: width * 0.2),
            nudgeWidget(
              'Set Up',
              setup: true,
              onchanged: (val) {
                setState(() {
                  _habit.value.nudge!.setups = val;
                });
              },
            ),
          ],
        ).marginOnly(left: 15, right: 15, top: 20),
      ],
    );
  }

  Widget nudgeWidget(
    String title, {
    List<AppModel>? list,
    var onchanged,
    bool setup = false,
    int? value,
  }) {
    return Row(
      children: [
        SizedBox(width: width * 0.2, child: TextWidget(text: title)),
        SizedBox(
          width: width * 0.6,
          child: setup
              ? TextFormField(
                  decoration: inputDecoration(
                    hint: 'Prepare clothes, files for work',
                  ),
                  onChanged: onchanged,
                )
              : CustomDropDownStruct(
                  child: DropdownButton(
                    value: value,
                    onChanged: onchanged,
                    items: list!
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.value,
                            child: SizedBox(
                              width: width * 0.4,
                              child: TextWidget(
                                text: e.title,
                                alignment: Alignment.centerLeft,
                                maxline: 2,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
        ),
      ],
    );
  }

  setEndTime() {
    var _startTime = getTimeFromString(_habit.value.duration!.start!);
    var end = getTimeFromString(_habit.value.duration!.end!);
    DateTime _today = DateTime.now();
    DateTime _startdate = DateTime(
      _today.year,
      _today.month,
      _today.day,
      _startTime.hour,
      _startTime.minute,
    );
    DateTime _endDate = DateTime(
      _today.year,
      _today.month,
      _today.day,
      end.hour,
      end.minute,
    );
    int _duration = _endDate.difference(_startdate).inSeconds;
    if (_duration != _habit.value.duration!.seconds!) {
      _endDate =
          _startdate.add(Duration(seconds: _habit.value.duration!.seconds!));
      _habit.value.duration!.end =
          TimeOfDay(hour: _endDate.hour, minute: _endDate.minute)
              .format(context);
    }
    setState(() {});
  }

  bool checkTime(TimeOfDay end) {
    var _startTime = getTimeFromString(_habit.value.duration!.start!);
    DateTime _today = DateTime.now();
    DateTime _startdate = DateTime(
      _today.year,
      _today.month,
      _today.day,
      _startTime.hour,
      _startTime.minute,
    );
    DateTime _endDate = DateTime(
      _today.year,
      _today.month,
      _today.day,
      end.hour,
      end.minute,
    );
    return _endDate.isAfter(_startdate);
  }

  getDuration(TimeOfDay end) {
    var _startTime = getTimeFromString(_habit.value.duration!.start!);
    DateTime _today = DateTime.now();
    DateTime _startdate = DateTime(
      _today.year,
      _today.month,
      _today.day,
      _startTime.hour,
      _startTime.minute,
    );
    DateTime _endDate = DateTime(
      _today.year,
      _today.month,
      _today.day,
      end.hour,
      end.minute,
    );
    _habit.value.duration!.seconds = _endDate.difference(_startdate).inSeconds;
    _habit.value.duration!.duration =
        getDurationString(_habit.value.duration!.seconds!);
    setState(() {});
  }

  Widget page5() {
    return Column(
      children: [
        titles('Choosing your habit'.capitalize!).marginOnly(bottom: 10),
        const TextWidget(
          text:
              'Choose one habit from your list. This is the key habit that will make it impossible not to steadily stride towards achieving your goal and living up to your values. Use the below criteria to help you choose a habit.',
          fontStyle: FontStyle.italic,
        ).marginOnly(bottom: 20),
        TextWidget(text: 'Does your habit?'.capitalize!).marginOnly(bottom: 10),
        valueQuestions(
          'Show up repeatedly in your research from reputable sources',
          icondata: ThrivingIcons.user_check,
        ),
        valueQuestions(
          'Resonate with your personality or particularly jump out at you',
          icondata: ThrivingIcons.user_check,
        ),
        valueQuestions(
          'Provide huge long term benefits',
          icondata: ThrivingIcons.user_check,
        ),
        valueQuestions(
          'Fit into your life and schedule easily',
          icondata: ThrivingIcons.user_check,
        ),
        valueQuestions(
          'Provide or develop essential skills to reaching your goal',
          icondata: ThrivingIcons.user_check,
        ),
        valueQuestions(
          'Incrementally improve your most important core skills',
          icondata: ThrivingIcons.user_check,
        ),
        valueQuestions(
          'Develop you into the person you need to be to complete your goal',
          icondata: ThrivingIcons.user_check,
        ),
        valueQuestions(
          'If practiced regularly will practically guarantee you reach your goal',
          icondata: ThrivingIcons.user_check,
        ),
        valueQuestions(
          'Provided value for others attempting to achieve the same or similar goals',
          icondata: ThrivingIcons.user_check,
        ),
        valueQuestions(
          'Push you outside of your comfort zone',
          icondata: ThrivingIcons.user_check,
        ),
        valueQuestions('Give you an edge', icondata: ThrivingIcons.user_check),
        valueQuestions(
          'Set you aside from the rest',
          icondata: ThrivingIcons.user_check,
        ),
        if (selectParent.value != -1 && selectedHabit.value != -1)
          page4habitsWidget(selectParent.value, selectedHabit.value, 1),
      ],
    );
  }

  Widget page4() {
    return Column(
      children: [
        titles('System Activities: Roadmap', alignment: Alignment.center)
            .marginOnly(bottom: 10),
        const TextWidget(
          text:
              'Amazing work getting this far! You now should have a long list of potential recurring activities to incorporate into your custom system for success. Check them out below, revel in your progress and know you have made huge strides forward. ',
        ).marginOnly(bottom: 20),
        Column(
          children: List.generate(
            habits.length,
            (parent) => Column(
              children: List.generate(
                habits[parent].length,
                (index) {
                  if (!updated.value) _habitindex.value = _habitindex.value + 1;
                  if (parent == habits.length - 1) updated.value = true;

                  return page4habitsWidget(
                    parent,
                    index,
                    parent == 0
                        ? index + 1
                        : ((parent + parent - 1) + (index + 1)),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  final RxInt _habitindex = 0.obs;
  final RxBool updated = false.obs;

  Widget page4habitsWidget(int parent, int child, int index) {
    return Row(
      children: [
        // TextWidget(text: '$index)', weight: FontWeight.bold),
        SizedBox(
          width: width * 0.735,
          child: TextFormField(
            controller: habits[parent][child],
            decoration:
                inputDecoration(hint: 'Habit/Recurring Activity (autofilled)'),
          ),
        ),
        IconButton(
          onPressed: () {
            selectParent.value = parent;
            selectedHabit.value = child;
            setHabit();
            setState(() {});
          },
          icon: selectParent.value == parent && selectedHabit.value == child
              ? const Icon(Icons.star)
              : const Icon(Icons.star_border),
        ),
      ],
    );
  }

  Widget page3() {
    return Column(
      children: [
        titles(
          'Your Timeline & Roadmap',
          alignment: Alignment.center,
        ).marginOnly(bottom: 10),
        const TextWidget(
          text:
              'You should now have a step by step plan with deadlines and numeric measures of completion. You know the exact steps you will take to reach your goal. You even have a timeline to refer to as a guide to keep you on track and as a way to measure your progress going forward. ',
        ).marginOnly(bottom: 20),
        Column(
          children: List.generate(
            (milestones).length,
            (index) => page3RoadmapWidget(index),
          ),
        ),
        page3GoalWidget(),
      ],
    );
  }

  Widget page3RoadmapWidget(int index) {
    return Column(
      children: [
        TextFormField(
          controller: milestones[index],
          decoration: inputDecoration(
              hint: 'Milestone with closest deadline to current date?'),
        ),
        TextFormField(
          readOnly: true,
          controller: completemilestone[index],
          decoration: inputDecoration(
            hint: 'When will I complete this milestone?',
          ),
          onTap: () async {
            await customDatePicker(
              context,
              initialDate: completemilestone[index].text.isEmpty
                  ? DateTime.now()
                  : dateFromString(completemilestone[index].text),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            ).then((value) {
              completemilestone[index].text = formateDate(value);
              sortByDate(index);
            });
          },
        ),
        TextFormField(
          controller: measuremilestone[index],
          keyboardType: TextInputType.number,
          decoration: inputDecoration(
            hint: 'How can I measure milestone completion numerically?',
          ),
        ),
        const SizedBox(height: 30, child: VerticalDivider(thickness: 3.0)),
      ],
    );
  }

  Widget page3GoalWidget() {
    return Column(
      children: [
        TextFormField(
          readOnly: true,
          initialValue: goal.value.goal!,
          decoration: inputDecoration(hint: 'Goal (Autofilled)'),
        ),
        TextFormField(
          readOnly: true,
          controller: completegoal,
          decoration: inputDecoration(
            hint: 'When will I complete this milestone? (autofilled)',
          ),
        ),
        TextFormField(
          controller: measuregoal,
          // keyboardType: TextInputType.number,
          decoration: inputDecoration(
            hint: 'How can I measure completion numerically? (autofilled)',
          ),
        ),
      ],
    );
  }

  Widget page2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title2('Create your Roadmap Now!').marginOnly(bottom: 10),
        roadmapGoalWidget(),
        Column(
          children: List.generate(
            milestones.length,
            (index) => milestoneWidget(index),
          ),
        ),
      ],
    );
  }

  Widget milestoneWidget(int indx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width * 0.6,
          child: Column(
            children: [
              TextFormField(
                controller: milestones[indx],
                decoration: inputDecoration(hint: 'Milestone'),
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.3,
                    child: TextFormField(
                      readOnly: true,
                      controller: completemilestone[indx],
                      decoration: inputDecoration(
                        hint: 'When will I complete this milestone?',
                      ),
                      onTap: () async {
                        await customDatePicker(
                          context,
                          initialDate: completemilestone[indx].text.isEmpty
                              ? DateTime.now()
                              : dateFromString(completemilestone[indx].text),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        ).then((value) {
                          completemilestone[indx].text = formateDate(value);
                          sortByDateAscending(indx);
                          // sortByDate(indx);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: width * 0.3,
                    child: TextFormField(
                      controller: measuremilestone[indx],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: inputDecoration(
                        hint:
                            'How can I measure milestone completion numerically?',
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: List.generate(
                  habits[indx + 1].length,
                  (index) => habitsWidget(indx + 1, index),
                ),
              ),
              CustomIconTextButton(
                text: 'Add Habit/Recurring Activity',
                onPressed: () {
                  setState(() {
                    addHabits(indx + 1);
                  });
                },
              ),
              CustomIconTextButton(
                text: 'Add Milestone (Sub-Goal)',
                icon: assetImage(AppIcons.add, height: 25),
                onPressed: () {
                  setState(() {
                    addmilestone();
                  });
                },
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            milestones.removeAt(indx);
            completemilestone.removeAt(indx);
            measuremilestone.removeAt(indx);
            habits.removeAt(indx + 1);
            setState(() {});
          },
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }

  Widget roadmapGoalWidget() {
    return SizedBox(
      width: width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropDownStruct(
            child: DropdownButton(
              value: goal.value.id,
              onChanged: (val) {
                setState(() {
                  goal.value = goalsList.where((p0) => p0.id == val).first;
                  completegoal.text = goal.value.complete!;
                  measuregoal.text = goal.value.measureNumerically!.toString();
                });
              },
              items: goalsList
                  .map(
                    (element) => DropdownMenuItem(
                      value: element.id,
                      child: SizedBox(
                        width: width * 0.5,
                        child: TextWidget(
                          text: element.goal!,
                          alignment: Alignment.centerLeft,
                          maxline: 2,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: width * 0.3,
                child: TextFormField(
                  readOnly: true,
                  controller: completegoal,
                  decoration:
                      inputDecoration(hint: 'When will I complete this goal?'),
                ),
              ),
              SizedBox(
                width: width * 0.3,
                child: TextFormField(
                  readOnly: true,
                  controller: measuregoal,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: inputDecoration(
                    hint: 'How can I measure goal completion numerically?',
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: List.generate(
              habits[0].length,
              (index) => habitsWidget(0, index),
            ),
          ),
          CustomIconTextButton(
            text: 'Add Habit/Recurring Activity',
            onPressed: () {
              setState(() {
                addHabits(0);
              });
            },
          ),
          CustomIconTextButton(
            text: 'Add Milestone (Sub-Goal)',
            icon: assetImage(AppIcons.add, height: 25),
            onPressed: () {
              setState(() {
                addmilestone();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget habitsWidget(int parent, int child) {
    return TextFormField(
      controller: habits[parent][child],
      decoration: inputDecoration(
        hint:
            'Habit/Recurring activity that will be completed in this milestone',
      ),
    );
  }

  sortByDateAscending(int mindx) {
    for (int k = 0; k < (milestones.length - 1); k++) {
      for (int i = 0; i < (milestones.length - k - 1); i++) {
        int swapped = 0; // not swapped
        if (dateFromString(completemilestone[i + 1].text)
            .isAfter(dateFromString(completemilestone[i].text))) {
          TextEditingController _milestone = TextEditingController();
          _milestone = milestones[i];
          milestones[i] = milestones[i + 1];
          milestones[i + 1] = _milestone;
          TextEditingController _complete = TextEditingController();
          _complete = completemilestone[i];
          completemilestone[i] = completemilestone[i + 1];
          completemilestone[i + 1] = _complete;
          TextEditingController _measure = TextEditingController();
          _measure = measuremilestone[i];
          measuremilestone[i] = measuremilestone[i + 1];
          measuremilestone[i + 1] = _measure;
          List<TextEditingController> _habit = <TextEditingController>[];
          List<List<TextEditingController>> _habits =
              habits.getRange(1, habits.length).toList();
          _habit = _habits[i];
          _habits[i] = _habits[i + 1];
          _habits[i + 1] = _habit;
          habits.replaceRange(1, habits.length, _habits);
          swapped = 1; //swapped
        }
        if (swapped == 1) break;
      }
    }
    setState(() {});
  }

  sortByDate(int mindx) {
    for (int k = 0; k < (milestones.length - 1); k++) {
      for (int i = 0; i < (milestones.length - k - 1); i++) {
        int swapped = 0; // not swapped
        if (dateFromString(completemilestone[i].text)
            .isAfter(dateFromString(completemilestone[i + 1].text))) {
          TextEditingController _milestone = TextEditingController();
          _milestone = milestones[i];
          milestones[i] = milestones[i + 1];
          milestones[i + 1] = _milestone;
          TextEditingController _complete = TextEditingController();
          _complete = completemilestone[i];
          completemilestone[i] = completemilestone[i + 1];
          completemilestone[i + 1] = _complete;
          TextEditingController _measure = TextEditingController();
          _measure = measuremilestone[i];
          measuremilestone[i] = measuremilestone[i + 1];
          measuremilestone[i + 1] = _measure;
          List<TextEditingController> _habit = <TextEditingController>[];
          List<List<TextEditingController>> _habits =
              habits.getRange(1, habits.length).toList();
          _habit = _habits[i];
          _habits[i] = _habits[i + 1];
          _habits[i + 1] = _habit;
          habits.replaceRange(1, habits.length, _habits);
          swapped = 1; //swapped
        }
        if (swapped == 1) break;
      }
    }
    setState(() {});
  }

  Widget page1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
          text:
              'By the end of this exercise you will have mapped a path that leads to your end goal, identified the milestones you will need to complete before reaching your goal, identified specific activities to add to your custom system for reaching your goal, and plotted a realistic path through time to reach each milestone.  ',
          fontStyle: FontStyle.italic,
        ).marginOnly(bottom: 20),
        const TextWidget(text: 'What is a Milestone?', weight: FontWeight.bold),
        const TextWidget(
          text:
              'Depending on the complexity of your goal you may begin to discover there are numerous sub-goals needed to achieve your main goal. We refer to these sub-goals as milestones. Milestones serve as mile markers on your road to success. They not only show you that you’re on the right path but serve as short to medium-term goals and targets',
        ).marginOnly(bottom: 10),
        const TextWidget(
          text: 'Begin by asking yourself, ',
          fontStyle: FontStyle.italic,
        ),
        valueQuestions(
          '“What is the last thing I need to do, become, or accomplish before I achieve my goal?”',
          fromgoal: false,
          weight: FontWeight.bold,
        ),
        roadmapText(
          'Continue identifying the exact steps to reach your goal. Estimate how long it will take to complete each milestone and identify how you will measure completion of those milestones numerically.',
          ' At this point paint with broad strokes and make your milestones big picture items. Details can change, circumstances can change, resources can change, and overplanning too far into the future too far in detail can sometimes backfire',
        ),
        roadmapText(
          'Be on the lookout for any habits or skills to practice regularly that will move you closer to your goal. ',
          'Keep asking yourself how you can boil your goals and milestone down into identifiable processes and habits that make up a system. ',
        ),
        roadmapText(
          'Start from your main goal and work backward until you get extremely specific information about what you need to do daily to achieve your first level of milestones. ',
          '',
        ),
      ],
    );
  }

  clearMilestones() {
    milestones.clear();
    measuremilestone.clear();
    completemilestone.clear();
    if (habits.length != 1) habits.removeRange(1, habits.length - 1);
  }

  clearData() {
    index.value = 0;
    _roadmap.value = RoadmapModel(
      id: generateId(),
      userid: Get.find<AuthServices>().userid,
    );
    clearMilestones();
    goal.value = GoalsModel(name: 'Choose Goal', id: '');
    measuregoal.clear();
    measuremilestone.clear();
    habits.clear();
    selectParent.value = -1;
    selectedHabit.value = -1;
    _habit.value = SystemHabit();
    _habitindex.value = 0;
    habit = false.obs;
    _duration.value = false;
    _nudge.value = false;
    _nudges.value = true;
  }

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;
  previousIndex() => index.value = index.value - 1;

  final bool edit = Get.arguments[0];
  final Rx<RoadmapModel> _roadmap = RoadmapModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  final Rx<SystemHabit> _habit = SystemHabit(
    name: '',
    complete: false,
    days: [false, false, false, false, false, false, false],
    duration: PHabitDuration(
      start: '',
      end: '',
      duration: '',
      seconds: 0,
    ),
    nudge: NudgeModel(
      alarm: 0,
      reward: 0,
      chain: 0,
      cue: 0,
      setup: 0,
      rewardWritein: '',
      setups: '',
      chainWritein: '',
      cueWritein: '',
    ),
  ).obs;

  RxList<GoalsModel> goalsList =
      <GoalsModel>[GoalsModel(goal: 'Choose Goal', id: '')].obs;

  addToCalendar() async {
    final _startTime = getTimeFromString(_habit.value.duration!.start!);
    final _startDate = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, _startTime.hour, _startTime.minute);
    await Add2Calendar.addEvent2Cal(
      Event(
        title: _habit.value.name!,
        startDate: _startDate,
        endDate: _startDate
            .add(Duration(seconds: _habit.value.duration!.seconds ?? 0)),
      ),
    );
  }

  Future fetchgoals() async {
    await goalsRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 5)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          goalsList.add(GoalsModel.fromMap(doc));
        }
      }
    }).whenComplete(() {
      if (edit) fetchData();
    });
  }

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _roadmap.value.name = name.text;
    _roadmap.value.habit = _habit.value;
    var _goalhabit = <String>[];
    for (int i = 0; i < habits[0].length; i++) {
      _goalhabit.add(habits[0][i].text);
    }
    _roadmap.value.goal = RoadmapGoal(
      goalid: goal.value.id,
      habits: _goalhabit,
    );
    _roadmap.value.milestone = <MilestoneModel>[];
    for (int i = 0; i < milestones.length; i++) {
      var _mhabit = <String>[];
      final _habits = habits.getRange(1, habits.length).toList();
      for (int j = 0; j < _habits[i].length; j++) {
        _mhabit.add(_habits[i][j].text);
      }
      _roadmap.value.milestone!.add(
        MilestoneModel(
          milestone: milestones[i].text,
          measureCompletion: measuremilestone[i].text,
          completion: completemilestone[i].text.isEmpty
              ? formateDate(DateTime.now())
              : completemilestone[i].text,
          habits: _mhabit,
        ),
      );
    }
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _roadmap.value.duration = _roadmap.value.duration! + diff;
    } else {
      _roadmap.value.duration = diff;
    }
  }

  fetchData() {
    _roadmap.value = Get.arguments[1] as RoadmapModel;
    name.text = _roadmap.value.name!;
    _habit.value = _roadmap.value.habit!;
    goal.value =
        goalsList.where((p0) => p0.id == _roadmap.value.goal!.goalid!).first;
    completegoal.text = goal.value.complete!;
    measuregoal.text = goal.value.measureNumerically!.toString();
    for (int i = 0; i < _roadmap.value.goal!.habits!.length; i++) {
      habits[0]
          .add(TextEditingController(text: _roadmap.value.goal!.habits![i]));
    }
    for (int i = 0; i < _roadmap.value.milestone!.length; i++) {
      final _milestone = _roadmap.value.milestone![i];
      milestones.add(TextEditingController(text: _milestone.milestone!));
      measuremilestone.add(TextEditingController(
          text: _milestone.measureCompletion!.toString()));
      completemilestone
          .add(TextEditingController(text: _milestone.completion!));
      habits.add(<TextEditingController>[]);
      for (int j = 0; j < _milestone.habits!.length; j++) {
        habits[i + 1].add(TextEditingController(text: _milestone.habits![j]));
      }
    }
    for (int i = 0; i < habits.length; i++) {
      for (int j = 0; j < habits[i].length; j++) {
        if (habits[i][j].text == _habit.value.name!) {
          selectParent.value = i;
          selectedHabit.value = j;
          break;
        }
      }
    }
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == goals);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: name.text,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _roadmap.value.id,
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
    if (edit) _roadmap.value.id = generateId();
    await goalsRef.doc(_roadmap.value.id).set(_roadmap.value.toMap());
    await addAccomplishment(end);
    Get.back();
    if (!fromsave) {
      if (Get.find<GoalsController>().history.value.value == 112) {
        Get.find<GoalsController>()
            .updateHistory(end.difference(initial).inSeconds);
      }
      Get.back();
    }
    if (_duration.value) await addToCalendar();
    customToast(message: 'Roadmap created successfully');
  }

  Future updateJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    await goalsRef.doc(_roadmap.value.id).update(_roadmap.value.toMap());
    Get.back();
    if (!fromsave) Get.back();
    customToast(message: 'Roadmap updated successfully');
  }

  @override
  void initState() {
    setState(() {
      fetchgoals();
    });
    super.initState();
  }
}

class PreviousRoadmap extends StatelessWidget {
  const PreviousRoadmap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Creating a System: Roadmap',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: goalsRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 6)
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
              final RoadmapModel model =
                  RoadmapModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const RoadmapScreen(),
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

class PeriodicReviewScreen extends StatefulWidget {
  const PeriodicReviewScreen({Key? key}) : super(key: key);

  @override
  State<PeriodicReviewScreen> createState() => _PeriodicReviewScreenState();
}

class _PeriodicReviewScreenState extends State<PeriodicReviewScreen> {
  final TextEditingController name = TextEditingController(
    text: 'PeriodicReview${formatTitelDate(DateTime.now())}',
  );

  RxString start = ''.obs;
  RxString end = ''.obs;

  Rx<ValuesModel> value = ValuesModel().obs;
  final Rx<ReflectionModel> _reflection = ReflectionModel().obs;
  RxBool reflection = false.obs;

  Rx<GoalsModel> goal = GoalsModel().obs;
  Rx<RoadmapModel> roadmapModel = RoadmapModel().obs;
  RxBool roadmap = false.obs;
  Rx<GoalReflectionModel> goalsReflection = GoalReflectionModel().obs;
  final RxBool _goalReflection = false.obs;

  Rx<SystemHabit> habit = SystemHabit().obs;
  Rx<HabitsReflection> habitsReflection = HabitsReflection().obs;
  final RxBool _habitsReflection = false.obs;

  Rx<NextPeriod> nextPeriod = NextPeriod(
    date: '',
    duration: PHabitDuration(duration: '', end: '', start: '', seconds: 0),
  ).obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: customAppbar(
            leading: backButton(
              () => index.value == 0 ? Get.back() : previousIndex(),
            ),
            implyLeading: true,
          ),
          bottomNavigationBar: index.value != 3
              ? Container(
                  height: 50,
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.last_page),
                    onPressed: () => updateIndex(),
                  ),
                )
              : BottomButtons(
                  button1: 'Finish & Add to Calendar',
                  button2: 'Save',
                  b1: width * 0.45,
                  b2: width * 0.2,
                  b3: width * 0.2,
                  onPressed1: () async =>
                      edit ? await updateReview() : await addReview(),
                  onPressed2: () async => await addReview(true),
                  onPressed3: () =>
                      index.value != 0 ? previousIndex() : Get.back(),
                ),
          body: SingleChildScrollView(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Column(
              children: [
                ExerciseTitle(
                  title: 'Periodic Review (Practice)',
                  onPressed: () => Get.to(
                    () => ReadingScreen(
                      title: 'Go102- Periodic Review ',
                      link:
                          'https://docs.google.com/document/d/1cusMB7xRJaIbxvW2TlnMgcPaGz9Yivuk/',
                      linked: () => Get.back(),
                      function: () {
                        if (Get.find<GoalsController>().history.value.value ==
                            113) {
                          final end = DateTime.now();
                          Get.find<GoalsController>()
                              .updateHistory(end.difference(initial).inSeconds);
                        }
                        Get.log('closed');
                      },
                    ),
                  ),
                  // () => Get.to(() => const G102Reading()),
                ).marginOnly(bottom: 10),
                JournalTop(
                  controller: name,
                  add: () => clearData(),
                  drive: () => Get.off(() => const PreviousReview()),
                  save: () async =>
                      edit ? await updateReview(true) : await addReview(true),
                ).marginOnly(bottom: 5),
                index.value == 0
                    ? page1()
                    : index.value == 1
                        ? page2()
                        : index.value == 2
                            ? page3()
                            : index.value == 3
                                ? page4()
                                : Container(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget page4() {
    return Column(
      children: [
        titles(
          'Overview & Next Period',
          alignment: Alignment.center,
        ).marginOnly(bottom: 20),
        textfieldWidget(
          '',
          'What can you do this quarter that will propel you rapidly towards your long-term ideal lifestyle, values, and goals?',
          (val) => setState(() {
            nextPeriod.value.quarter = val;
          }),
          8,
          nextPeriod.value.quarter,
          nextPeriod.value.quarter,
        ),
        textfieldWidget(
          '',
          'What are the biggest challenges to living your purpose and ideal life? How can you overcome them?',
          (val) => setState(() {
            nextPeriod.value.challenge = val;
          }),
          8,
          nextPeriod.value.challenge,
          nextPeriod.value.challenge,
        ),
        textfieldWidget(
          '',
          'Which habits, people, thoughts, goals, environments, and strategies are moving you forward towards your best self the fastest? Which are acting as a drag on your energy?',
          (val) => setState(() {
            nextPeriod.value.energy = val;
          }),
          8,
          nextPeriod.value.energy,
          nextPeriod.value.energy,
        ),
        textfieldWidget(
          '',
          'Review your calendar for the next period. Have you planned your most important goals and milestones? If not, do so now.',
          (val) => setState(() {
            nextPeriod.value.review = val;
          }),
          8,
          nextPeriod.value.review,
          nextPeriod.value.review,
        ),
        verticalSpace(height: height * 0.05),
        title2('Next Periodic Review', alignment: Alignment.centerLeft),
        DateWidget(
          date: nextPeriod.value.date == ''
              ? 'MM/DD/YY'
              : nextPeriod.value.date ?? '',
          ontap: () async {
            await customDatePicker(
              context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            ).then((value) {
              nextPeriod.value.date = formateDate(value);
              setState(() {});
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DateWidget(
              date: nextPeriod.value.duration!.start == ''
                  ? 'HH:MM'
                  : nextPeriod.value.duration!.start ?? '',
              ontap: () async {
                await customTimePicker(
                  context,
                  initialTime: TimeOfDay.now(),
                ).then((value) {
                  nextPeriod.value.duration!.start = value.format(context);
                  setState(() {});
                });
              },
            ),
            const TextWidget(text: '-'),
            DateWidget(
              date: nextPeriod.value.duration!.end == ''
                  ? 'HH:MM'
                  : nextPeriod.value.duration!.end ?? '',
              ontap: () async {
                await customTimePicker(
                  context,
                  initialTime: TimeOfDay.now(),
                ).then((value) {
                  nextPeriod.value.duration!.end = value.format(context);
                  setState(() {});
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget page3() {
    return Column(
      children: [
        const TextWidget(text: 'Habit Review', alignment: Alignment.center)
            .marginOnly(bottom: 30),
        CustomCheckBox(
          value: _habitsReflection.value,
          onChanged: (val) => _habitsReflection.value = val,
          title: 'Habits Reflection',
          width: width,
        ).marginOnly(bottom: 20),
        if (_habitsReflection.value)
          Column(
            children: [
              TextFormField(
                readOnly: true,
                initialValue: habit.value.name ?? '',
                decoration: inputDecoration(
                  hint:
                      'System Habit (Name of Habit autofilled from System Habit)',
                ),
                onChanged: (val) => setState(() {
                  habit.value.name = val;
                }),
              ).marginOnly(bottom: 30),
              textfieldWidget(
                '',
                'Are you staying consistent? If so, what do you attribute your success to? If not, then how can you design your environment (surroundings, people, media you consume, etc.) to make success easier and more natural?',
                (val) => setState(() {
                  habitsReflection.value.consistent = val;
                }),
                7,
                habitsReflection.value.consistent,
                habitsReflection.value.consistent,
              ),
              textfieldWidget(
                '',
                'Am I improving, even slightly, in my quality, quantity or another measure of my system activities? If not, how can I keep improving?',
                (val) => setState(() {
                  habitsReflection.value.improving = val;
                }),
                7,
                habitsReflection.value.improving,
                habitsReflection.value.improving,
              ),
              textfieldWidget(
                '',
                'What are your biggest challenges to completing this habit and what is your plan to overcome them?',
                (val) => setState(() {
                  habitsReflection.value.challenge = val;
                }),
                7,
                habitsReflection.value.challenge,
                habitsReflection.value.challenge,
              ),
            ],
          ),
      ],
    );
  }

  Widget page2() {
    return Column(
      children: [
        titles('Goals Review', alignment: Alignment.center)
            .marginOnly(bottom: 15),
        goalWidget().marginOnly(bottom: 20),
        CustomCheckBox(
          value: roadmap.value,
          onChanged: (val) => roadmap.value = val,
          title: 'Roadmap (Milestones)',
          width: width,
        ),
        if (roadmap.value)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                (roadmapModel.value.milestone ?? []).length,
                (index) => milestoneWidget(index),
              ),
            ),
          ).marginOnly(bottom: 30),
        CustomCheckBox(
          value: _goalReflection.value,
          onChanged: (val) => _goalReflection.value = val,
          title: 'Goals Reflection',
          width: width,
        ),
        if (_goalReflection.value)
          Column(
            children: [
              textfieldWidget(
                '',
                'Have you met your deadlines in your goals and milestones? If so, what do you attribute your success to? If not, why? How can you rectify the situation?',
                (val) => setState(() {
                  goalsReflection.value.metDeadline = val;
                }),
                5,
                goalsReflection.value.metDeadline,
                goalsReflection.value.metDeadline,
              ),
              textfieldWidget(
                '',
                'Do you have realistic milestones planned out for the next period? If not, go to your Roadmap and add them. ',
                (val) => setState(() {
                  goalsReflection.value.realisticMilestones = val;
                }),
                5,
                goalsReflection.value.realisticMilestones,
                goalsReflection.value.realisticMilestones,
              ),
              textfieldWidget(
                '',
                'How could you work towards your goal ten times more efficiently?',
                (val) => setState(() {
                  goalsReflection.value.efficiency = val;
                }),
                5,
                goalsReflection.value.efficiency,
                goalsReflection.value.efficiency,
              ),
              textfieldWidget(
                '',
                'How can you use the resources you have at hand right now to get the job done and complete your goal?',
                (val) => setState(() {
                  goalsReflection.value.resources = val;
                }),
                5,
                goalsReflection.value.resources,
                goalsReflection.value.resources,
              ),
              textfieldWidget(
                '',
                'What are the biggest challenges you are facing to reaching your goals/milestones and how can you overcome them?',
                (val) => setState(() {
                  goalsReflection.value.biggestChallenge = val;
                }),
                5,
                goalsReflection.value.biggestChallenge,
                goalsReflection.value.biggestChallenge,
              ),
            ],
          ),
      ],
    );
  }

  Widget milestoneWidget(int indx) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: width * 0.5,
          child: Column(
            children: [
              TextFormField(
                readOnly: true,
                initialValue: roadmapModel.value.milestone![indx].completion,
                decoration: inputDecoration(hint: 'Deadline'),
                onChanged: (val) => setState(
                    () => roadmapModel.value.milestone![indx].completion = val),
              ),
              TextFormField(
                readOnly: true,
                initialValue: roadmapModel.value.milestone![indx].milestone,
                decoration: inputDecoration(hint: 'Goal or Milestone'),
                onChanged: (val) => setState(
                    () => roadmapModel.value.milestone![indx].milestone = val),
              ),
              TextFormField(
                readOnly: true,
                // keyboardType: TextInputType.number,
                initialValue: roadmapModel
                    .value.milestone![indx].measureCompletion
                    .toString(),
                decoration: inputDecoration(hint: 'Measure Completion'),
                onChanged: (val) => setState(() => roadmapModel
                    .value.milestone![indx].measureCompletion = val),
              ),
            ],
          ),
        ),
        const SizedBox(width: 100, child: Divider()),
      ],
    );
  }

  Widget goalWidget() {
    return Column(
      children: [
        CustomIconTextButton(
          text: 'Load Goals',
          icon: const Icon(Icons.drive_folder_upload, color: Colors.black),
          onPressed: () {
            // List<GoalsModel> _values = <GoalsModel>[];
            // if (start.value != '' && end.value != '') {
            //   _values = goals
            //       .where((p0) =>
            //           p0.created!.isAfter(dateFromString(start.value)) &&
            //           p0.created!.isBefore(dateFromString(end.value)
            //               .add(const Duration(days: 1))))
            //       .toList();
            // }
            // setState(() {});
            Get.dialog(
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                title: const TextWidget(
                  text: 'Select Goals',
                  weight: FontWeight.bold,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    goals.isEmpty
                        ? CircularLoadingWidget(
                            height: height * 0.2,
                            onCompleteText:
                                'No goals to show. Please select a data interval first',
                          )
                        : SizedBox(
                            height: height * 0.6,
                            child: ListView.builder(
                              itemCount: goals.length,
                              itemBuilder: (context, index) {
                                final GoalsModel _value = goals[index];
                                return Stack(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        goal.value = _value;
                                        List<RoadmapModel> _roadmaps = roadmaps
                                            .where((p0) =>
                                                roadmapModel
                                                    .value.goal!.goalid! ==
                                                goal.value.id!)
                                            .toList();
                                        if (_roadmaps.isNotEmpty) {
                                          roadmapModel.value = _roadmaps.first;
                                          habit.value =
                                              roadmapModel.value.habit!;
                                        }
                                        Get.back();
                                        setState(() {});
                                      },
                                      child: Card(
                                        elevation: 5.0,
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: TextWidget(text: _value.goal!)
                                            .marginAll(15),
                                      ),
                                    ),
                                    if (_value.id == goal.value.id)
                                      const Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Icon(Icons.check_circle,
                                            color: Colors.green),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => Get.back(),
                        child: const TextWidget(
                          text: 'Cancel',
                          alignment: Alignment.centerRight,
                          color: Colors.blue,
                          size: 16,
                        ),
                      ),
                    ).marginOnly(top: 15),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.end,
              ),
            );
          },
        ),
        TextFormField(
          readOnly: true,
          initialValue: goal.value.goal,
          key: Key(goal.value.goal ?? 'A'),
          decoration: inputDecoration(
            hint: 'Goal (autofilled from detailed Top 5 Goals)',
          ),
          onChanged: (val) => setState(() => goal.value.goal = val),
        ),
        TextFormField(
          readOnly: true,
          initialValue: goal.value.complete,
          key: Key(goal.value.complete ?? 'B'),
          decoration: inputDecoration(
            hint: 'When will I complete this goal? (autofilled)',
          ),
          onChanged: (val) => setState(() => goal.value.complete = val),
        ),
        TextFormField(
          readOnly: true,
          // keyboardType: TextInputType.number,
          key: Key(goal.value.measureNumerically ?? 'C'),
          initialValue: (goal.value.measureNumerically).toString(),
          decoration: inputDecoration(
            hint: 'How can I measure completion numerically?  (autofilled)',
          ),
          onChanged: (val) =>
              setState(() => goal.value.measureNumerically = val),
        ),
        TextFormField(
          // readOnly: true,
          key: Key(goal.value.deepestWhys ?? 'D'),
          initialValue: goal.value.deepestWhys,
          decoration: inputDecoration(
            hint: 'What is my deepest why for completing this goal?',
          ),
          onChanged: (val) => setState(() => goal.value.deepestWhys = val),
        ),
      ],
    );
  }

  Widget page1() {
    return Column(
      children: [
        const TextWidget(
          text:
              'Truly track if you are living up to your values and goals over any time period. Have your actions reflected your values and goals? ',
          fontStyle: FontStyle.italic,
        ).marginOnly(bottom: 20),
        const TextWidget(
          text: 'Review Time Period',
          weight: FontWeight.bold,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DateWidget(
              date: start.value == '' ? 'MM/DD/YY' : start.value,
              ontap: () async {
                await customDatePicker(
                  context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1990),
                  lastDate: DateTime(2100),
                ).then((value) {
                  start.value = formateDate(value);
                });
              },
            ),
            const TextWidget(text: '-'),
            DateWidget(
              date: end.value == '' ? 'MM/DD/YY' : end.value,
              ontap: () async {
                await customDatePicker(
                  context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1990),
                  lastDate: DateTime(2100),
                ).then((value) {
                  if (value.isBefore(dateFromString(start.value))) {
                    customToast(
                      message: 'End date should be greater than start date',
                    );
                  } else {
                    end.value = formateDate(value);
                    fetchbyDate();
                  }
                  setState(() {});
                });
              },
            ),
          ],
        ).marginOnly(bottom: 25),
        valueWidget(),
        CustomCheckBox(
          value: reflection.value,
          onChanged: (val) => reflection.value = val,
          title: 'Reflection',
        ),
        if (reflection.value)
          Column(
            children: [
              textfieldWidget(
                'Why do you think you have this authenticity score?',
                'Why do you think you have this authenticity score?',
                (val) => setState(() {
                  _reflection.value.authenticityScore = val;
                }),
                5,
                _reflection.value.authenticityScore ?? '0',
                _reflection.value.authenticityScore,
              ),
              textfieldWidget(
                'How can you design your environment (surroundings, people, media you consume, etc.) to make living up to your value easier and more natural?',
                'How can you design your environment (surroundings, people, media you consume, etc.) to make living up to your value easier and more natural?',
                (val) => setState(() {
                  _reflection.value.environment = val;
                }),
                5,
                _reflection.value.environment ?? '1',
                _reflection.value.environment,
              ),
              textfieldWidget(
                'What is stopping you from living up to your value fully? What is your plan to deal with this stumbling block?',
                'What is stopping you from living up to your value fully? What is your plan to deal with this stumbling block?',
                (val) => setState(() {
                  _reflection.value.stoppingYou = val;
                }),
                5,
                _reflection.value.stoppingYou ?? '2',
                _reflection.value.stoppingYou,
              ),
            ],
          ),
      ],
    );
  }

  Widget valueWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const TextWidget(text: 'Values', weight: FontWeight.bold),
                horizontalSpace(width: width * 0.05),
                CustomIconTextButton(
                  text: 'Load Values',
                  icon: const Icon(
                    Icons.drive_folder_upload,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {});
                    Get.dialog(
                      AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        title: const TextWidget(
                          text: 'Select Value',
                          weight: FontWeight.bold,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            values.isEmpty
                                ? CircularLoadingWidget(
                                    height: height * 0.2,
                                    onCompleteText:
                                        'No values to show. Please select a data interval first',
                                  )
                                : SizedBox(
                                    height: height * 0.6,
                                    child: ListView.builder(
                                      itemCount: values.length,
                                      itemBuilder: (context, index) {
                                        final ValuesModel _value =
                                            values[index];
                                        return Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                value.value = values[index];
                                                final _values = allValues
                                                    .where((element) =>
                                                        element.id ==
                                                        value.value.id)
                                                    .toList();
                                                average.text =
                                                    avgAuthenticity(
                                                            _values)
                                                        .toString();
                                                Get.back();
                                                setState(() {});
                                              },
                                              child: Card(
                                                elevation: 5.0,
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: TextWidget(
                                                        text: _value.value!)
                                                    .marginAll(15),
                                              ),
                                            ),
                                            if (_value.id == value.value.id)
                                              const Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Icon(Icons.check_circle,
                                                    color: Colors.green),
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () => Get.back(),
                                child: const TextWidget(
                                  text: 'Cancel',
                                  alignment: Alignment.centerRight,
                                  color: Colors.blue,
                                  size: 16,
                                ),
                              ),
                            ).marginOnly(top: 15),
                          ],
                        ),
                        actionsAlignment: MainAxisAlignment.end,
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              width: width * 0.2,
              child: const TextWidget(
                text: 'Average Authenticity',
                weight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: width * 0.7,
              child: TextFormField(
                readOnly: true,
                key: Key(value.value.value ?? ''),
                initialValue: value.value.value,
                onChanged: (val) => setState(() {
                  value.value.value = val;
                }),
                decoration: inputDecoration(
                  hint: 'Value (autofilled based on loaded values)',
                ),
              ),
            ),
            SizedBox(
              width: width * 0.2,
              child: TextFormField(
                readOnly: true,
                controller: average,
                onChanged: (val) => setState(() {
                  value.value.authenticity = double.parse(val);
                }),
                decoration: inputDecoration(hint: '10'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  TextEditingController average = TextEditingController();

  double avgAuthenticity(List values) {
    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total = (total + values[i].authenticity!).toDouble();
      debugPrint('$i: $total');
    }
    return total / values.length;
  }

  double calculateAuthenticity() {
    double total = 0;
    for (int i = 0; i < authenticity.length; i++) {
      total = (total + authenticity[i]).toDouble();
      debugPrint('$i: $total');
    }
    return total / authenticity.length;
  }

  RxList<double> authenticity = <double>[].obs;
  RxList<ValuesModel> allValues = <ValuesModel>[].obs;

  fetchbyDate() {
    setState(() {
      for (int i = 0; i < level1.length; i++) {
        if (values
            .where((val) => val.id == level1[i].value!.value!.id)
            .isEmpty) {
          values.add(level1[i].value!.value!);
        }
        authenticity.add(level1[i].value!.value!.authenticity!);
        allValues.add(level1[i].value!.value!);
      }
      for (int i = 0; i < level2.length; i++) {
        if (values.where((val) => val.id == level2[i].value!.id).isEmpty) {
          values.add(level2[i].value!);
        }
        authenticity.add(level2[i].value!.authenticity!);
        allValues.add(level2[i].value!);
        goals.add(level2[i].goal!);
      }
      for (int i = 0; i < level3.length; i++) {
        if (values.where((val) => val.id == level3[i].value!.id).isEmpty) {
          values.add(level3[i].value!);
        }
        authenticity.add(level3[i].value!.authenticity!);
        allValues.add(level3[i].value!);
        if (goals.where((val) => val.id == level3[i].goal!.id).isEmpty) {
          goals.add(level3[i].goal!);
        }
        roadmaps.add(level3[i].roadmap!);
      }
      if (values.isNotEmpty) {
        value.value = values.first;
        average.text = calculateAuthenticity().toString();
      }
      if (roadmaps.isNotEmpty) {
        roadmapModel.value = roadmaps.first;
        goal.value = goals
            .where((p0) => p0.id == roadmapModel.value.goal!.goalid!)
            .first;
        habit.value = roadmapModel.value.habit!;
      } else {
        if (goals.isNotEmpty) goal.value = goals.first;
      }
    });
    print('values: $values');
    print('goals: $goals');
    print('roadmaps: $roadmaps');
    setState(() {});
  }

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;
  previousIndex() => index.value = index.value - 1;

  clearData() {
    index.value = 0;
    start.value = '';
    end.value = '';
    value.value = ValuesModel();
    _reflection.value = ReflectionModel();
    reflection.value = false;
    goal.value = GoalsModel();
    roadmapModel.value = RoadmapModel();
    roadmap.value = false;
    goalsReflection.value = GoalReflectionModel();
    habit.value = SystemHabit();
    habitsReflection.value = HabitsReflection();
    nextPeriod.value = NextPeriod();
    _review.value = PeriodicReviewModel(
      id: generateId(),
      userid: Get.find<AuthServices>().userid,
    );
  }

  final bool edit = Get.arguments[0];
  final Rx<PeriodicReviewModel> _review = PeriodicReviewModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  RxList<GoalsModel> goals = <GoalsModel>[].obs;
  RxList<ValuesModel> values = <ValuesModel>[].obs;
  RxList<RoadmapModel> roadmaps = <RoadmapModel>[].obs;

  RxList<PJL1Model> level1 = <PJL1Model>[].obs;
  RxList<PJL2Model> level2 = <PJL2Model>[].obs;
  RxList<PJL3Model> level3 = <PJL3Model>[].obs;

  Future fetchDocuments() async {
    await goalsRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .orderBy('created', descending: true)
        .get()
        .then((val) {
      if (val.docs.isNotEmpty) {
        for (var doc in val.docs) {
          if (doc['type'] == 1) {
            level1.add(PJL1Model.fromMap(doc));
            //   final value = ValuesModel.fromMap(doc['value']['value']);
            //   if (values.where((p0) => p0.id == value.id).toList().isEmpty) {
            //     values.add(value);
            //   }
          } else if (doc['type'] == 2) {
            level2.add(PJL2Model.fromMap(doc));
            //   final value = ValuesModel.fromMap(doc['value']);
            //   if (values.where((p0) => p0.id == value.id).toList().isEmpty) {
            //     values.add(value);
            //   }
            //   final goal = GoalsModel.fromMap(doc['goal']);
            //   if (goals.where((p0) => p0.id == goal.id).toList().isEmpty) {
            //     goals.add(goal);
            //   }
          } else if (doc['type'] == 3) {
            level3.add(PJL3Model.fromMap(doc));
            //   final value = ValuesModel.fromMap(doc['value']);
            //   if (values.where((p0) => p0.id == value.id).toList().isEmpty) {
            //     values.add(value);
            //   }
            //   final goal = GoalsModel.fromMap(doc['goal']);
            //   if (goals.where((p0) => p0.id == goal.id).toList().isEmpty) {
            //     goals.add(goal);
            //   }
            //   final roadmap = RoadmapModel.fromMap(doc['roadmap']);
            //   if (roadmaps.where((p0) => p0.id == roadmap.id).toList().isEmpty) {
            //     roadmaps.add(roadmap);
            //   }
          }
          // else if (doc['type'] == 6) {
          //   roadmaps.add(RoadmapModel.fromMap(doc));
          // }
        }
        print('level1: $level1');
        print('level2: $level2');
        print('level3: $level3');
      }

      setState(() {});
    }).whenComplete(() => {if (edit) fetchData()});
    setState(() {});
  }

  DateTime initial = DateTime.now();
  setData(DateTime _end) {
    _review.value.name = name.text;
    _review.value.reviewtime = ReviewTime(end: end.value, start: start.value);
    _review.value.value = value.value;
    _review.value.reflection = _reflection.value;
    _review.value.goal = goal.value;
    _review.value.roadmap = roadmapModel.value;
    _review.value.goalsReflection = goalsReflection.value;
    habitsReflection.value.name = habit.value.name;
    _review.value.habitsReflection = habitsReflection.value;
    _review.value.nextPeriod = nextPeriod.value;
    final diff = _end.difference(initial).inSeconds;
    if (edit) {
      _review.value.duration = _review.value.duration! + diff;
    } else {
      _review.value.duration = diff;
    }
  }

  fetchData() {
    _review.value = Get.arguments[1] as PeriodicReviewModel;
    name.text = _review.value.name!;
    final _duration = _review.value.reviewtime!;
    start.value = _duration.start!;
    end.value = _duration.end!;
    value.value = _review.value.value!;
    _reflection.value = _review.value.reflection!;
    goal.value = _review.value.goal!;
    roadmapModel.value = _review.value.roadmap!;
    goalsReflection.value = _review.value.goalsReflection!;
    habit.value = roadmapModel.value.habit!;
    habitsReflection.value = _review.value.habitsReflection!;
    habit.value.name = habitsReflection.value.name;
    nextPeriod.value = _review.value.nextPeriod!;
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == 'goals');
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: name.text,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _review.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addReview([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    if (edit) _review.value.id = generateId();
    await goalsRef.doc(_review.value.id).set(_review.value.toMap());
    if (!fromsave) await addtoCalendar();
    await addAccomplishment(end);
    Get.back();
    if (!fromsave) {
      if (Get.find<GoalsController>().history.value.value == 115) {
        Get.find<GoalsController>()
            .updateHistory(end.difference(initial).inSeconds);
      }
      Get.back();
    }
    customToast(message: 'Review added successfully');
  }

  addtoCalendar() async {
    await Add2Calendar.addEvent2Cal(
      Event(
        title: 'Periodic Review',
        startDate: dateFromString(nextPeriod.value.date!),
        endDate: dateFromString(nextPeriod.value.date!),
      ),
    );
  }

  Future updateReview([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    loadingDialog(context);
    final end = DateTime.now();
    setData(end);
    await goalsRef.doc(_review.value.id).update(_review.value.toMap());
    Get.back();
    if (!fromsave) Get.back();
    customToast(message: 'Updated successfully');
  }

  @override
  void initState() {
    setState(() {
      fetchDocuments();
    });
    super.initState();
  }
}

class PreviousReview extends StatelessWidget {
  const PreviousReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Periodic Review',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: goalsRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 7)
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
              final PeriodicReviewModel model =
                  PeriodicReviewModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const PeriodicReviewScreen(),
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

class textfieldWidget extends StatelessWidget {
  const textfieldWidget(this.title, this.hint, this.onchanged, this.maxLines,
      this._key, this.initial,
      {Key? key})
      : super(key: key);
  final String title;
  final String? hint;
  final int? maxLines;
  final onchanged;
  final String? _key, initial;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextWidget(text: title),
        TextFormField(
          // key: Key(_key ?? ''),
          initialValue: initial,
          maxLines: maxLines ?? 1,
          onChanged: onchanged,
          decoration: inputDecoration(hint: hint),
        ),
      ],
    ).marginOnly(bottom: title == '' ? 0 : 7);
  }
}
