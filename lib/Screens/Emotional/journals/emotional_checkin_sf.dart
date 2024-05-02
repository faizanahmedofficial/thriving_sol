// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/er_models.dart';
import 'package:schedular_project/Screens/Emotional/er_home.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_button.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';

import '../../../Common/bottom_buttons.dart';
import '../../../Common/journal_top.dart';
import '../../../Constants/constants.dart';
import '../../../Functions/date_picker.dart';
import '../../../Functions/functions.dart';
import '../../../Model/app_user.dart';
import '../../../Theme/input_decoration.dart';
import '../../../Widgets/custom_images.dart';
import '../../../Widgets/drop_down_button.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../Widgets/spacer_widgets.dart';
import '../../../Widgets/text_widget.dart';
import '../../../app_icons.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';

class EsfController extends GetxController {
  RxBool relax = false.obs;
  RxBool confident = false.obs;
  RxBool obsryourself = false.obs;
  RxBool level = false.obs;

  RxInt observe = 9.obs;

  TextEditingController name = TextEditingController();
  TextEditingController currentTime = TextEditingController();

  clearData() {
    index.value = 0;
    relax.value = false;
    confident.value = false;
    observe.value = 10;
    obsryourself.value = false;
    level.value = false;
    name.clear();
    thought.clear();
    actualBelief.clear();
    reframed.clear();
    reframedBelief.clear();
    emotions.clear();
    strength.clear();
    resolution.clear();
  }

  @override
  void onInit() {
    name.text = 'ERJournalLevel1EmotionalCheckInShortForm${formatTitelDate(DateTime.now()).trim()}';
    currentTime.text = formateDate(DateTime.now());
    addEmotion();
    addThought();
    if (edit) fetchData();
    super.onInit();
  }

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;

  final formKey = GlobalKey<FormState>();
  final bool edit = Get.arguments[0];

  RxList<TextEditingController> emotions = <TextEditingController>[].obs;
  RxList<int> strength = <int>[].obs;

  RxList<TextEditingController> thought = <TextEditingController>[].obs;
  RxList<int> actualBelief = <int>[].obs;
  RxList<TextEditingController> reframed = <TextEditingController>[].obs;
  RxList<int> reframedBelief = <int>[].obs;

  TextEditingController resolution = TextEditingController();

  void addEmotion() {
    emotions.add(TextEditingController());
    strength.add(0);
  }

  void addThought() {
    thought.add(TextEditingController());
    actualBelief.add(0);
    reframed.add(TextEditingController());
    reframedBelief.add(0);
  }

  final Rx<EmotionalSfModel> _emotional = EmotionalSfModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;
  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _emotional.value.title = name.text;
    _emotional.value.date = currentTime.text;
    _emotional.value.resolution = resolution.text;
    _emotional.value.stress = observe.value;
    _emotional.value.check = EmotionalChecks(
      relaxation: relax.value,
      confident: confident.value,
      observeYourself: obsryourself.value,
      yourlevel: level.value,
    );
    _emotional.value.emotions = <EmotionsModel>[];
    for (int i = 0; i < emotions.length; i++) {
      _emotional.value.emotions!.add(
        EmotionsModel(emotion: emotions[i].text, strength: strength[i]),
      );
    }
    _emotional.value.thoughts = <EThoughtModel>[];
    for (int i = 0; i < thought.length; i++) {
      _emotional.value.thoughts!.add(
        EThoughtModel(
          thought: thought[i].text,
          actualBelief: actualBelief[i],
          reframed: reframed[i].text,
          reframedBelief: reframedBelief[i],
        ),
      );
    }
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

  Future addEmotionalCheckin([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      loadingDialog(Get.context!);
       final end = DateTime.now();
      setData(end);
      if (edit) _emotional.value.id = generateId();
      await erRef.doc(_emotional.value.id).set(_emotional.value.toMap());
      await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<ErController>().history.value.value == 77) {
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
        } else if (Get.find<ErController>().history.value.value == 76) {
          Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      Get.back();
      customToast(message: 'Added successfully');
    }
  }

  previousIndex() => index.value = index.value - 1;

  Future updateEmotionalCheckin([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
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
    _emotional.value = Get.arguments[1] as EmotionalSfModel;
    name.text = _emotional.value.title!;
    currentTime.text = _emotional.value.date!;
    observe.value = _emotional.value.stress!;
    resolution.text = _emotional.value.resolution!;
    final EmotionalChecks _check = _emotional.value.check!;
    relax.value = _check.relaxation!;
    confident.value = _check.confident!;
    obsryourself.value = _check.observeYourself!;
    level.value = _check.yourlevel!;
    emotions.clear();
    strength.clear();
    for (int i = 0; i < _emotional.value.emotions!.length; i++) {
      final EmotionsModel _emotion = _emotional.value.emotions![i];
      addEmotion();
      emotions[i].text = _emotion.emotion!;
      strength[i] = _emotion.strength!;
    }
    thought.clear();
    actualBelief.clear();
    reframed.clear();
    reframedBelief.clear();
    for (int i = 0; i < _emotional.value.thoughts!.length; i++) {
      final EThoughtModel _thought = _emotional.value.thoughts![i];
      addThought();
      thought[i].text = _thought.thought!;
      actualBelief[i] = _thought.actualBelief!;
      reframed[i].text = _thought.reframed!;
      reframedBelief[i] = _thought.reframedBelief!;
    }
  }
}

class EmotionalCheckInSf extends StatefulWidget {
  const EmotionalCheckInSf({Key? key}) : super(key: key);

  @override
  State<EmotionalCheckInSf> createState() => _EmotionalCheckInSfState();
}

class _EmotionalCheckInSfState extends State<EmotionalCheckInSf> {
  final EsfController _controller = Get.put(EsfController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(
          leading: backButton(
            () => _controller.index.value == 0
                ? Get.back()
                : _controller.previousIndex(),
          ),
          implyLeading: true,
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomButtons(
            button1: _controller.index.value == 0 ? 'Continue' : 'Done',
            button2: 'Save',
            onPressed1: _controller.index.value == 0
                ? () => _controller.updateIndex()
                : () async => _controller.edit
                    ? _controller.updateEmotionalCheckin()
                    : _controller.addEmotionalCheckin(),
            onPressed2: () async => _controller.addEmotionalCheckin(true),
            onPressed3: () => _controller.index.value != 0
                ? _controller.previousIndex()
                : Get.back(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Form(
            key: _controller.formKey,
            child: Column(
              children: [
                verticalSpace(height: 10),
                Row(
                  children: [
                    const TextWidget(
                      text:
                          'ER Journal Level 1 - \nEmotional Check-In Short Form (Practice)',
                      weight: FontWeight.bold,
                      alignment: Alignment.center,
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
                              Get.find<ErController>().updateHistory(end.difference(_controller.initial).inSeconds);
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
                  controller: _controller.name,
                  label: 'Name',
                  add: () => _controller.clearData(),
                  save: () async => _controller.edit
                      ? _controller.updateEmotionalCheckin(true)
                      : _controller.addEmotionalCheckin(true),
                  drive: () => Get.off(() => const EcsfPrevious()),
                ),
                verticalSpace(height: 5),
                _controller.index.value == 0
                    ? page1()
                    : _controller.index.value == 1
                        ? page2()
                        : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget page2() {
    return Column(
      children: [
        const TextWidget(text: 'Emotions', weight: FontWeight.bold, size: 16)
            .marginOnly(bottom: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width * 0.6,
              child: const TextWidget(
                  text: 'What were/ are you feeling?', size: 12),
            ),
            const TextWidget(text: 'Strength of Emotion', size: 11),
          ],
        ),
        Column(
          children: List.generate(
            _controller.emotions.length,
            (index) => emotionWidget(index),
          ),
        ),
        CustomIconTextButton(
          text: 'Add Emotion',
          onPressed: () => _controller.addEmotion(),
        ).marginOnly(bottom: height * 0.15),
        const TextWidget(text: 'Thoughts', weight: FontWeight.bold, size: 16)
            .marginOnly(bottom: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width * 0.68,
              child: const TextWidget(
                text:
                    'What were/ are you thinking right before you had a change in emotion or behavior?',
              ),
            ),
            const TextWidget(text: 'Belief (1-10)'),
          ],
        ),
        Column(
          children: List.generate(
            _controller.thought.length,
            (index) => thoughtWidget(index),
          ),
        ),
        CustomIconTextButton(
          text: 'Add Thought',
          onPressed: () => _controller.addThought(),
        ).marginOnly(bottom: height * 0.15),
        const TextWidget(text: 'Resolution', weight: FontWeight.bold, size: 16)
            .marginOnly(bottom: 7),
        const TextWidget(
          text:
              'What would be the simplest and easiest way to change the outcome positively? ',
        ),
        TextFormField(
          controller: _controller.resolution,
          maxLines: 3,
          decoration: inputDecoration(hint: 'Simple & easy solution'),
        ),
      ],
    );
  }

  Widget emotionWidget(int index) {
    return Row(
      children: [
        SizedBox(
          width: width * 0.6,
          child: TextFormField(
            controller: _controller.emotions[index],
            decoration: inputDecoration(hint: 'Emotion', radius: 0),
          ),
        ),
        CustomDropDownStruct(
          height: 47,
          child: DropdownButton(
            value: _controller.strength[index],
            onChanged: (val) {
              setState(() {
                _controller.strength[index] = val;
              });
            },
            items: emotionList
                .map((e) => DropdownMenuItem(
                      value: e.value,
                      child: SizedBox(
                        width: width * 0.21,
                        child: TextWidget(
                          text: e.title,
                          alignment: Alignment.centerLeft,
                          size: 12,
                          maxline: 1,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget thoughtWidget(int index) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: width * 0.75,
              child: TextFormField(
                controller: _controller.thought[index],
                decoration: inputDecoration(hint: 'Thought', radius: 0),
              ),
            ),
            CustomDropDownStruct(
              height: 47,
              child: DropdownButton(
                value: _controller.actualBelief[index],
                onChanged: (val) {
                  setState(() {
                    _controller.actualBelief[index] = val;
                  });
                },
                items: beliefList
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
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: width * 0.75,
              child: TextFormField(
                controller: _controller.reframed[index],
                decoration: inputDecoration(
                  hint: 'Reframed/ realistic thought',
                  radius: 0,
                ),
              ),
            ),
            CustomDropDownStruct(
              height: 47,
              child: DropdownButton(
                value: _controller.reframedBelief[index],
                onChanged: (val) {
                  setState(() {
                    _controller.reframedBelief[index] = val;
                  });
                },
                items: beliefList
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
              'This is your time to check in with yourself. Take a slow, deep breath. Sit up straight, put your shoulders back, and observe yourself like you would a loved one.  How stressed are/ were you? What are / were you thinking? What emotions are/were you feeling?',
          fontStyle: FontStyle.italic,
          weight: FontWeight.bold,
          textAlign: TextAlign.center,
          alignment: Alignment.center,
        ),
        verticalSpace(height: 15),
        Center(
          child: TextFormField(
            controller: _controller.currentTime,
            readOnly: true,
            onTap: () {
              customDatePicker(
                context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              ).then((value) {
                setState(() {
                  _controller.currentTime.text = formateDate(value);
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
        verticalSpace(height: 10),

        ///
        const CheckboxRichText(),

        ///
        verticalSpace(height: 15),
        const TextWidget(
          text: 'What was/ is your stress level?',
          weight: FontWeight.bold,
        ),
        Obx(
          () => Align(
            alignment: Alignment.topLeft,
            child: CustomDropDownStruct(
              child: DropdownButton(
                value: _controller.observe.value,
                onChanged: (val) {
                  setState(() {
                    _controller.observe.value = val;
                  });
                },
                items: observeList
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.value,
                        child: TextWidget(
                          text: e.title,
                          alignment: Alignment.centerLeft,
                          size: 13.5,
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
}

class CheckboxRichText extends StatefulWidget {
  const CheckboxRichText({Key? key}) : super(key: key);

  @override
  _CheckboxRichTextState createState() => _CheckboxRichTextState();
}

class _CheckboxRichTextState extends State<CheckboxRichText> {
  final EsfController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: _controller.relax.value,
                onChanged: (val) {
                  setState(() {
                    _controller.relax.value = val!;
                    print('pressed');
                  });
                },
              ),
              checkboxRichText(
                'Induce a relaxation response.',
                'Take a deep breath in through your nose and breathe out as slowly as you can without straining either through your mouth or nose. Focus on following the sensation of your breath moving through your body. Feel the air moving in and out of your body. Feel the exact area of your body the air is touching at this moment. ',
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: _controller.confident.value,
                onChanged: (val) {
                  setState(() {
                    _controller.confident.value = val!;
                    print('pressed');
                  });
                },
              ),
              checkboxRichText(
                'Induce a confident state.',
                'Sit or stand up straight. Puff your chest out slightly, move your shoulders back, and put your chin up just a little bit. When you do this your body naturally signals to your brain that you are feeling confident.',
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: _controller.obsryourself.value,
                onChanged: (val) {
                  setState(() {
                    _controller.obsryourself.value = val!;
                    print('pressed');
                  });
                },
              ),
              checkboxRichText(
                'Impartially observe yourself.',
                'Observe yourself simply as you are in this exact moment. View yourself in the present moment and feel compassion for yourself and anyone else present. Observe yourself and the situation without judgment as an impartial 3rd party. Will this matter in 5 years? ',
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: _controller.level.value,
                onChanged: (val) {
                  setState(() {
                    _controller.level.value = val!;
                    print('pressed');
                  });
                },
              ),
              checkboxRichText(
                'Find your level.',
                'Pause. Excuse yourself from the area if you feel the need to. How stressed are you on a scale from 1-10 where Level 1 is feeling wonderful and Level 10 is considered very stressed. Find your level and accept it.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EcsfPrevious extends StatelessWidget {
  const EcsfPrevious({Key? key}) : super(key: key);

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
            .where('type', isEqualTo: 10)
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
              final EmotionalSfModel model =
                  EmotionalSfModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const EmotionalCheckInSf(),
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
