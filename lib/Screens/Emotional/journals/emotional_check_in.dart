// ignore_for_file: no_leading_underscores_for_local_identifiers, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Model/er_models.dart';
import 'package:schedular_project/Screens/Emotional/er_home.dart';
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
import '../../../Model/app_user.dart';
import '../../../Widgets/custom_images.dart';
import '../../../Widgets/drop_down_button.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../app_icons.dart';
import '../../readings.dart';

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
    evidenceController.clear();
    options.clear();
    againstController.clear();
    addEmotion();
    addThought();
  }

  @override
  void onInit() {
    name.text = 'ERJournalLevel2EmotionalCheckin${formatTitelDate(DateTime.now()).trim()}';
    currentTime.text = formateDate(DateTime.now());
    addEmotion();
    addThought();
    if (edit) fetchData();
    super.onInit();
  }

  final page1 = GlobalKey<FormState>();

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;

  void addEmotion() {
    TextEditingController _emotion = TextEditingController();
    emotionController.add(_emotion);
    emotionList.add(1);
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
    TextEditingController _controller = TextEditingController();
    thoughtController.add(_controller);
    TextEditingController _control = TextEditingController();
    evidenceController.add(_control);
    TextEditingController _controlled = TextEditingController();
    againstController.add(_controlled);
    TextEditingController _controler = TextEditingController();
    reframedController.add(_controler);
  }

  TextEditingController easy = TextEditingController();
  TextEditingController matters = TextEditingController();
  TextEditingController advice = TextEditingController();
  TextEditingController steps = TextEditingController();

  final bool edit = Get.arguments[0];
  final Rx<ECIModel> _emotional = ECIModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
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
          distortion: distortion[i],
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
        .where((value) => value.id ==er);
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
        if (Get.find<ErController>().history.value.value == 76) {
          Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
        } else if (Get.find<ErController>().history.value.value == 77) {
          RxInt count = 0.obs;
          await erRef
              .where('userid', isEqualTo: Get.find<AuthServices>().userid)
              .where('type', isEqualTo: 10)
              .get()
              .then((value) {
            if (value.docs.isNotEmpty) {
              count.value = count.value + value.docs.length;
            }
          });
          await erRef
              .where('userid', isEqualTo: Get.find<AuthServices>().userid)
              .where('type', isEqualTo: 11)
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
    _emotional.value = Get.arguments[1] as ECIModel;
    name.text = _emotional.value.title!;
    currentTime.text = _emotional.value.date!;
    stressLevel.value = _emotional.value.stress!;
    emotionController.clear();
    emotionList.clear();
    for (int i = 0; i < _emotional.value.emotions!.length; i++) {
      final EmotionsModel _emotion = _emotional.value.emotions![i];
      addEmotion();
      emotionController[i].text = _emotion.emotion!;
      emotionList[i] = _emotion.strength!;
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
      final ReframingEvent _thought = _emotional.value.thoughts![i];
      addThought();
      thoughtController[i].text = _thought.thought!;
      evidenceController[i].text = _thought.evidence!;
      againstController[i].text = _thought.evidencAgainst!;
      reframedController[i].text = _thought.reframed!;
      options[i] = _thought.option!;
      distortion[i] = _thought.distortion!;
      actual[i] = _thought.actualBelief!;
      reframed[i] = _thought.reframedBelief!;
    }
    final ResolutionModel _resolution = _emotional.value.resolution!;
    easy.text = _resolution.solution!;
    matters.text = _resolution.fiveYears!;
    advice.text = _resolution.advice!;
    steps.text = _resolution.alternative!;
  }

  previousIndex() => index.value = index.value - 1;
}

class ECIPrevious extends StatelessWidget {
  const ECIPrevious({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'ER Journal Level 1 - Emotional Check-In ',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: erRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 11)
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
              final ECIModel model =
                  ECIModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const EmotionalCheckIn(),
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

class EmotionalCheckIn extends StatefulWidget {
  const EmotionalCheckIn({Key? key}) : super(key: key);

  @override
  _EmotionalCheckInState createState() => _EmotionalCheckInState();
}

class _EmotionalCheckInState extends State<EmotionalCheckIn> {
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
            button1: _check.index.value == 5 ? 'Done' : 'Continue',
            button2: 'Save',
            onPressed2: () async => await _check.addECI(true),
            onPressed1: _check.index.value == 5
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
                  children: [
                    const Expanded(
                      child: TextWidget(
                        text:
                            'ER Journal Level 1 - \nEmotional Check-In (Practice)',
                        weight: FontWeight.bold,
                        alignment: Alignment.center,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.to(
                        () => ReadingScreen(
                          title:
                              'ER101- Emotional Check-In and Limiting Damage',
                          link:
                              'https://docs.google.com/document/d/1ZkupifvNrMxLfJuCZKrVewEwx269xGHs/',
                          linked: () => Get.back(),
                          function: () {
                            if (Get.find<ErController>().history.value.value ==
                                73) {
                                   final end = DateTime.now();
                              debugPrint('disposing');
                              Get.find<ErController>().updateHistory(end.difference(_check.initial).inSeconds);
                              debugPrint('disposed');
                            }
                            Get.log('closed');
                          },
                        ),
                      ),
                      // () => Get.to(() => const ER101Reading()),
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
                                ? page4()
                                : _check.index.value == 4
                                    ? page5()
                                    : _check.index.value == 5
                                        ? page6()
                                        : Container(),
              ],
            ),
          ),
        ),
      ),
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
            SizedBox(
              // width: Get.width * 0.55,
              child: CustomDropDownStruct(
                child: DropdownButton(
                  value: _check.distortion[index],
                  onChanged: (val) {
                    setState(() {
                      _check.distortion[index] = val!;
                    });
                  },
                  items: distortionList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.value,
                          child: SizedBox(
                            width: Get.width * 0.45,
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
