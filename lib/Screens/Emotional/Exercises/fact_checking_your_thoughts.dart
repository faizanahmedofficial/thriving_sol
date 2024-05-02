// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Screens/Emotional/er_home.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/drop_down_button.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../../Model/app_user.dart';
import '../../../Model/er_models.dart';
import '../../../Widgets/custom_images.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../app_icons.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';

class FactCheckingYourThoughts extends StatefulWidget {
  const FactCheckingYourThoughts({Key? key}) : super(key: key);

  @override
  _FactCheckingYourThoughtsState createState() =>
      _FactCheckingYourThoughtsState();
}

class _FactCheckingYourThoughtsState extends State<FactCheckingYourThoughts> {
  final _key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  List<TextEditingController> thoughtController = <TextEditingController>[];
  List<int> feelingsList = <int>[];
  List<int> beliefs = <int>[];
  List<Row> thoughts = <Row>[];
  List<int> opinionList = <int>[];
  int indx = 0;
  int feeling = 0;
  int emotion = 0;
  TextEditingController currentTime = TextEditingController();

  void addThought() {
    TextEditingController _thought = TextEditingController();
    thoughtController.add(_thought);
    feelingsList.add(feeling);
    beliefs.add(emotion);
    opinionList.add(0);
    thoughts.add(thoughtWidget(index: indx));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      addThought();
      name.text =
          'FactCheckingYourThoughts${formatTitelDate(DateTime.now()).trim()}';
      currentTime.text = formateDate(DateTime.now());
      if (edit) fetchData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(leading: backButton(), implyLeading: true),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomButtons(
          button1: 'Done',
          button2: 'Save',
          onPressed2: () async => await addThoughts(true),
          onPressed1: () async =>
              edit ? await updateThoughts() : await addThoughts(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: _key,
          child: Column(
            children: [
              verticalSpace(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: TextWidget(
                      text: 'Fact Checking Your Thoughts (Practice)',
                      weight: FontWeight.bold,
                      alignment: Alignment.center,
                    ),
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
                            Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
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
                controller: name,
                label: 'Name',
                add: () => clearData(),
                save: () async =>
                    edit ? await updateThoughts(true) : await addThoughts(true),
                drive: () => Get.off(() => const PreviousThought()),
              ),

              ///1
              verticalSpace(height: 15),
              const TextWidget(
                text:
                    'This worksheet gives you a space to identify your thoughts and challenge them. What was your thought? What was going through my mind at that time?”, “What was my self-talk like at the time? “ Identify any automatic negative self-judgments and/or negative predictions you made.',
                fontStyle: FontStyle.italic,
              ),

              ///4
              verticalSpace(height: 30),
              const TextWidget(
                text: 'Fact or Opinion?',
                size: 17,
                weight: FontWeight.bold,
              ),
              verticalSpace(height: 15),
              const TextWidget(
                text:
                    'Write down your thoughts, whether they are facts or opinions, and rate your belief in this thought from 1-10.',
                size: 15,
                weight: FontWeight.bold,
              ),

              ///
              Column(
                children: [
                  for (int i = 0; i < thoughts.length; i++)
                    thoughtWidget(index: i).marginOnly(top: 7),
                ],
              ),

              ///
              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      indx = indx + 1;
                    });
                    addThought();
                  },
                  icon: const Icon(Icons.add, color: Colors.black),
                  label: const TextWidget(text: 'Add Thought'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row thoughtWidget({required int index}) {
    return Row(
      children: [
        SizedBox(
          width: width * 0.55,
          child: TextFormField(
            controller: thoughtController[index],
            decoration: inputDecoration(hint: 'Thought'),
          ),
        ),
        CustomDropDownStruct(
          height: 47,
          child: DropdownButton(
            value: opinionList[index],
            onChanged: (val) {
              setState(() {
                opinionList[index] = val;
              });
            },
            items: optionList
                .map((e) => DropdownMenuItem(
                      value: e.value,
                      child: TextWidget(
                        text: e.title,
                        alignment: Alignment.centerLeft,
                      ),
                    ))
                .toList(),
          ),
        ),
        CustomDropDownStruct(
          height: 47,
          child: DropdownButton<int>(
            value: beliefs[index],
            onChanged: (val) {
              setState(() {
                beliefs[index] = val!;
              });
            },
            items: beliefList
                .map(
                  (e) => DropdownMenuItem(
                    value: e.value,
                    child: TextWidget(
                      text: e.title,
                      size: 13,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  void clearData() {
    setState(() {
      indx = 0;
      emotion = 0;
      feeling = 0;
    });
    name.clear();
    thoughtController.clear();
    thoughts.clear();
    feelingsList.clear();
    beliefs.clear();
    opinionList.clear();

    ///
    addThought();
  }

  final bool edit = Get.arguments[0];
  final Rx<FcyModel> _thoughts = FcyModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();

  setData(DateTime end) async {
    _thoughts.value.title = name.text;
    _thoughts.value.date = currentTime.text;
    _thoughts.value.thoughts = <FCEvent>[];
    for (int i = 0; i < thoughtController.length; i++) {
      _thoughts.value.thoughts!.add(
        FCEvent(
          thought: thoughtController[i].text,
          option: opinionList[i],
          belief: beliefs[i],
        ),
      );
    }
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _thoughts.value.duration = _thoughts.value.duration! + diff;
    } else {
      _thoughts.value.duration = diff;
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
        id: _thoughts.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addThoughts([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      loadingDialog(context);
      final end = DateTime.now();
      setData(end);
      if (edit) _thoughts.value.id = generateId();
      await erRef.doc(_thoughts.value.id).set(_thoughts.value.toMap());
      await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<ErController>().history.value.value == 84) {
          Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      Get.back();
      customToast(message: 'Added successfully');
    }
  }

  Future updateThoughts([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      loadingDialog(context);
      final end = DateTime.now();
      setData(end);
      await erRef.doc(_thoughts.value.id).update(_thoughts.value.toMap());
      if (!fromsave) Get.back();
      Get.back();
      customToast(message: 'Updated successfully');
    }
  }

  fetchData() {
    _thoughts.value = Get.arguments[1] as FcyModel;
    name.text = _thoughts.value.title!;
    currentTime.text = _thoughts.value.date!;
    thoughtController.clear();
    thoughts.clear();
    feelingsList.clear();
    opinionList.clear();
    beliefs.clear();
    for (int i = 0; i < _thoughts.value.thoughts!.length; i++) {
      final FCEvent _event = _thoughts.value.thoughts![i];
      addThought();
      thoughtController[i].text = _event.thought!;
      opinionList[i] = _event.option!;
      beliefs[i] = _event.belief!;
    }
  }
}

class PreviousThought extends StatelessWidget {
  const PreviousThought({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(implyLeading: true, title: '', actions: []),
      body: StreamBuilder(
        initialData: const [],
        stream: erRef
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
              final FcyModel model =
                  FcyModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const FactCheckingYourThoughts(),
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
