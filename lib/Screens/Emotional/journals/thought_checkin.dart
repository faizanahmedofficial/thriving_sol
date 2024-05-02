// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Model/er_models.dart';
import 'package:schedular_project/Screens/custom_bottom.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/checkboxes.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';
import 'package:schedular_project/Global/firebase_collections.dart';

import '../../../Constants/constants.dart';
import '../../../Functions/time_picker.dart';
import '../../../Model/app_user.dart';
import '../../../Widgets/custom_images.dart';
import '../../../Widgets/drop_down_button.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../app_icons.dart';
import '../../readings.dart';
import '../er_home.dart';

class ECheckinController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController currentTime = TextEditingController();
  RxInt stressLevel = 0.obs;

  List<TextEditingController> emotionController = <TextEditingController>[];
  List<int> emotionList = <int>[];

  void clearCheckinData() {
    index.value = 0;
    stressLevel.value = 1;
    name.clear();
    thoughtController.clear();
    emotionController.clear();
    emotionList.clear();
    evidenceController.clear();
    againstController.clear();
    reframedController.clear();
    options.clear();
    distortion.clear();
    actual.clear();
    reframed.clear();
    easy.clear();
    matters.clear();
    advice.clear();
    steps.clear();
    personControllers.clear();
    placeControllers.clear();
    consequenceControllers.clear();
    triggerControllers.clear();
    actionControllers.clear();
    behaviourControllers.clear();
    check.value = false;
    time.clear();
    date.clear();

    ///
    addEmotion();
    addThought();
    addAction();
    addBehaviour();
    addConsequence();
    addPerson();
    addPlace();
    addThought();
    addTrigger();
  }

  @override
  void onInit() {
    name.text = 'ERJournalLevel3ThoughtCheckIn${formatTitelDate(DateTime.now()).trim()}';
    currentTime.text = formateDate(DateTime.now());
    addEmotion();
    addThought();
    addAction();
    addBehaviour();
    addConsequence();
    addTrigger();
    addPerson();
    addPlace();
    if (edit) fetchData();
    super.onInit();
  }

  final page1 = GlobalKey<FormState>();

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;

  void addEmotion() {
    TextEditingController emotion = TextEditingController();
    emotionController.add(emotion);
    emotionList.add(0);
  }

  RxBool viewThought = false.obs;
  List<TextEditingController> thoughtController = <TextEditingController>[];
  List<TextEditingController> evidenceController = <TextEditingController>[];
  List<TextEditingController> againstController = <TextEditingController>[];
  List<TextEditingController> reframedController = <TextEditingController>[];
  List<int> options = <int>[];
  List<int> distortion = <int>[];
  List<int> actual = <int>[];
  List<int> reframed = <int>[];

  addThought() {
    options.add(0);
    distortion.add(0);
    actual.add(0);
    reframed.add(0);
    TextEditingController controller = TextEditingController();
    thoughtController.add(controller);
    TextEditingController control = TextEditingController();
    evidenceController.add(control);
    TextEditingController controlled = TextEditingController();
    againstController.add(controlled);
    TextEditingController controler = TextEditingController();
    reframedController.add(controler);
  }

  TextEditingController easy = TextEditingController();
  TextEditingController matters = TextEditingController();
  TextEditingController advice = TextEditingController();
  TextEditingController steps = TextEditingController();

  final bool edit = Get.arguments[0];
  final Rx<EAModel> _emotional = EAModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
    type: 15,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _emotional.value.title = name.text;
    _emotional.value.date = currentTime.text;
    _emotional.value.stress = stressLevel.value;
    _emotional.value.emotions = <EmotionsModel>[];
    for (int i = 0; i < emotionController.length; i++) {
      _emotional.value.emotions!.add(
        EmotionsModel(
          emotion: emotionController[i].text,
          strength: emotionList[i],
        ),
      );
    }
    _emotional.value.thoughts = <ReframingEvent>[];
    for (int i = 0; i < thoughtController.length; i++) {
      _emotional.value.thoughts!.add(
        ReframingEvent(
          thought: thoughtController[i].text,
          evidence: evidenceController[i].text,
          evidencAgainst: againstController[i].text,
          reframed: reframedController[i].text,
          option: options[i],
          actualBelief: actual[i],
          reframedBelief: reframed[i],
        ),
      );
    }
    _emotional.value.resolution = ResolutionModel(
      solution: easy.text,
      fiveYears: matters.text,
      advice: advice.text,
      alternative: steps.text,
    );
    RAModel root = RAModel(
      cdate: date.text,
      time: time.text,
      precedent: check.value,
    );
    root.persons = <String>[];
    for (int i = 0; i < personControllers.length; i++) {
      root.persons!.add(personControllers[i].text);
    }
    root.places = <String>[];
    for (int i = 0; i < placeControllers.length; i++) {
      root.places!.add(placeControllers[i].text);
    }
    root.actions = <String>[];
    for (int i = 0; i < actionControllers.length; i++) {
      root.actions!.add(actionControllers[i].text);
    }
    root.behaviors = <String>[];
    for (int i = 0; i < behaviourControllers.length; i++) {
      root.behaviors!.add(behaviourControllers[i].text);
    }
    root.triggers = <String>[];
    for (int i = 0; i < triggerControllers.length; i++) {
      root.triggers!.add(triggerControllers[i].text);
    }
    root.consequences = <String>[];
    for (int i = 0; i < consequenceControllers.length; i++) {
      root.consequences!.add(consequenceControllers[i].text);
    }
    _emotional.value.rootAnalysis = root;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _emotional.value.duration = _emotional.value.duration! + diff;
    } else {
      _emotional.value.duration = diff;
    }
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == er);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: name.text,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _emotional.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addECI([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    page1.currentState!.save();
    if (page1.currentState!.validate()) {
      loadingDialog(Get.context!);
       final end = DateTime.now();
      setData(end);
      if (edit) _emotional.value.id = generateId();
      await erRef.doc(_emotional.value.id).set(_emotional.value.toMap());
      await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<ErController>().history.value.value == 85) {
          Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
        } else if (Get.find<ErController>().history.value.value == 86) {
          RxInt count = 0.obs;
          await erRef
              .where('userid', isEqualTo: Get.find<AuthServices>().userid)
              .where('type', isEqualTo: 14)
              .get()
              .then((value) {
            if (value.docs.isNotEmpty) {
              count.value = count.value + value.docs.length;
            }
          });
          await erRef
              .where('userid', isEqualTo: Get.find<AuthServices>().userid)
              .where('type', isEqualTo: 15)
              .get()
              .then((value) {
            if (value.docs.isNotEmpty) {
              count.value = count.value + value.docs.length;
            }
          });
          if (count.value >= 3) Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      Get.back();
      customToast(message: 'Added successfully');
    }
  }

  Future updateECI([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    page1.currentState!.save();
    if (page1.currentState!.validate()) {
      loadingDialog(Get.context!);
       final end = DateTime.now();
      setData(end);
      await erRef.doc(_emotional.value.id).update(_emotional.value.toMap());
      if (!fromsave) Get.back();
      Get.back();
      customToast(message: 'Updated successfully');
    }
  }

  fetchData() {
    _emotional.value = Get.arguments[1] as EAModel;
    name.text = _emotional.value.title!;
    currentTime.text = _emotional.value.date!;
    stressLevel.value = _emotional.value.stress!;
    emotionController.clear();
    emotionList.clear();
    for (int i = 0; i < _emotional.value.emotions!.length; i++) {
      final EmotionsModel emotion = _emotional.value.emotions![i];
      addEmotion();
      emotionController[i].text = emotion.emotion!;
      emotionList[i] = emotion.strength!;
    }
    thoughtController.clear();
    evidenceController.clear();
    againstController.clear();
    reframedController.clear();
    options.clear();
    distortion.clear();
    actual.clear();
    reframed.clear();
    for (int i = 0; i < _emotional.value.thoughts!.length; i++) {
      final ReframingEvent thought = _emotional.value.thoughts![i];
      addThought();
      thoughtController[i].text = thought.thought!;
      evidenceController[i].text = thought.evidence!;
      againstController[i].text = thought.evidencAgainst!;
      reframedController[i].text = thought.reframed!;
      options[i] = thought.option!;
      actual[i] = thought.actualBelief!;
      reframed[i] = thought.reframedBelief!;
    }
    final ResolutionModel resolution = _emotional.value.resolution!;
    easy.text = resolution.solution!;
    matters.text = resolution.fiveYears!;
    advice.text = resolution.advice!;
    steps.text = resolution.alternative!;
    final RAModel root = _emotional.value.rootAnalysis!;
    date.text = root.cdate!;
    time.text = root.time!;
    check.value = root.precedent!;
    personControllers.clear();
    for (int i = 0; i < root.persons!.length; i++) {
      personControllers.add(TextEditingController(text: root.persons![i]));
    }
    placeControllers.clear();
    for (int i = 0; i < root.places!.length; i++) {
      placeControllers.add(TextEditingController(text: root.places![i]));
    }
    actionControllers.clear();
    for (int i = 0; i < root.actions!.length; i++) {
      actionControllers.add(TextEditingController(text: root.actions![i]));
    }
    behaviourControllers.clear();
    for (int i = 0; i < root.behaviors!.length; i++) {
      behaviourControllers
          .add(TextEditingController(text: root.behaviors![i]));
    }
    triggerControllers.clear();
    for (int i = 0; i < root.triggers!.length; i++) {
      triggerControllers.add(TextEditingController(text: root.triggers![i]));
    }
    consequenceControllers.clear();
    for (int i = 0; i < root.consequences!.length; i++) {
      consequenceControllers
          .add(TextEditingController(text: root.consequences![i]));
    }
  }

  List<TextEditingController> personControllers = <TextEditingController>[];
  List<TextEditingController> placeControllers = <TextEditingController>[];
  List<TextEditingController> actionControllers = <TextEditingController>[];
  List<TextEditingController> triggerControllers = <TextEditingController>[];
  List<TextEditingController> behaviourControllers = <TextEditingController>[];
  List<TextEditingController> consequenceControllers =
      <TextEditingController>[];
  RxBool check = false.obs;
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();

  void addPerson() => personControllers.add(TextEditingController());
  void addPlace() => placeControllers.add(TextEditingController());
  void addAction() => actionControllers.add(TextEditingController());
  void addTrigger() => triggerControllers.add(TextEditingController());
  void addBehaviour() => behaviourControllers.add(TextEditingController());
  void addConsequence() => consequenceControllers.add(TextEditingController());

  previousIndex() => index.value = index.value - 1;
}

class ECIPrevious extends StatelessWidget {
  const ECIPrevious({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'ER Journal Level 3 - Thought Check- In ',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: erRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 15)
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
              final EAModel model = EAModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const ThoughtCheckIn(),
                      arguments: [true, model]),
                  title: TextWidget(
                    text: model.title!,
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

class ThoughtCheckIn extends StatefulWidget {
  const ThoughtCheckIn({Key? key}) : super(key: key);

  @override
  _ThoughtCheckInState createState() => _ThoughtCheckInState();
}

class _ThoughtCheckInState extends State<ThoughtCheckIn> {
  final ECheckinController _check = Get.put(ECheckinController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(
          leading: backButton(
            () => _check.index.value == 0 ? Get.back() : _check.previousIndex(),
          ),
          implyLeading: true,
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomButtons(
            button1: _check.index.value == 6 ? 'Done' : 'Continue',
            button2: 'Save',
            onPressed2: () async => await _check.addECI(true),
            onPressed1: _check.index.value == 6
                ? () async => _check.edit
                    ? await _check.updateECI()
                    : await _check.addECI()
                : () => _check.updateIndex(),
            onPressed3: () =>
                _check.index.value != 0 ? _check.previousIndex() : Get.back(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _check.page1,
            child: Column(
              children: [
                verticalSpace(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TextWidget(
                      text:
                          'ER Journal Level 3 - \nThought Check- In (Practice)',
                      weight: FontWeight.bold,
                      alignment: Alignment.center,
                    ),
                    IconButton(
                      onPressed: () => Get.to(
                        () => ReadingScreen(
                          title: 'ER103- Are Your Thoughts Facts?',
                          link:
                              'https://docs.google.com/document/d/1mGyuMG_od8-VuCPXLx8npGrFYc37G5gy/',
                          linked: () => Get.back(),
                          function: () {
                            if (Get.find<ErController>().history.value.value ==
                                82) {
                                   final end = DateTime.now();
                              debugPrint('disposing');
                              Get.find<ErController>().updateHistory(end.difference(_check.initial).inSeconds);
                              debugPrint('disposed');
                            }
                            Get.log('closed');
                          },
                        ),
                      ),
                      // () => Get.to(
                      //   () => const ER103Reading(),
                      // ),
                      icon: assetImage(AppIcons.read),
                    ),
                  ],
                ),
                verticalSpace(height: 10),
                JournalTop(
                  controller: _check.name,
                  label: 'Name',
                  add: () => _check.clearCheckinData(),
                  save: () async => _check.edit
                      ? await _check.updateECI(true)
                      : await _check.addECI(true),
                  drive: () => Get.off(() => const ECIPrevious()),
                ),
                verticalSpace(height: 5),
                _check.index.value == 0
                    ? page1()
                    : _check.index.value == 1
                        ? page2()
                        : _check.index.value == 2
                            ? page3()
                            : _check.index.value == 3
                                ? rootAnalysis()
                                : _check.index.value == 4
                                    ? page4()
                                    : _check.index.value == 5
                                        ? page5()
                                        : _check.index.value == 6
                                            ? page6()
                                            : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rootAnalysis() {
    return Column(
      children: [
        verticalSpace(height: 15),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Arial',
              fontSize: 14,
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
            children: [
              TextSpan(
                text: 'ABC Root Analysis ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'This exercise helps to find the root cause of your negative thinking and/ or behavior patterns.',
              ),
            ],
          ),
        ),
        verticalSpace(height: 15),
        Row(
          children: [
            Checkbox(
              value: _check.check.value,
              onChanged: (val) {
                setState(() {
                  _check.check.value = val!;
                });
              },
            ),
            SizedBox(
              width: Get.width * 0.8,
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'Arial',
                    fontSize: 14,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                  children: [
                    TextSpan(
                      text: 'Antecedents. ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'What was happening directly before you had a change in emotion, thoughts, or behavior?',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        verticalSpace(height: 10),
        const TextWidget(text: 'Time (When was it?):'),
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: Get.width * 0.6,
            child: TextFormField(
              readOnly: true,
              controller: _check.date,
              decoration: inputDecoration(hint: 'Date (MM/DD/YYYY)'),
              onTap: () {
                customDatePicker(
                  context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.utc(2021),
                  lastDate: DateTime.utc(2100),
                ).then((value) {
                  _check.date.text = DateFormat('MM/dd/yyyy').format(value);
                });
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: Get.width * 0.6,
            child: TextFormField(
              readOnly: true,
              controller: _check.time,
              decoration: inputDecoration(hint: 'Time (HH:MM)'),
              onTap: () {
                customTimePicker(
                  context,
                  initialTime: TimeOfDay.now(),
                ).then((value) {
                  _check.time.text = value.format(context);
                });
              },
            ),
          ),
        ),

        ///
        verticalSpace(height: 15),
        const TextWidget(text: 'Who was I with?'),
        Column(
          children: [
            for (int i = 0; i < _check.personControllers.length; i++)
              personsField(i),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: TextButton.icon(
            onPressed: () => setState(() => _check.addPerson()),
            icon: const Icon(Icons.add, color: Colors.black),
            label: const TextWidget(text: 'Add Person'),
          ),
        ),

        ///
        verticalSpace(height: 15),
        const TextWidget(text: 'Where was I?'),
        Column(
          children: [
            for (int i = 0; i < _check.placeControllers.length; i++)
              placeField(i),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: TextButton.icon(
            onPressed: () => setState(() => _check.addPlace()),
            icon: const Icon(Icons.add, color: Colors.black),
            label: const TextWidget(text: 'Add Place'),
          ),
        ),

        ///
        verticalSpace(height: 15),
        const TextWidget(text: 'What was I doing?'),
        Column(
          children: [
            for (int i = 0; i < _check.actionControllers.length; i++)
              actionField(i),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: TextButton.icon(
            onPressed: () => setState(() => _check.addAction()),
            icon: const Icon(Icons.add, color: Colors.black),
            label: const TextWidget(text: 'Add Action'),
          ),
        ),

        ///
        verticalSpace(height: 15),
        const TextWidget(
          text: 'What triggered me to have a change in emotions??',
        ),
        Column(
          children: [
            for (int i = 0; i < _check.triggerControllers.length; i++)
              triggerField(i),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: TextButton.icon(
            onPressed: () => setState(() => _check.addTrigger()),
            icon: const Icon(Icons.add, color: Colors.black),
            label: const TextWidget(text: 'Add Trigger'),
          ),
        ),

        ///2
        verticalSpace(height: 20),
        Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              children: [
                TextSpan(
                  text: 'Behavior. ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: 'What did you do? What actions did you take?'),
              ],
            ),
          ),
        ),
        Column(
          children: [
            for (int i = 0; i < _check.behaviourControllers.length; i++)
              behaviorField(i),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: TextButton.icon(
            onPressed: () => setState(() => _check.addBehaviour()),
            icon: const Icon(Icons.add, color: Colors.black),
            label: const TextWidget(text: 'Add Behavior'),
          ),
        ),

        ///3
        verticalSpace(height: 20),
        Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              children: [
                TextSpan(
                  text: 'Consequences.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      'What was the outcome of your behavior? The consequences can be negative as well as positive. ',
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            for (int i = 0; i < _check.consequenceControllers.length; i++)
              consequenceField(i),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: TextButton.icon(
            onPressed: () => setState(() => _check.addConsequence()),
            icon: const Icon(Icons.add, color: Colors.black),
            label: const TextWidget(text: 'Add Consequence'),
          ),
        ),
      ],
    );
  }

  TextFormField personsField(int index) {
    return TextFormField(
      controller: _check.personControllers[index],
      decoration: inputDecoration(hint: 'Who was I with?'),
    );
  }

  TextFormField placeField(int index) {
    return TextFormField(
      controller: _check.placeControllers[index],
      decoration: inputDecoration(hint: 'Where was I?'),
    );
  }

  TextFormField actionField(int index) {
    return TextFormField(
      controller: _check.actionControllers[index],
      decoration: inputDecoration(hint: 'What was I doing?'),
    );
  }

  TextFormField triggerField(int index) {
    return TextFormField(
      controller: _check.triggerControllers[index],
      decoration: inputDecoration(hint: 'What triggered me?'),
    );
  }

  TextFormField behaviorField(int index) {
    return TextFormField(
      controller: _check.behaviourControllers[index],
      decoration:
          inputDecoration(hint: 'What did I do? What actions did I take?'),
    );
  }

  TextFormField consequenceField(int index) {
    return TextFormField(
      controller: _check.consequenceControllers[index],
      decoration: inputDecoration(hint: 'What were the consequences?'),
    );
  }

  Widget page6() {
    return Column(
      children: [
        verticalSpace(height: 15),
        RichText(
          text: const TextSpan(
            text: 'Resolution.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text:
                    'This is your time to focus on the practical ways to resolve troubling situations, especially those that pop up repeatedly. By having a plan in place you can drastically reduce the chances of negative outcomes and resolve situations before they even occur.',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        verticalSpace(height: 30),
        const TextWidget(
            text:
                'What would be the simplest and easiest way to change the outcome positively?'),
        TextFormField(
          controller: _check.easy,
          decoration: inputDecoration(hint: 'Simple or easy solution'),
        ),

        ///
        verticalSpace(height: 15),
        const TextWidget(text: 'Will this matter in 5 years? Why/ why not?'),
        TextFormField(
          controller: _check.matters,
          decoration:
              inputDecoration(hint: 'Is it important in the long term?'),
        ),

        ///
        verticalSpace(height: 15),
        const TextWidget(
          text:
              'What advice would I give a friend if he were in this situation?',
        ),
        TextFormField(
          controller: _check.advice,
          decoration:
              inputDecoration(hint: 'What advice would I giv a loved once?'),
        ),

        ///
        verticalSpace(height: 15),
        const TextWidget(
          text:
              'Write out an alternate more positive outcome and how exactly that could come to pass. Write the exact steps you could take to make this positive outcome occur.',
        ),
        TextFormField(
          maxLines: 10,
          controller: _check.steps,
          decoration: inputDecoration(
            hint: 'What steps will I take to resolve the situation?',
          ),
        ),
      ],
    );
  }

  Widget page5() {
    return Column(
      children: [
        CustomCheckBox(
          value: _check.viewThought.value,
          onChanged: (val) => _check.viewThought.value = val,
          title: 'Thoughts',
        ).marginOnly(bottom: 10),
        richText2(
          1,
          'Identify automatic negative thoughts, ',
          'self made judgements, and/or negative predictions you made.',
        ).marginOnly(bottom: 20),
        richText2(
          2,
          'Analyze your thoughts for validity. ',
          'Are they facts or poinions? How much do you believe in those thoughts?',
        ).marginOnly(bottom: 20),
        richText2(
          3,
          'Identify any cognitive distortions ',
          'your thought may have.',
        ).marginOnly(bottom: 20),
        richText2(
          4,
          'Write down the objective evidence for and against your thought. ',
          'Weigh this evidence carefully. ',
        ).marginOnly(bottom: 20),
        richText2(
          5,
          'Reframe your thought as a more realistic/ rational thought',
          ' based on the evidence you considered above.  Then, re-rate your belief in your original thought.',
        ).marginOnly(bottom: height * 0.1),

        Column(
          children: [
            for (int i = 0; i < _check.thoughtController.length; i++)
              thoughtElements(index: i),
          ],
        ),

        ///
        Align(
          alignment: Alignment.topLeft,
          child: TextButton.icon(
            onPressed: () {
              _check.addThought();
              setState(() {});
            },
            icon: const Icon(Icons.add, color: Colors.black),
            label: const TextWidget(text: 'Add Thought'),
          ),
        ),
      ],
    );
  }

  Column thoughtElements({required int index}) {
    return Column(
      children: [
        TextFormField(
          controller: _check.thoughtController[index],
          decoration: inputDecoration(hint: 'Thought'),
        ),
        Row(
          children: [
            CustomDropDownStruct(
              width: width * 0.79,
              child: DropdownButton(
                value: _check.options[index],
                onChanged: (val) {
                  setState(() {
                    _check.options[index] = val!;
                  });
                },
                items: optionList
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
              ),
            ),
            CustomDropDownStruct(
              child: DropdownButton(
                value: _check.actual[index],
                onChanged: (val) {
                  setState(() {
                    _check.actual[index] = val!;
                  });
                },
                items: beliefList
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
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: Get.width * 0.47,
              child: TextFormField(
                maxLines: 8,
                controller: _check.evidenceController[index],
                decoration: inputDecoration(hint: 'Evidence for your thought'),
              ),
            ),
            SizedBox(
              width: Get.width * 0.47,
              child: TextFormField(
                maxLines: 8,
                controller: _check.againstController[index],
                decoration: inputDecoration(
                  hint: 'Evidence against your thought',
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: Get.width * 0.79,
              child: TextFormField(
                controller: _check.reframedController[index],
                decoration: inputDecoration(
                  hint: 'Reframed/ realistic thought',
                ),
              ),
            ),
            CustomDropDownStruct(
              height: 50,
              child: DropdownButton(
                value: _check.reframed[index],
                onChanged: (val) {
                  setState(() {
                    _check.reframed[index] = val!;
                  });
                },
                items: beliefList
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
              ),
            ),
          ],
        ),
        verticalSpace(height: 10),
      ],
    );
  }

  Widget page4() {
    return Column(
      children: [
        verticalSpace(height: 10),
        const TextWidget(text: 'Emotions', weight: FontWeight.bold),
        Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              children: [
                TextSpan(
                  text: 'What were/ are you feeling?  ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'How strong are those emotions on a scale from 1-10?',
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            for (int i = 0; i < _check.emotionList.length; i++)
              emotionWidget(index: i),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: TextButton.icon(
            onPressed: () {
              _check.addEmotion();
              setState(() {});
            },
            icon: const Icon(Icons.add, color: Colors.black),
            label: const TextWidget(text: 'Add Emotion'),
          ),
        ),
      ],
    );
  }

  Widget emotionWidget({required int index}) {
    return Column(
      children: [
        SizedBox(
          width: width,
          child: TextFormField(
            controller: _check.emotionController[index],
            decoration: inputDecoration(hint: 'Emotions'),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: CustomDropDownStruct(
            height: 47,
            child: DropdownButton<int>(
              value: _check.emotionList[index],
              onChanged: (val) {
                setState(() {
                  _check.emotionList[index] = val!;
                });
              },
              items: emotionList
                  .map((e) => DropdownMenuItem(
                      value: e.value,
                      child: TextWidget(
                        text: e.title,
                        alignment: Alignment.centerLeft,
                      )))
                  .toList(),
            ),
          ),
        ),
      ],
    ).marginOnly(top: 5);
  }

  Widget page3() {
    return Column(
      children: [
        verticalSpace(height: 15),
        Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              children: [
                TextSpan(
                  text: 'Impartially observe yourself. ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      'Observe yourself simply as you are in this exact moment. View yourself in the present moment and feel compassion for yourself and anyone else present. Observe yourself and the situation without judgment as an impartial 3rd party. Will this matter in 5 years?',
                ),
              ],
            ),
          ),
        ),

        ///2
        verticalSpace(height: 20),
        Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              children: [
                TextSpan(
                  text: 'Find your level. ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      'Find your level. Pause. Excuse yourself from the area if you feel the need to. How stressed are you on a scale from 1-10 where Level 1 is feeling wonderful and Level 10 is considered very stressed. Find your level and accept it.',
                ),
              ],
            ),
          ),
        ),

        ///3
        verticalSpace(height: 20),

        ///4
        verticalSpace(height: 10),
        const TextWidget(
          text: 'What is your stress level right now?',
          weight: FontWeight.bold,
        ),
        verticalSpace(height: 5),
        Obx(
          () => Align(
            alignment: Alignment.topLeft,
            child: CustomDropDownStruct(
              child: DropdownButton<int>(
                value: _check.stressLevel.value,
                onChanged: (val) {
                  setState(() {
                    _check.stressLevel.value = val!;
                  });
                },
                items: observeList
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
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget page2() {
    return Column(
      children: [
        verticalSpace(height: 15),
        const TextWidget(
          text: 'Induce a relaxation response.',
          weight: FontWeight.bold,
        ),
        verticalSpace(height: 10),
        Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              children: [
                TextSpan(
                  text: '1) ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text:
                        'Take a deep breath in through your nose. Focus on following the sensation of your breath moving through your body. Feel the air moving into your body.'),
              ],
            ),
          ),
        ),

        ///2
        verticalSpace(height: 20),
        Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              children: [
                TextSpan(
                  text: '2) ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      'Breathe out as slowly as you can without straining, either, through your mouth or through your nose. Feel the exact area of your body the air is touching at this moment.',
                ),
              ],
            ),
          ),
        ),

        ///3
        verticalSpace(height: 20),
        Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              children: [
                TextSpan(
                  text: '3) ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text:
                        'Breathe deeply at least once, but feel free to repeat this process multiple times for more relaxation.'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget page1() {
    return Column(
      children: [
        const TextWidget(
          text:
              'This is your time to check in with yourself. You can reflect on a prior event or on the present moment.',
          fontStyle: FontStyle.italic,
        ),
        const TextWidget(
          text:
              '\n\n1) Take a slow, deep breath. \n\n2) Sit up straight, put your chin up a little bit, and put your shoulders back.\n\n 3) Observe yourself as you would a loved one and ask yourself, "What is/ was my stress level?" "What am/ was I thinking?" "What emotions am/ was I feeling?"',
        ),
        verticalSpace(height: 20),
        Center(
          child: TextFormField(
            controller: _check.currentTime,
            readOnly: true,
            onTap: () {
              customDatePicker(
                context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              ).then((value) {
                setState(() {
                  _check.currentTime.text = formateDate(value);
                });
              });
            },
            decoration: inputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              focusBorder: InputBorder.none,
            ),
          ),
        ),

        ///1
        verticalSpace(height: 15),
        const TextWidget(
          text: 'Induce a confident state.',
          weight: FontWeight.bold,
        ),
        verticalSpace(height: 7),
        Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              children: [
                TextSpan(
                  text: '1) ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: 'Sit or stand up straight.'),
              ],
            ),
          ),
        ),

        ///2
        verticalSpace(height: 10),
        Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              children: [
                TextSpan(
                  text: '2) ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text:
                      'Puff your chest out slightly, move your shoulders back',
                ),
              ],
            ),
          ),
        ),

        ///3
        verticalSpace(height: 10),
        Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'Arial',
                fontSize: 14,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              children: [
                TextSpan(
                  text: '3) ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: 'Put your chin up just a little bit.'),
              ],
            ),
          ),
        ),

        ///4
        verticalSpace(height: 10),
        const TextWidget(
          fontStyle: FontStyle.italic,
          text:
              'When you do these actions your body naturally signals to your brain that you are feeling confident.',
        ),
      ],
    );
  }
}
