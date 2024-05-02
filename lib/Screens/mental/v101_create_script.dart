// ignore_for_file: prefer_final_fields, avoid_print, no_leading_underscores_for_local_identifiers, library_private_types_in_public_api

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Functions/text_to_speech_converter.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/visualization_model.dart';
import 'package:schedular_project/Screens/mental/visualization_home.dart';
import 'package:schedular_project/Theme/buttons_theme.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/custom_images.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/checkboxes.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/drop_down_button.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../Controller/user_controller.dart';
import '../../Model/app_user.dart';
import '../../Services/auth_services.dart';
import '../../Widgets/expansion_tiles.dart';
import '../../Widgets/progress_indicator.dart';
import '../../app_icons.dart';
import '../custom_bottom.dart';
import '../readings.dart';

class PreviousCreatedScripts extends StatelessWidget {
  const PreviousCreatedScripts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: 'Previous Scripts', implyLeading: true),
      body: StreamBuilder(
        initialData: const [],
        stream: scriptRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 'visualization')
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: progressIndicator());
          } else if (snapshot.data.docs.isEmpty) {
            return const TextWidget(
              text: 'No previous scripts to show',
              alignment: Alignment.center,
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                final ScriptModel _data =
                    ScriptModel.fromMap(snapshot.data.docs[index]);
                return InkWell(
                  onTap: () => Get.to(
                    () => const V101CreateScript(),
                    arguments: [true, _data],
                  ),
                  child: Card(
                    elevation: 1,
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: ListTile(
                      title: TextWidget(
                        text: _data.title!,
                        size: 17,
                        weight: FontWeight.bold,
                      ),
                      subtitle: TextWidget(
                          text: scriptOption[optionsIndex(_data.option ?? 0)]
                              .title),
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget scriptWidget(
      {required String title, required String body, double padding = 8.0}) {
    return subcontentWidget(
      title: title,
      children: [expansionText(text: body, padding: padding)],
    );
  }

  Widget newlayersWidget(CheckModel senses) {
    return Column(
      children: [
        Row(
          children: [
            CustomCheckBox(
              value: senses.sight,
              onChanged: null,
              title: 'Visual (sight)',
            ),
            CustomCheckBox(
              value: senses.hearing,
              onChanged: null,
              title: 'Auditory (hearing)',
            ),
          ],
        ),
        Row(
          children: [
            CustomCheckBox(
              value: senses.touch,
              onChanged: null,
              title: 'Tactile (touch)',
            ),
            CustomCheckBox(
              value: senses.music,
              onChanged: null,
              title: 'Kinesthetic (music)',
            ),
          ],
        ),
        Row(
          children: [
            CustomCheckBox(
              value: senses.taste,
              onChanged: null,
              title: 'Gustatory (taste)',
            ),
            CustomCheckBox(
              value: senses.smell,
              onChanged: null,
              title: 'Olfactory (smell)',
            ),
          ],
        ),
        Row(
          children: [
            CustomCheckBox(
              value: senses.vperspective,
              onChanged: null,
              title: 'Visual Perspective',
            ),
            CustomCheckBox(
              value: senses.viewAngle,
              onChanged: null,
              title: 'Viewing Angle',
            ),
          ],
        ),
        CustomCheckBox(
            value: senses.emotional, onChanged: null, title: 'Emotional'),
      ],
    );
  }
}

class V101CreateScript extends StatefulWidget {
  const V101CreateScript({Key? key}) : super(key: key);

  @override
  _V101CreateScriptState createState() => _V101CreateScriptState();
}

class _V101CreateScriptState extends State<V101CreateScript> {
  final GlobalKey<FormState> _createScript = GlobalKey<FormState>();
  final GlobalKey<FormState> _createScript2 = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController topic = TextEditingController();
  TextEditingController goal = TextEditingController();
  TextEditingController steps = TextEditingController();
  TextEditingController detailed = TextEditingController();
  TextEditingController currentTime = TextEditingController();
  int option = 0;
  int index = 0;
  bool sight = false;
  bool hearing = false;
  bool touch = false;
  bool music = false;
  bool taste = false;
  bool smell = false;
  bool vperspective = false;
  bool vangle = false;
  bool _emotional = false;

  ScriptModel _script = ScriptModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
    type: 'visualization',
  );

  bool edit = Get.arguments[0];

  Future loadData() async {
    setState(() {
      ScriptModel _model = Get.arguments[1];
      _script = _model;
      // _script.id = _model.id;
      // _script.created = _model.created;
      // _script.userid = _model.userid;
      // _script.type = _model.type;
      Get.find<UserController>().link.value = _model.link!;
      name.text = _model.title!;
      topic.text = _model.topic!;
      goal.text = _model.goal!;
      steps.text = _model.steps!;
      detailed.text = _model.detail!;
      option = _model.option!;
      CheckModel _checks = _model.checks!;
      sight = _checks.sight!;
      hearing = _checks.hearing!;
      touch = _checks.touch!;
      music = _checks.music!;
      taste = _checks.taste!;
      smell = _checks.smell!;
      vperspective = _checks.vperspective!;
      vangle = _checks.viewAngle!;
      _emotional = _checks.emotional!;
    });
  }

  addNew() async {
    index = 0;
    name.clear();
    topic.clear();
    goal.clear();
    steps.clear();
    detailed.clear();
    currentTime.clear();
    option = 0;
    sight = false;
    hearing = false;
    touch = false;
    music = false;
    taste = false;
    smell = false;
    vperspective = false;
    vangle = false;
    _emotional = false;
    setState(() {});
  }

  setBasics([bool fromdetail = false]) {
    setState(() {
      _script.option = option;
      _script.title = name.text;
      _script.topic = topic.text;
      _script.goal = goal.text;
      _script.steps = steps.text;
      if (fromdetail == false) {
        if (edit) {
          if (_script.option != option) _setDetailedScripts(option);
        } else {
          _setDetailedScripts(option);
        }
      }
    });
  }

  _setDetailedScripts(int option) {
    switch (option) {
      case 0:
        break;
      case 1:
        detailed.text =
            'As I get ready to ${topic.text} feel a sense of [emotion] deep within me. I am in [setting] and as I look around I see [sights] and I can smell the distinct aroma of [smells] in the air. My ears perk up as the sound of [sounds] fill my ears and my mouth and tongue even can taste [tastes]. I can feel [tactile]. Inside of my body I can feel [kinesthetic]. My mind and body are completely focused on ${topic.text} as I prepare to do [first step].\nI see myself from behind my own eyes doing [first step] and feel [emotions], see [sights],smell [smells], hear [sounds], taste [tastes], feel [tactile], and feel [kinesthetic]. I see myself from a 3rd person perspective at angle of [angle 1] and perform [first step]. I feel [emotions], see [sights], smell [smells], hear [sounds], taste [tastes], feel [tactile], and feel [kinesthetic]. I see myself from a 3rd person perspective at angle of [angle 2] and perform [first step]. I feel [emotions], see [sights], smell [smells], hear [sounds], taste [tastes], feel [tactile], and feel [kinesthetic]. I see myself from a 3rd person perspective at angle of [angle3] and perform [first step]. I feel [emotions], see [sights], smell [smells], hear [sounds], taste [tastes], feel [tactile], and feel [kinesthetic].\nI see myself from behind my own eyes doing [2nd step] and feel [emotions], see [sights], smell [smells], hear [sounds], taste [tastes], feel [tactile], and feel [kinesthetic]. I see myself from a 3rd person perspective at angle of [angle 1] and perform [2nd step]. I feel [emotions], see [sights], smell [smells], hear [sounds], taste [tastes], feel [tactile], and feel [kinesthetic].\n I see myself from a 3rd person perspective at angle of [angle 2] and perform [2nd step]. I feel [emotions], see [sights], smell [smells], hear [sounds], taste [tastes], feel [tactile], and feel [kinesthetic]. I see myself from a 3rd person perspective at angle of [angle3] and perform [2nd step]. I feel [emotions], see [sights], smell [smells], hear [sounds], taste [tastes], feel [tactile], and feel [kinesthetic].\nI see myself from behind my own eyes doing [3rd step] and feel [emotions], see [sights], smell [smells], hear [sounds], taste [tastes], feel [tactile], and feel [kinesthetic]. I see myself from a 3rd person perspective at angle of [angle 1] and perform [3rd step]. I feel [emotions], see [sights], smell [smells], hear [sounds], taste [tastes], feel [tactile], and feel [kinesthetic]. I see myself from a 3rd person perspective at angle of [angle 2] and perform [3rd step]. I feel [emotions], see [sights], smell [smells], hear [sounds], taste [tastes], feel [tactile], and feel [kinesthetic]. I see myself from a 3rd person perspective at angle of [angle3] and perform [3rd step]. I feel [emotions], see [sights], smell [smells], hear [sounds], taste [tastes], feel [tactile], and feel [kinesthetic].';
        break;
      case 2:
        detailed.text =
            'I\'m in [environment] feeling [preferred feeling] with [preferred people] doing [preferred activity]. My mindstate is [mind state] as I see [sights], hear [sounds], smell [aromas], taste [tastes], and feel [tactile sensations].';
        break;
      case 3:
        detailed.text =
            'I wake up at [time] and feel [preferred feeling]. I start my morning routine by [activities in morning routine]. My mind and body are now functioning at their optimal levels and I am in a peak state ready to face anything.\nI [do habits in my personal system] and know I’m moving forward. I feel [preferred emotion] and think about my [deepest whys] and know I’m doing exactly what I need and want to. As I wind down I begin my evening routine. [Evening routine]. I feel relaxed and confident about tomorrow.';
        break;
      case 4:
        detailed.text =
            'I see myself in [environment] after finishing [chain] at [time] and encounter [visual cues], [audio cues], [other sensory cues] creating an aching need to spring into action. I have prepared further by [default option], and [simplification]. I recall [deepest why] and know without a doubt I’m doing the right thing. [Common obstacles] will try to thwart me, but I will overcome by [contingency plan].';
        break;
      case 5:
        detailed.text =
            'I encounter [trigger(s)]. I feel [emotion] welling up within me. I see the face of [loved one] smiling compassionately at me as they look directly into my eyes then reach forward and [place a hand on my shoulder OR give me a hug]. I ask myself, “What humor can I find in this situation?” and laugh. I ask myself, “What can I learn from this experience?” and realize this is an opportunity for me to be better. I ask myself, “What advice would I give a loved one in this same situation?” and “Will this matter in 6 months’ time?” giving me a detached birds’ eye perspective. With a cool and calm mind, I deliberate on the matter and decide what is the easiest and most beneficial way to resolve the matter. Once I’ve decided I ask myself, ”Does this decision align with my values and goals?” giving me the answer I need to take action. I take action with full confidence in myself. I celebrate by [celebration]. I [receive short term reward] and feel proud.';
        break;
    }
  }

  DateTime initial = DateTime.now();
  setDetail(DateTime end) {
    setBasics(true);
    _script.detail = detailed.text;
    print(_script.detail);
    _script.link = Get.find<AuthServices>().link;
    _script.checks = CheckModel(
      sight: sight,
      hearing: hearing,
      smell: smell,
      viewAngle: vangle,
      vperspective: vperspective,
      emotional: _emotional,
      taste: taste,
      music: music,
      touch: touch,
    );
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _script.duration = _script.duration! + diff;
    } else {
      _script.duration = diff;
    }
    setState(() {});
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == visualization);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: name.text,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _script.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future _addScriptToFirebase([bool fromsave = false]) async {
    final end = DateTime.now();
    setDetail(end);
    if (edit) _script.id = generateId();
    await scriptRef.doc(_script.id).set(_script.toMap());
    await addAccomplishment(end);
    if (!fromsave) {
      if (Get.find<VisualizationController>().history.value.value == 28) {
        Get.find<VisualizationController>()
            .updateHistory(end.difference(initial).inSeconds);
      }
    }
    if (!fromsave) Get.back();
    customToast(message: 'Visualization created successfully');
  }

  Future _updateScript([bool fromsave = false]) async {
    final end = DateTime.now();
    setDetail(end);
    await scriptRef.doc(_script.id).update(_script.toMap());
    if (!fromsave) Get.back();
    customToast(message: 'Visualization updated successfully');
  }

  Future addtoCalendar() async {
    final Event event = Event(
      title: name.text,
      description: detailed.text,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 2)),
    );
    await Add2Calendar.addEvent2Cal(event).then((value) {
      if (value) {
        customToast(message: 'Visualization added to calendar successfully');
      }
    });
  }

  @override
  void initState() {
    name.text = 'CreateYourScript${formatTitelDate(DateTime.now()).trim()}';
    currentTime.text = formateDate(DateTime.now());
    if (Get.find<VisualizationController>().history.value.value == 32) {
      option = 4;
    } else if (Get.find<VisualizationController>().history.value.value == 33) {
      option = 2;
    } else if (Get.find<VisualizationController>().history.value.value == 34) {
      option = 3;
    }
    topic.text = scriptOption[scriptOptionIndex(option)].title;
    if (edit) loadData();
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    Get.find<UserController>().link.value = '';

    super.dispose();
  }

  previousIndex() {
    setState(() {
      index = index - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        leading: backButton(() => index == 0 ? Get.back() : previousIndex()),
        implyLeading: true,
      ),
      bottomNavigationBar: index == 1
          ? SizedBox(
              height: 70,
              child: BottomButtons(
                onPressed1: () async => {
                  Get.focusScope!.unfocus(),
                  _createScript2.currentState!.save(),
                  if (_createScript2.currentState!.validate())
                    {
                      edit
                          ? await _updateScript()
                          : await _addScriptToFirebase(),
                    }
                },
                onPressed2: () async => await addtoCalendar(),
                button2: 'Add to Calendar',
                b2: width * 0.39,
                b1: width * 0.25,
                onPressed3: () {
                  setState(() {
                    index = 0;
                  });
                },
              ),
            )
          : Container(
              height: 40,
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.5,
                    child: OutlinedButton(
                      style: outlineButton(),
                      onPressed: () {
                        Get.focusScope!.unfocus();
                        _createScript.currentState!.save();
                        if (_createScript.currentState!.validate()) {
                          setBasics();
                          index = 1;
                          setState(() {});
                        }
                      },
                      child: const TextWidget(
                        text: 'Continue',
                        alignment: Alignment.center,
                        size: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.4,
                    child: OutlinedButton(
                      onPressed: () async => await _addScriptToFirebase(true),
                      style: outlineButton(),
                      child: const TextWidget(
                        text: 'Save',
                        alignment: Alignment.center,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            verticalSpace(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextWidget(
                  text: 'Creating your Script (Practice)',
                  weight: FontWeight.bold,
                  alignment: Alignment.center,
                ),
                IconButton(
                  onPressed: () => Get.to(
                    () => ReadingScreen(
                      title: 'V101- Creating your script',
                      link:
                          'https://docs.google.com/document/d/1MENpf_8xxQ6UWtGBlon8uNkJ6sKxMAZW/',
                      linked: () => Get.off(
                        () => const V101CreateScript(),
                        arguments: [false],
                      ),
                      function: () {
                        if (Get.find<VisualizationController>()
                                .history
                                .value
                                .value ==
                            25) {
                          final end = DateTime.now();
                          debugPrint('disposing');
                          Get.find<VisualizationController>()
                              .updateHistory(end.difference(initial).inSeconds);
                          debugPrint('disposed');
                        }
                        Get.log('closed');
                      },
                    ),
                  ),
                  // Get.to(
                  //   () => const CreateYourScriptReading(),
                  // ),
                  icon: assetImage(AppIcons.read),
                ),
              ],
            ),
            verticalSpace(height: 10),
            JournalTop(
              controller: name,
              label: 'Name your script',
              add: () async => await addNew(),
              save: () async => await _addScriptToFirebase(true),
              drive: () => Get.off(() => const PreviousCreatedScripts()),
            ),
            verticalSpace(height: 20),
            index == 0
                ? Form(
                    key: _createScript,
                    child: Column(
                      children: [
                        const TextWidget(
                          text:
                              'Would you like to use the Fill-In-The-Blank visualization script creator which will automatically fill in the bulk of your script and allow you to edit and customize it? If so, for what topic?',
                        ).marginOnly(bottom: 10),
                        CustomDropDownStruct(
                          width: width,
                          height: 50,
                          child: DropdownButton(
                              value: option,
                              onChanged: (val) {
                                setState(() {
                                  option = val;
                                  topic.text =
                                      scriptOption[scriptOptionIndex(option)]
                                          .title;
                                });
                              },
                              items: scriptOption
                                  .map((e) => DropdownMenuItem(
                                        value: e.value,
                                        child: TextWidget(
                                          text: e.title,
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ))
                                  .toList()),
                        ).marginOnly(bottom: 40),
                        const TextWidget(
                          text: 'What is the topic of your visualization?',
                        ).marginOnly(bottom: 10),
                        TextFormField(
                          controller: topic,
                          decoration:
                              inputDecoration(hint: 'Topic of Visualization'),
                          // validator: (val) {
                          //   if (val!.isEmpty) {
                          //     return '*Required';
                          //   }
                          //   return null;
                          // },
                        ),
                        verticalSpace(height: 10),
                        const TextWidget(
                          text:
                              'What do you hope to achieve by practicing this visualization?',
                        ).marginOnly(bottom: 10),
                        TextFormField(
                          controller: goal,
                          decoration:
                              inputDecoration(hint: 'Goals of Visualization'),
                          // validator: (val) {
                          //   if (val!.isEmpty) {
                          //     return '*Required';
                          //   }
                          //   return null;
                          // },
                        ),
                        verticalSpace(height: 10),
                        const TextWidget(
                          text:
                              'Write out the broad strokes. What are the main steps?',
                        ).marginOnly(bottom: 10),
                        TextFormField(
                          controller: steps,
                          maxLines: 7,
                          decoration: inputDecoration(
                            hint:
                                '1st Step- Align Feet, 2nd Step- Correct stance',
                          ),
                          // validator: (val) {
                          //   if (val!.isEmpty) {
                          //     return '*Required';
                          //   }
                          //   return null;
                          // },
                        ),
                        verticalSpace(height: 30),
                      ],
                    ),
                  )
                : Form(
                    key: _createScript2,
                    child: Column(
                      children: [
                        const TextWidget(
                          text: 'Detailed Script',
                          size: 16,
                          weight: FontWeight.bold,
                        ).marginOnly(bottom: 20),
                        const TextWidget(
                          text:
                              'Write your highly detailed script in the space provided. Think about the minor details like your viewing angle. Remember to evoke powerful emotions, feel all five senses, and associate positive emotions with wanted behaviors.',
                          size: 12,
                          fontStyle: FontStyle.italic,
                        ).marginOnly(bottom: 10),
                        TextFormField(
                          controller: detailed,
                          maxLines: 20,
                          decoration: inputDecoration(
                            hint: 'Write our detailed script here',
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Deatailed script is required';
                            }
                            return null;
                          },
                        ),
                        verticalSpace(height: 10),

                        /// checklist
                        verticalSpace(height: 20),
                        const TextWidget(
                          text: 'Visualization Checklist',
                          weight: FontWeight.bold,
                          size: 16,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomCheckBox(
                                  value: sight,
                                  onChanged: (value) {
                                    setState(() {
                                      sight = value;
                                    });
                                  },
                                  title: 'Visual (sight)',
                                  width: Get.width * 0.45,
                                ),
                                CustomCheckBox(
                                  value: hearing,
                                  onChanged: (value) {
                                    setState(() {
                                      hearing = value;
                                    });
                                  },
                                  title: 'Auditory (hearing)',
                                  width: Get.width * 0.45,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomCheckBox(
                                  value: touch,
                                  onChanged: (value) {
                                    setState(() {
                                      touch = value;
                                    });
                                  },
                                  title: 'Tactile (touch)',
                                  width: Get.width * 0.4,
                                ),
                                CustomCheckBox(
                                  value: music,
                                  onChanged: (value) {
                                    setState(() {
                                      music = value;
                                    });
                                  },
                                  title: 'Kinesthetic (movement)',
                                  width: Get.width * 0.5,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomCheckBox(
                                  value: taste,
                                  onChanged: (value) {
                                    setState(() {
                                      taste = value;
                                    });
                                  },
                                  title: 'Gustatory (taste)',
                                  width: Get.width * 0.45,
                                ),
                                CustomCheckBox(
                                  value: smell,
                                  onChanged: (value) {
                                    setState(() {
                                      smell = value;
                                    });
                                  },
                                  title: 'Olfactory (smell)',
                                  width: Get.width * 0.45,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomCheckBox(
                                  value: vperspective,
                                  onChanged: (value) {
                                    setState(() {
                                      vperspective = value;
                                    });
                                  },
                                  title: 'Visual perspective',
                                  width: Get.width * 0.5,
                                ),
                                CustomCheckBox(
                                  value: vangle,
                                  onChanged: (value) {
                                    setState(() {
                                      vangle = value;
                                    });
                                  },
                                  title: 'Viewing Angle',
                                  width: Get.width * 0.4,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomCheckBox(
                                  value: _emotional,
                                  onChanged: (value) {
                                    setState(() {
                                      _emotional = value;
                                    });
                                  },
                                  title: 'Emotional',
                                  width: Get.width * 0.45,
                                ),
                              ],
                            ),
                          ],
                        ),

                        ///
                        verticalSpace(height: 20),
                        Container(
                          width: Get.width,
                          height: 70,
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0, style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              _createScript2.currentState!.save();
                              if (_createScript2.currentState!.validate()) {
                                loadingDialog(context);
                                await convertToAudio(
                                  detailed.text,
                                  filename: name.text,
                                  firebasepath:
                                      'Create Your Scripts/Audio/${Get.find<AuthServices>().userid}',
                                  loader: true,
                                  option: true,
                                );
                              } else {
                                customToast(
                                  message: 'Script name and detail is required',
                                );
                              }
                            },
                            child: const TextWidget(
                              size: 15,
                              text: 'Create Your Visualization Audio Now!',
                              textAlign: TextAlign.center,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
