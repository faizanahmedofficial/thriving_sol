// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Functions/time_picker.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/er_models.dart';
import 'package:schedular_project/Screens/Emotional/er_home.dart';
import 'package:schedular_project/Screens/custom_bottom.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../../Constants/constants.dart';
import '../../../Model/app_user.dart';
import '../../../Widgets/custom_images.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../app_icons.dart';
import '../../readings.dart';

class AbcRootAnalysis extends StatefulWidget {
  const AbcRootAnalysis({Key? key}) : super(key: key);

  @override
  _AbcRootAnalysisState createState() => _AbcRootAnalysisState();
}

class _AbcRootAnalysisState extends State<AbcRootAnalysis> {
  final _root = GlobalKey<FormState>();
  bool check = false;
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  List<TextEditingController> personControllers = <TextEditingController>[];
  List<TextEditingController> placeControllers = <TextEditingController>[];
  List<TextEditingController> actionControllers = <TextEditingController>[];
  List<TextEditingController> triggerControllers = <TextEditingController>[];
  List<TextEditingController> behaviourControllers = <TextEditingController>[];
  List<TextEditingController> consequenceControllers =
      <TextEditingController>[];

  List<TextFormField> persons = <TextFormField>[];
  List<TextFormField> place = <TextFormField>[];
  List<TextFormField> action = <TextFormField>[];
  List<TextFormField> trigger = <TextFormField>[];
  List<TextFormField> behaviour = <TextFormField>[];
  List<TextFormField> consequence = <TextFormField>[];

  int pindx = 0;
  int plindx = 0;
  int aindx = 0;
  int tindx = 0;
  int bindx = 0;
  int cindx = 0;
  TextEditingController currentTime = TextEditingController();

  void addPerson() {
    TextEditingController _person = TextEditingController();
    personControllers.add(_person);
    persons.add(personsField(index: pindx));
  }

  void addPlace() {
    TextEditingController _place = TextEditingController();
    placeControllers.add(_place);
    place.add(placeField(index: plindx));
  }

  void addAction() {
    TextEditingController _action = TextEditingController();
    actionControllers.add(_action);
    action.add(actionField(index: aindx));
  }

  void addTrigger() {
    TextEditingController _trigger = TextEditingController();
    triggerControllers.add(_trigger);
    trigger.add(triggerField(index: tindx));
  }

  void addBehaviour() {
    TextEditingController _behaviour = TextEditingController();
    behaviourControllers.add(_behaviour);
    behaviour.add(behaviorField(index: bindx));
  }

  void addConsequence() {
    TextEditingController _consequence = TextEditingController();
    consequenceControllers.add(_consequence);
    consequence.add(consequenceField(index: cindx));
  }

  void addFields() {
    addPerson();
    addPlace();
    addAction();
    addBehaviour();
    addTrigger();
    addConsequence();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    addFields();
    setState(() {
      name.text = 'AbcRootAnalysis${formatTitelDate(DateTime.now()).trim()}';
      currentTime.text = formateDate(DateTime.now());
      if (edit) fetchData();
    });
    super.initState();
  }

  DateTime initial = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(leading: backButton(), implyLeading: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: _root,
          child: Column(
            children: [
              verticalSpace(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: TextWidget(
                      text: 'ABC Root Analysis (Practice)',
                      weight: FontWeight.bold,
                      alignment: Alignment.center,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.to(
                      () => ReadingScreen(
                        title: 'ER102- ABC Root Analysis',
                        link:
                            'https://docs.google.com/document/d/1j5pNiZwiJKJWq2swS0UOJZJUzy-5-qFz/',
                        linked: () => Get.back(),
                        function: () {
                          if (Get.find<ErController>().history.value.value ==
                              78) {
                            final end = DateTime.now();
                            debugPrint('disposing');
                            Get.find<ErController>().updateHistory(
                                end.difference(initial).inSeconds);
                            debugPrint('disposed');
                          }
                          Get.log('closed');
                        },
                      ),
                    ),
                    // () => Get.to(
                    //   () => const ER102Reading(),
                    // ),
                    icon: assetImage(AppIcons.read),
                  ),
                ],
              ),
              verticalSpace(height: 10),
              JournalTop(
                controller: name,
                label: 'Name',
                add: () => clearData(),
                save: () async =>
                    edit ? await updateAnalysis(true) : await addAnalysis(true),
                drive: () => Get.off(() => const PreviousAnalysis()),
              ),

              ///1
              verticalSpace(height: 15),
              const TextWidget(
                text:
                    'This exercise helps to find the root cause of your negative thinking and/ or behavior patterns.',
                fontStyle: FontStyle.italic,
              ),
              verticalSpace(height: 10),
              Center(
                child: TextFormField(
                  controller: currentTime,
                  readOnly: true,
                  onTap: () {
                    customDatePicker(
                      context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    ).then((value) {
                      setState(() {
                        currentTime.text = formateDate(value);
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
              verticalSpace(height: 15),
              Row(
                children: [
                  Checkbox(
                    value: check,
                    onChanged: (val) {
                      setState(() {
                        check = val!;
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
                    controller: date,
                    decoration: inputDecoration(hint: 'Date (MM/DD/YYYY)'),
                    onTap: () {
                      customDatePicker(
                        context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.utc(2021),
                        lastDate: DateTime.utc(2100),
                      ).then((value) {
                        date.text = DateFormat('MM/dd/yyyy').format(value);
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
                    controller: time,
                    decoration: inputDecoration(hint: 'Time (HH:MM)'),
                    onTap: () {
                      customTimePicker(
                        context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        time.text = value.format(context);
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
                  for (int i = 0; i < persons.length; i++)
                    personsField(index: i),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      pindx = pindx + 1;
                      addPerson();
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  label: const TextWidget(text: 'Add Person'),
                ),
              ),

              ///
              verticalSpace(height: 15),
              const TextWidget(text: 'Where was I?'),
              Column(
                children: [
                  for (int i = 0; i < place.length; i++) placeField(index: i),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      plindx = plindx + 1;
                      addPlace();
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  label: const TextWidget(text: 'Add Place'),
                ),
              ),

              ///
              verticalSpace(height: 15),
              const TextWidget(text: 'What was I doing?'),
              Column(
                children: [
                  for (int i = 0; i < action.length; i++) actionField(index: i),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      aindx = aindx + 1;
                      addAction();
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
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
                  for (int i = 0; i < trigger.length; i++)
                    triggerField(index: i),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      tindx = tindx + 1;
                      addTrigger();
                    });
                  },
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
                      TextSpan(
                        text: 'What did you do? What actions did you take?',
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  for (int i = 0; i < behaviour.length; i++)
                    behaviorField(index: i),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      bindx = bindx + 1;
                      addBehaviour();
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
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
                  for (int i = 0; i < consequence.length; i++)
                    consequenceField(index: i),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      cindx = cindx + 1;
                      addConsequence();
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  label: const TextWidget(text: 'Add Consequence'),
                ),
              ),

              ///
              verticalSpace(height: Get.height * 0.01),
              BottomButtons(
                button1: 'Done',
                button2: 'Save',
                onPressed1: () async =>
                    edit ? await updateAnalysis() : await addAnalysis(),
                onPressed2: () async => await addAnalysis(true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField personsField({required int index}) {
    return TextFormField(
      controller: personControllers[index],
      decoration: inputDecoration(hint: 'Who was I with?'),
    );
  }

  TextFormField placeField({required int index}) {
    return TextFormField(
      controller: placeControllers[index],
      decoration: inputDecoration(hint: 'Where was I?'),
    );
  }

  TextFormField actionField({required int index}) {
    return TextFormField(
      controller: actionControllers[index],
      decoration: inputDecoration(hint: 'What was I doing?'),
    );
  }

  TextFormField triggerField({required int index}) {
    return TextFormField(
      controller: triggerControllers[index],
      decoration: inputDecoration(hint: 'What triggered me?'),
    );
  }

  TextFormField behaviorField({required int index}) {
    return TextFormField(
      controller: behaviourControllers[index],
      decoration:
          inputDecoration(hint: 'What did I do? What actions did I take?'),
    );
  }

  TextFormField consequenceField({required int index}) {
    return TextFormField(
      controller: consequenceControllers[index],
      decoration: inputDecoration(hint: 'What were the consequences?'),
    );
  }

  void clearData() {
    setState(() {
      pindx = 0;
      plindx = 0;
      aindx = 0;
      tindx = 0;
      bindx = 0;
      cindx = 0;
    });
    name.clear();
    date.clear();
    time.clear();

    /// clear lists
    personControllers.clear();
    placeControllers.clear();
    actionControllers.clear();
    triggerControllers.clear();
    consequenceControllers.clear();
    behaviourControllers.clear();

    ///
    persons.clear();
    place.clear();
    action.clear();
    trigger.clear();
    behaviour.clear();
    consequence.clear();

    ///
    addFields();
  }

  final bool edit = Get.arguments[0];

  final Rx<RAModel> _rootAnalysis = RAModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  setData(DateTime end) async {
    _rootAnalysis.value.title = name.text;
    _rootAnalysis.value.date = currentTime.text;
    _rootAnalysis.value.time = time.text;
    _rootAnalysis.value.cdate = date.text;
    _rootAnalysis.value.precedent = check;
    _rootAnalysis.value.persons = <String>[];
    for (int i = 0; i < personControllers.length; i++) {
      _rootAnalysis.value.persons!.add(personControllers[i].text);
    }
    _rootAnalysis.value.actions = <String>[];
    for (int i = 0; i < actionControllers.length; i++) {
      _rootAnalysis.value.actions!.add(actionControllers[i].text);
    }
    _rootAnalysis.value.places = <String>[];
    for (int i = 0; i < placeControllers.length; i++) {
      _rootAnalysis.value.places!.add(placeControllers[i].text);
    }
    _rootAnalysis.value.behaviors = <String>[];
    for (int i = 0; i < behaviourControllers.length; i++) {
      _rootAnalysis.value.behaviors!.add(behaviourControllers[i].text);
    }
    _rootAnalysis.value.triggers = <String>[];
    for (int i = 0; i < triggerControllers.length; i++) {
      _rootAnalysis.value.triggers!.add(triggerControllers[i].text);
    }
    _rootAnalysis.value.consequences = <String>[];
    for (int i = 0; i < consequenceControllers.length; i++) {
      _rootAnalysis.value.consequences!.add(consequenceControllers[i].text);
    }
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _rootAnalysis.value.duration = _rootAnalysis.value.duration! + diff;
    } else {
      _rootAnalysis.value.duration = diff;
    }
  }

  Future addAnalysis([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _root.currentState!.save();
    if (_root.currentState!.validate()) {
      loadingDialog(context);
      final end = DateTime.now();
      setData(end);
      if (edit) _rootAnalysis.value.id = generateId();
      await erRef.doc(_rootAnalysis.value.id).set(_rootAnalysis.value.toMap());
      await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<ErController>().history.value.value == 79) {
          Get.find<ErController>()
              .updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      Get.back();
      customToast(message: 'Added successfully');
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
        id: _rootAnalysis.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future updateAnalysis([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _root.currentState!.save();
    if (_root.currentState!.validate()) {
      loadingDialog(context);
      final end = DateTime.now();
      setData(end);
      await erRef
          .doc(_rootAnalysis.value.id)
          .update(_rootAnalysis.value.toMap());
      if (!fromsave) Get.back();
      Get.back();
      customToast(message: 'Added successfully');
    }
  }

  fetchData() {
    _rootAnalysis.value = Get.arguments[1] as RAModel;
    name.text = _rootAnalysis.value.title!;
    currentTime.text = _rootAnalysis.value.date!;
    date.text = _rootAnalysis.value.cdate!;
    time.text = _rootAnalysis.value.time!;
    check = _rootAnalysis.value.precedent!;
    persons.clear();
    place.clear();
    action.clear();
    trigger.clear();
    behaviour.clear();
    consequence.clear();
    personControllers.clear();
    placeControllers.clear();
    actionControllers.clear();
    triggerControllers.clear();
    consequenceControllers.clear();
    behaviourControllers.clear();
    setState(() {
      pindx = 0;
      plindx = 0;
      aindx = 0;
      tindx = 0;
      bindx = 0;
      cindx = 0;
    });
    for (int i = 0; i < _rootAnalysis.value.persons!.length; i++) {
      pindx = i;
      personControllers.add(
        TextEditingController(
          text: _rootAnalysis.value.persons![i],
        ),
      );
      persons.add(personsField(index: pindx));
    }
    for (int i = 0; i < _rootAnalysis.value.places!.length; i++) {
      plindx = i;
      placeControllers.add(
        TextEditingController(
          text: _rootAnalysis.value.places![i],
        ),
      );
      place.add(placeField(index: plindx));
    }
    for (int i = 0; i < _rootAnalysis.value.actions!.length; i++) {
      aindx = i;
      actionControllers.add(
        TextEditingController(
          text: _rootAnalysis.value.actions![i],
        ),
      );
      action.add(actionField(index: aindx));
    }
    for (int i = 0; i < _rootAnalysis.value.behaviors!.length; i++) {
      bindx = i;
      behaviourControllers.add(
        TextEditingController(
          text: _rootAnalysis.value.behaviors![i],
        ),
      );
      behaviour.add(behaviorField(index: bindx));
    }
    for (int i = 0; i < _rootAnalysis.value.triggers!.length; i++) {
      tindx = i;
      triggerControllers.add(
        TextEditingController(
          text: _rootAnalysis.value.triggers![i],
        ),
      );
      trigger.add(triggerField(index: tindx));
    }
    for (int i = 0; i < _rootAnalysis.value.consequences!.length; i++) {
      cindx = i;
      consequenceControllers.add(
        TextEditingController(
          text: _rootAnalysis.value.consequences![i],
        ),
      );
      consequence.add(consequenceField(index: cindx));
    }
  }
}

class PreviousAnalysis extends StatelessWidget {
  const PreviousAnalysis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(implyLeading: true, title: '', actions: []),
      body: StreamBuilder(
        initialData: const [],
        stream: erRef
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
              final RAModel model = RAModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const AbcRootAnalysis(),
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
