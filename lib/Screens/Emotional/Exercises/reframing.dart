// ignore_for_file: avoid_print, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/er_models.dart';
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
import '../../../Widgets/custom_images.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../app_icons.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';

class Reframing extends StatefulWidget {
  const Reframing({Key? key}) : super(key: key);

  @override
  _ReframingState createState() => _ReframingState();
}

class _ReframingState extends State<Reframing> {
  final _reframing = GlobalKey<FormState>();
  List<TextEditingController> thoughtController = <TextEditingController>[];
  List<TextEditingController> evidenceController = <TextEditingController>[];
  List<TextEditingController> againstController = <TextEditingController>[];
  List<TextEditingController> reframedController = <TextEditingController>[];
  TextEditingController name = TextEditingController();
  List<int> options = <int>[];
  List<int> distortion = <int>[];
  List<int> actual = <int>[];
  List<int> reframed = <int>[];
  List<Column> thoughts = <Column>[];
  int idx = 0;

  TextEditingController currentTime = TextEditingController();

  addThought() {
    setState(() {
      options.add(0);
      distortion.add(0);
      actual.add(0);
      reframed.add(0);
      TextEditingController _controller = TextEditingController();
      thoughtController.add(_controller);
      TextEditingController _control = TextEditingController();
      evidenceController.add(_control);
      TextEditingController _controlled = TextEditingController();
      againstController.add(_controlled);
      TextEditingController _controler = TextEditingController();
      reframedController.add(_controler);
      thoughts.add(thoughtElements(index: idx));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    addThought();
    setState(() {
      name.text = 'ReframingCognitiveDistortions&NegativeThoughts${formatTitelDate(DateTime.now()).trim()}';
      currentTime.text = formateDate(DateTime.now());
      if (edit) fetchData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(leading: backButton(), implyLeading: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: _reframing,
          child: Column(
            children: [
              verticalSpace(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextWidget(
                    text:
                        'Reframing Cognitive Distortions &\n Negative Thoughts (Practice)',
                    weight: FontWeight.bold,
                    alignment: Alignment.center,
                  ),
                  IconButton(
                    onPressed: () => Get.to(
                      () => ReadingScreen(
                        title:
                            'ER105- Reframing Cognitive Distortions and Negative Thoughts',
                        link:
                            'https://docs.google.com/document/d/1h2vTz0qNkkKZpIQueQg5ee-KyVPmidXs/',
                        linked: () => Get.back(),
                        function: () {
                          if (Get.find<ErController>().history.value.value ==
                              89) {
                                 final end = DateTime.now();
                            debugPrint('disposing');
                            Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
                            debugPrint('disposed');
                          }
                          Get.log('closed');
                        },
                      ),
                    ),
                    //  () => Get.to(
                    //   () => const ER105Reading(),
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
                save: () async => edit
                    ? await updateReframing(true)
                    : await addReframing(true),
                drive: () => Get.off(() => const PreviousReframing()),
              ),

              ///1
              verticalSpace(height: 15),
              Column(
                children: [
                  const TextWidget(
                    text:
                        'This worksheet gives you a space to objectively analyze your thoughts and challenge them in 5 simple steps. ',
                    weight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  verticalSpace(height: 20),
                  const TextWidget(
                    text:
                        '1) Identify any automatic negative thoughts, self-judgments, and/or negative predictions you made.',
                    fontStyle: FontStyle.italic,
                  ),
                  verticalSpace(height: 20),
                  const TextWidget(
                    text:
                        '2) Analyze your thoughts for validity. Are they facts or opinions? How much do you believe in those thoughts?',
                    fontStyle: FontStyle.italic,
                  ),
                  verticalSpace(height: 20),
                  const TextWidget(
                    text:
                        '3) Identify any cognitive distortions your thought may have.',
                    fontStyle: FontStyle.italic,
                  ),
                  verticalSpace(height: 20),
                  const TextWidget(
                    text:
                        '4) Write down the objective evidence for and against your thought. Weigh this evidence carefully.',
                    fontStyle: FontStyle.italic,
                  ),
                  verticalSpace(height: 20),
                  const TextWidget(
                    text:
                        '5) Reframe your thought as a more realistic/ rational thought based on the evidence you considered above. Then, re-rate your belief in your original thought.',
                    fontStyle: FontStyle.italic,
                  ),
                  verticalSpace(height: 20),
                ],
              ),

              ///
              // Column(children: thoughts),
              Column(
                children: [
                  for (int i = 0; i < thoughts.length; i++)
                    thoughtElements(index: i),
                ],
              ),

              ///
              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      print(idx);
                      idx = idx + 1;
                      print(idx);
                    });
                    addThought();
                  },
                  icon: const Icon(Icons.add, color: Colors.black),
                  label: const TextWidget(text: 'Add Thought'),
                ),
              ),

              ///
              verticalSpace(height: Get.height * 0.1),
              BottomButtons(
                button1: 'Done',
                button2: 'Save',
                onPressed1: () async =>
                    edit ? await updateReframing() : await addReframing(),
                onPressed2: () async => await addReframing(true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column thoughtElements({required int index}) {
    return Column(
      children: [
        TextFormField(
          controller: thoughtController[index],
          decoration: inputDecoration(hint: 'Thought'),
        ),
        Row(
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: options[index],
                onChanged: (val) {
                  setState(() {
                    options[index] = val!;
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
            SizedBox(
              // width: Get.width * 0.55,
              child: CustomDropDownStruct(
                child: DropdownButton(
                  value: distortion[index],
                  onChanged: (val) {
                    setState(() {
                      distortion[index] = val!;
                    });
                  },
                  items: distortionList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.value,
                          child: SizedBox(
                            width: Get.width * 0.46,
                            child: TextWidget(
                              text: e.title,
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            CustomDropDownStruct(
              child: DropdownButton(
                value: actual[index],
                onChanged: (val) {
                  setState(() {
                    actual[index] = val!;
                    print(actual[index]);
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
                controller: evidenceController[index],
                decoration: inputDecoration(hint: 'Evidence for your thought'),
              ),
            ),
            SizedBox(
              width: Get.width * 0.47,
              child: TextFormField(
                maxLines: 8,
                controller: againstController[index],
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
                controller: reframedController[index],
                decoration: inputDecoration(
                  hint: 'Reframed/ realistic thought',
                ),
              ),
            ),
            CustomDropDownStruct(
              height: 50,
              child: DropdownButton(
                value: reframed[index],
                onChanged: (val) {
                  setState(() {
                    reframed[index] = val!;
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

  clearData() {
    setState(() {
      idx = 0;
      thoughts.clear();
      name.clear();
      thoughtController.clear();
      evidenceController.clear();
      againstController.clear();
      reframedController.clear();
      options.clear();
      actual.clear();
      reframed.clear();
      distortion.clear();

      ///
      addThought();
    });
  }

  final bool edit = Get.arguments[0];

  final Rx<ReframingModel> _reframeing = ReframingModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();

  setData(DateTime end) {
    _reframeing.value.title = name.text;
    _reframeing.value.date = currentTime.text;
    _reframeing.value.thoughts = <ReframingEvent>[];
    for (int i = 0; i < thoughtController.length; i++) {
      _reframeing.value.thoughts!.add(
        ReframingEvent(
          distortion: distortion[i],
          actualBelief: actual[i],
          evidencAgainst: againstController[i].text,
          evidence: evidenceController[i].text,
          option: options[i],
          reframed: reframedController[i].text,
          reframedBelief: reframed[i],
          thought: thoughtController[i].text,
        ),
      );
    }
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _reframeing.value.duration = _reframeing.value.duration! + diff;
    } else {
      _reframeing.value.duration = diff;
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
        id: _reframeing.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addReframing([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _reframing.currentState!.save();
    if (_reframing.currentState!.validate()) {
      loadingDialog(context);
      final end = DateTime.now();
      setData(end);
      if (edit) _reframeing.value.id = generateId();
      await erRef.doc(_reframeing.value.id).set(_reframeing.value.toMap());
      await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<ErController>().history.value.value == 90) {
          erRef
              .where('userid', isEqualTo: Get.find<AuthServices>().userid)
              .where('type', isEqualTo: 7)
              .get()
              .then((value) {
            if (value.docs.isNotEmpty) {
              if (value.docs.length >= 3) {
                Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
              }
            }
          });
        }
        Get.back();
      }
      Get.back();
      customToast(message: 'Added successfully');
    }
  }

  Future updateReframing([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _reframing.currentState!.save();
    if (_reframing.currentState!.validate()) {
      loadingDialog(context);
      final end = DateTime.now();
      setData(end);
      await erRef.doc(_reframeing.value.id).update(_reframeing.value.toMap());
      if (!fromsave) Get.back();
      Get.back();
      customToast(message: 'Updated successfully');
    }
  }

  fetchData() {
    _reframeing.value = Get.arguments[1] as ReframingModel;
    name.text = _reframeing.value.title!;
    currentTime.text = _reframeing.value.date!;
    options.clear();
    distortion.clear();
    actual.clear();
    reframed.clear();
    thoughtController.clear();
    evidenceController.clear();
    againstController.clear();
    reframedController.clear();
    thoughts.clear();
    for (int i = 0; i < _reframeing.value.thoughts!.length; i++) {
      final ReframingEvent _event = _reframeing.value.thoughts![i];
      addThought();
      options[i] = _event.option!;
      distortion[i] = _event.distortion!;
      actual[i] = _event.actualBelief!;
      reframed[i] = _event.reframedBelief!;
      thoughtController[i].text = _event.thought!;
      evidenceController[i].text = _event.evidence!;
      againstController[i].text = _event.evidencAgainst!;
      reframedController[i].text = _event.reframed!;
    }
  }
}

class PreviousReframing extends StatelessWidget {
  const PreviousReframing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(implyLeading: true, title: '', actions: []),
      body: StreamBuilder(
        initialData: const [],
        stream: erRef
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
              final ReframingModel model =
                  ReframingModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () =>
                      Get.to(() => const Reframing(), arguments: [true, model]),
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
