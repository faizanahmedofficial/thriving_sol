// ignore_for_file: no_leading_underscores_for_local_identifiers, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Model/er_models.dart';
import 'package:schedular_project/Screens/Emotional/er_home.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/drop_down_button.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';

import '../../../Common/bottom_buttons.dart';
import '../../../Model/app_user.dart';
import '../../../Widgets/custom_images.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../app_icons.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';

class CognitiveController extends GetxController {
  TextEditingController currentTime = TextEditingController();
  TextEditingController name = TextEditingController();
  RxInt right = 0.obs;
  RxInt filtering = 0.obs;
  RxInt personalization = 0.obs;
  RxInt statements = 0.obs;
  RxInt fortune = 0.obs;
  RxInt mreading1 = 0.obs;
  RxInt magnification = 0.obs;
  RxInt er = 0.obs;
  RxInt glabeling = 0.obs;
  RxInt fallacy = 0.obs;
  RxInt generalization = 0.obs;
  RxInt bwthinking = 0.obs;
  RxInt sjumping = 0.obs;
  RxInt mreading = 0.obs;
  RxInt faireness = 0.obs;
  RxInt hreward = 0.obs;
  RxInt control = 0.obs;
  RxInt blaming = 0.obs;

  void clear() {
    index.value = 0;
    name.clear();
    right.value = 0;
    filtering.value = 0;
    personalization.value = 0;
    statements.value = 0;
    fortune.value = 0;
    mreading1.value = 0;
    magnification.value = 0;
    er.value = 0;
    glabeling.value = 0;
    fallacy.value = 0;
    generalization.value = 0;
    bwthinking.value = 0;
    sjumping.value = 0;
    mreading.value = 0;
    faireness.value = 0;
    hreward.value = 0;
    control.value = 0;
    blaming.value = 0;
  }

  @override
  void onInit() {
    name.text = 'IdentifyingCognitiveDistortionsInYourself${formatTitelDate(DateTime.now()).trim()}';
    currentTime.text = formateDate(DateTime.now());
    if (edit) fetchData();
    super.onInit();
  }

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;
  previousIndex() => index.value = index.value - 1;

  final bool edit = Get.arguments[0];

  final Rx<CDModel> _cognitive = CDModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  final formkey = GlobalKey<FormState>();
  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _cognitive.value.title = name.text;
    _cognitive.value.date = currentTime.text;
    _cognitive.value.event = CDEvent(
      beingRight: right.value,
      mentalFiltering: filtering.value,
      personalization: personalization.value,
      shouldStatements: statements.value,
      fortuneTelling: fortune.value,
      mindRead: mreading1.value,
      magnification: magnification.value,
      emotionalReasoning: er.value,
      globalLabeling: glabeling.value,
      fallacyOfChange: fallacy.value,
      overgeneralization: generalization.value,
      blackThinking: bwthinking.value,
      jumpingConclusions: sjumping.value,
      mindReading: mreading.value,
      heavenReward: hreward.value,
      controlFallacy: control.value,
      blaming: blaming.value,
      fallacyofFairness: faireness.value,
    );
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _cognitive.value.duration = _cognitive.value.duration! + diff;
    } else {
      _cognitive.value.duration = diff;
    }
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((element) => element.id == 'er');
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: name.text,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _cognitive.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addDistortion([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    formkey.currentState!.save();
    if (formkey.currentState!.validate()) {
      loadingDialog(Get.context!);
      final end = DateTime.now();
      setData(end);
      if (edit) _cognitive.value.id = generateId();
      await erRef.doc(_cognitive.value.id).set(_cognitive.value.toMap());
      await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<ErController>().history.value.value == 88) {
          Get.find<ErController>()
              .updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      Get.back();
      customToast(message: 'Saved successfully');
    }
  }

  Future updateDistortion([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    formkey.currentState!.save();
    if (formkey.currentState!.validate()) {
      loadingDialog(Get.context!);
      final end = DateTime.now();
      setData(end);
      await erRef.doc(_cognitive.value.id).update(_cognitive.value.toMap());
      if (!fromsave) Get.back();
      Get.back();
      customToast(message: 'Updated successfully');
    }
  }

  fetchData() {
    _cognitive.value = Get.arguments[1] as CDModel;
    name.text = _cognitive.value.title!;
    currentTime.text = _cognitive.value.date!;
    final CDEvent _event = _cognitive.value.event!;
    right.value = _event.beingRight!;
    filtering.value = _event.mentalFiltering!;
    personalization.value = _event.personalization!;
    statements.value = _event.shouldStatements!;
    fortune.value = _event.fortuneTelling!;
    mreading1.value = _event.mindRead!;
    magnification.value = _event.magnification!;
    er.value = _event.emotionalReasoning!;
    glabeling.value = _event.globalLabeling!;
    fallacy.value = _event.fallacyOfChange!;
    generalization.value = _event.overgeneralization!;
    bwthinking.value = _event.blackThinking!;
    sjumping.value = _event.jumpingConclusions!;
    mreading.value = _event.mindReading!;
    hreward.value = _event.heavenReward!;
    control.value = _event.controlFallacy!;
    blaming.value = _event.blaming!;
    faireness.value = _event.fallacyofFairness!;
  }
}

class PreviousDistortions extends StatelessWidget {
  const PreviousDistortions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(implyLeading: true, title: '', actions: []),
      body: StreamBuilder(
        initialData: const [],
        stream: erRef
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
              final CDModel model = CDModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const CognitiveDistortion(),
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

class CognitiveDistortion extends StatefulWidget {
  const CognitiveDistortion({Key? key}) : super(key: key);

  @override
  _CognitiveDistortionState createState() => _CognitiveDistortionState();
}

class _CognitiveDistortionState extends State<CognitiveDistortion> {
  final CognitiveController _cognitive = Get.put(CognitiveController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(
            leading: backButton(
              () => _cognitive.index.value == 0
                  ? Get.back()
                  : _cognitive.previousIndex(),
            ),
            implyLeading: true),
        bottomNavigationBar:
            _cognitive.index.value == 0 || _cognitive.index.value == 2
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () => _cognitive.updateIndex(),
                        icon: const Icon(Icons.last_page_outlined,
                            color: Colors.black),
                      ),
                    ],
                  )
                : SizedBox(
                    height: 70,
                    child: _cognitive.index.value == 3
                        ? BottomButtons(
                            button1: 'Done',
                            button2: 'Save',
                            onPressed2: () async =>
                                await _cognitive.addDistortion(true),
                            onPressed1: () async => _cognitive.edit
                                ? await _cognitive.updateDistortion()
                                : await _cognitive.addDistortion(),
                            onPressed3: () => _cognitive.previousIndex(),
                          )
                        : BottomButtons(
                            button1: 'See Results',
                            button2: 'Save',
                            onPressed1: () => _cognitive.updateIndex(),
                            onPressed2: () async => _cognitive.edit
                                ? await _cognitive.updateDistortion(true)
                                : await _cognitive.addDistortion(true),
                            onPressed3: () => _cognitive.previousIndex(),
                          ),
                  ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _cognitive.formkey,
            child: Column(
              children: [
                verticalSpace(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: TextWidget(
                        text:
                            'Identifying Cognitive Distortions in Yourself (Test)',
                        weight: FontWeight.bold,
                        alignment: Alignment.center,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.to(
                        () => ReadingScreen(
                          title: 'ER104- Cognitive Distortion',
                          link:
                              'https://docs.google.com/document/d/1tN5NgA8DM7RN92B2FOTcrftjrf1nkUKs/',
                          linked: () => Get.back(),
                          function: () {
                            if (Get.find<ErController>().history.value.value ==
                                87) {
                              final end = DateTime.now();
                              debugPrint('disposing');
                              Get.find<ErController>().updateHistory(
                                  end.difference(_cognitive.initial).inSeconds);
                              debugPrint('disposed');
                            }
                            Get.log('closed');
                          },
                        ),
                      ),
                      // () => Get.to(
                      //   () => const ER104Reading(),
                      // ),
                      icon: assetImage(AppIcons.read),
                    ),
                  ],
                ),
                verticalSpace(height: 10),
                JournalTop(
                  controller: _cognitive.name,
                  label: 'Name',
                  add: () => _cognitive.clear(),
                  save: () async => _cognitive.edit
                      ? await _cognitive.updateDistortion(true)
                      : await _cognitive.addDistortion(true),
                  drive: () => Get.off(() => const PreviousDistortions()),
                ),
                verticalSpace(height: 15),
                Center(
                  child: TextFormField(
                    controller: _cognitive.currentTime,
                    readOnly: true,
                    onTap: () {
                      customDatePicker(
                        context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      ).then((value) {
                        setState(() {
                          _cognitive.currentTime.text = formateDate(value);
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
                _cognitive.index.value == 0
                    ? page1()
                    : _cognitive.index.value == 1
                        ? page2()
                        : _cognitive.index.value == 2
                            ? page3()
                            : _cognitive.index.value == 3
                                ? page4()
                                : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget page4() {
    return Column(
      children: [
        verticalSpace(height: 15),
        verticalSpace(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.fallacy.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.fallacy.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Fallacy of Change:  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You expect others should and will change to suit your needs especially if you pressure or push them enough'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///2
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.generalization.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.generalization.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Overgeneralization: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'You draw general conclusions based solely on a single or on limited pieces of information or experience.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///3
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.bwthinking.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.bwthinking.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Black and white thinking:  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You take an all or nothing approach with no room for middle ground.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///1
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.sjumping.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.sjumping.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'SJumping to conclusions: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You draw conclusions with no or very poor evidence.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///2
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.mreading.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.mreading.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Mind reading: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'You know what people will do before they do it or you know what people are feeling and thinking without asking them.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///3
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.faireness.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.faireness.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Fallacy of fairness  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You think life should be fair. You may feel angry, anxious, sad, or experience other heightened emotions when life is not fair.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///1
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.hreward.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.hreward.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Heaven\'s Reward:  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'our expect that "the universe/ God" will reward you in this lifetime with tangible benefits.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///2
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.control.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.control.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Control Fallacy:   ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'You feel like you have control over the inner world of others such as taking responsibility for someone else\'s emotions or you feel that other people and circumstances have control over your life, actions and/or feelings.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///3
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.blaming.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.blaming.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Blaming:   ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'Blaming: You blame others for your own emotional state or situation. You blame yourself for other peoples\' emotional states or situations.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget page3() {
    return Column(
      children: [
        verticalSpace(height: 15),
        verticalSpace(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.right.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.right.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Always being right: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You try to be right at all costs, even at the cost of the emotions of your loved ones. You may feel as if there is an ongoing battle for supremacy.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///2
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.filtering.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.filtering.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Mental filtering: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'You selectively focus on negative details of the situation and that colors your whole perception of the situation.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///3
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.personalization.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.personalization.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Personalization: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'Personalization: You blame yourself for events out of your control or take things personally that aren\'t related to you.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///1
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.statements.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.statements.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Should statements: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You tell yourself that you should, shouldn\'t, or ought to do things.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///2
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.mreading1.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.mreading1.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Mind reading: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'You know what people will do before they do it or you know what people are feeling and thinking without asking them.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///3
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.fortune.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.fortune.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Fortune Telling:  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You think things will turn out badly and accept your prediction as the most likely outcome.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///1
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.magnification.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.magnification.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Magnification and minimization: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You exaggerate the importance of inconsequential events or discount the importance of consequential events skewing your perception.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///2
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.er.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.er.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Emotional reasoning:  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'You feel a certain way therefore it must be true. You think that your emotions reflect reality. You could feel fat, worthless, or be angry at someone for no logical reason other than you just "feel" that way.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///3
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.glabeling.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.glabeling.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Global labeling:  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You describe and encompass the totality of a unique human or group in just one word, usually a superlative. For example, I am stupid. I am worthless. He is an idiot. What a piece of s***. I\'m a loser. Everyone from that country is stinky. Finance guys are all scumbags.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget page2() {
    return Column(
      children: [
        verticalSpace(height: 15),
        verticalSpace(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.fallacy.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.fallacy.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Fallacy of Change:  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You expect others should and will change to suit your needs especially if you pressure or push them enough'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///2
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.generalization.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.generalization.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Overgeneralization: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'You draw general conclusions based solely on a single or on limited pieces of information or experience.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///3
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.bwthinking.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.bwthinking.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Black and white thinking:  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You take an all or nothing approach with no room for middle ground.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///1
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.sjumping.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.sjumping.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'SJumping to conclusions: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You draw conclusions with no or very poor evidence.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///2
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.mreading.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.mreading.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Mind reading: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'You know what people will do before they do it or you know what people are feeling and thinking without asking them.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///3
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.faireness.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.faireness.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Fallacy of fairness  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You think life should be fair. You may feel angry, anxious, sad, or experience other heightened emotions when life is not fair.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///1
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.hreward.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.hreward.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Heaven\'s Reward:  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'our expect that "the universe/ God" will reward you in this lifetime with tangible benefits.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///2
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.control.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.control.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Control Fallacy:   ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'You feel like you have control over the inner world of others such as taking responsibility for someone else\'s emotions or you feel that other people and circumstances have control over your life, actions and/or feelings.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///3
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.blaming.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.blaming.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Blaming:   ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'Blaming: You blame others for your own emotional state or situation. You blame yourself for other peoples\' emotional states or situations.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget page1() {
    return Column(
      children: [
        ///1
        verticalSpace(height: 15),
        verticalSpace(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.right.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.right.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Always being right: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You try to be right at all costs, even at the cost of the emotions of your loved ones. You may feel as if there is an ongoing battle for supremacy.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///2
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.filtering.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.filtering.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Mental filtering: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'You selectively focus on negative details of the situation and that colors your whole perception of the situation.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///3
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.personalization.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.personalization.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Personalization: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'Personalization: You blame yourself for events out of your control or take things personally that aren\'t related to you.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///1
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.statements.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.statements.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Should statements: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You tell yourself that you should, shouldn\'t, or ought to do things.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///2
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.mreading1.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.mreading1.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Mind reading: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'You know what people will do before they do it or you know what people are feeling and thinking without asking them.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///3
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.fortune.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.fortune.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Fortune Telling:  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You think things will turn out badly and accept your prediction as the most likely outcome.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///1
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.magnification.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.magnification.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Magnification and minimization: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You exaggerate the importance of inconsequential events or discount the importance of consequential events skewing your perception.'),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///2
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.er.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.er.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Emotional reasoning:  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'You feel a certain way therefore it must be true. You think that your emotions reflect reality. You could feel fat, worthless, or be angry at someone for no logical reason other than you just "feel" that way.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        ///3
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomDropDownStruct(
              child: DropdownButton(
                value: _cognitive.glabeling.value,
                onChanged: (val) {
                  setState(() {
                    _cognitive.glabeling.value = val!;
                  });
                },
                items: frequencyList
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
              width: Get.width * 0.6,
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
                      text: 'Global labeling:  ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                            'You describe and encompass the totality of a unique human or group in just one word, usually a superlative. For example, I am stupid. I am worthless. He is an idiot. What a piece of s***. I\'m a loser. Everyone from that country is stinky. Finance guys are all scumbags.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
