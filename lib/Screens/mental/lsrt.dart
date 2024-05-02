// ignore_for_file: unrelated_type_equality_checks, void_checks, no_leading_underscores_for_local_identifiers, library_private_types_in_public_api

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Controller/user_controller.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/bd_models.dart';
import 'package:schedular_project/Model/visualization_model.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/checkboxes.dart';
import 'package:schedular_project/Widgets/custom_button.dart';
import 'package:schedular_project/Widgets/drop_down_button.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../Common/bottom_buttons.dart';
import '../../Functions/text_to_speech_converter.dart';
import '../../Model/app_modal.dart';
import '../../Model/app_user.dart';
import '../../Widgets/custom_images.dart';
import '../../Widgets/custom_toast.dart';
import '../../Widgets/loading_dialog.dart';

import 'package:schedular_project/Widgets/expansion_tiles.dart';
import 'package:schedular_project/Widgets/progress_indicator.dart';

import '../../app_icons.dart';
import '../custom_bottom.dart';
import '../readings.dart';
import 'visualization_home.dart';

class LsrtPrevious extends StatelessWidget {
  const LsrtPrevious({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppbar(title: 'Previous Visualizations', implyLeading: true),
      body: StreamBuilder(
        initialData: const [],
        stream: lsrtRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: progressIndicator());
          } else if (snapshot.data.docs.isEmpty) {
            return const TextWidget(
              text: 'No previous journals to show',
              alignment: Alignment.center,
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                LsrtModel _data = LsrtModel.fromMap(snapshot.data.docs[index]);
                return InkWell(
                  onTap: () => Get.to(
                    () => const LSRT(),
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

  Widget lsrtWidget(
      {required String title, required String body, double padding = 8.0}) {
    return subcontentWidget(
      title: title,
      children: [expansionText(text: body, padding: padding)],
    );
  }

  Widget sensesWidget(SensesModel senses) {
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
      ],
    );
  }

  Widget perspectiveWidget(bool first, bool third) {
    return Row(
      children: [
        CustomCheckBox(value: first, onChanged: null, title: '1sr Person'),
        CustomCheckBox(value: third, onChanged: null, title: '3rd Person'),
      ],
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
          value: senses.emotional,
          onChanged: null,
          title: 'Emotional',
        ),
      ],
    );
  }
}

class LsrtController extends GetxController {
  final UserController _app = Get.find();
  RxInt vlindex = 0.obs;
  RxList<AppModel> visualizationlist = <AppModel>[
    AppModel('Choose Visualization', '', value: 0, link: '', docid: ''),
  ].obs;

  TextEditingController currentTime = TextEditingController();

  ///
  RxInt vividness = 1.obs;
  RxInt easeVal = 1.obs;
  RxInt controlability = 1.obs;

  RxBool visual = false.obs;
  RxBool auditory = false.obs;
  RxBool tactile = false.obs;
  RxBool kinesthetic = false.obs;
  RxBool geustetary = false.obs;
  RxBool olfactory = false.obs;
  RxBool person1 = false.obs;
  RxBool person3 = false.obs;
  RxBool sight = false.obs;
  RxBool hearing = false.obs;
  RxBool touch = false.obs;
  RxBool music = false.obs;
  RxBool taste = false.obs;
  RxBool smell = false.obs;
  RxBool vperspective = false.obs;
  RxBool vangle = false.obs;
  RxBool emotional = false.obs;

  ///
  TextEditingController name = TextEditingController();
  TextEditingController emotions = TextEditingController();
  TextEditingController angle = TextEditingController();
  TextEditingController currentScript = TextEditingController();
  TextEditingController mentalImage = TextEditingController();

  RxBool event = false.obs;
  RxString docid = ''.obs;
  DateTime start = DateTime.now();
  late DateTime end;

  ///
  clearData() {
    name.clear();
    emotions.clear();
    angle.clear();
    currentScript.clear();
    mentalImage.clear();
    vividness.value = 1;
    easeVal.value = 1;
    controlability.value = 1;
    visual = false.obs;
    auditory = false.obs;
    tactile = false.obs;
    kinesthetic = false.obs;
    geustetary = false.obs;
    olfactory = false.obs;
    person1 = false.obs;
    person3 = false.obs;
    sight = false.obs;
    hearing = false.obs;
    touch = false.obs;
    music = false.obs;
    taste = false.obs;
    smell = false.obs;
    vperspective = false.obs;
    vangle = false.obs;
    emotional = false.obs;
    visualizationlist.clear();
    visualizationlist.value = <AppModel>[
      AppModel('Choose Visualization', '', value: 0, link: ''),
    ];
    vlindex.value = 0;
    visualValue.value = 0;
    scriptid.value = '';
  }

  addLsrt([bool fromsave = false]) async {
    loadingDialog(Get.context!);
    final end = DateTime.now();
    setScripts(end);
    if (edit) _lsrt.value.id = generateId();
    await lsrtRef.doc(_lsrt.value.id).set(_lsrt.value.toMap());
    await addAccomplishment(end);
    if (!fromsave) Get.back();
    if (!fromsave) {
      if (Get.find<VisualizationController>().history.value.value == 31) {
        Get.find<VisualizationController>()
            .updateHistory(end.difference(initial).inSeconds);
      }
    }
    Get.back();
    customToast(message: 'Improved visualization created successfully');
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
        id: _lsrt.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  @override
  void onInit() async {
    name.text = 'LSRT${formatTitelDate(DateTime.now()).trim()}';
    currentTime.text = formateDate(DateTime.now());
    await fetchScripts().then((value) {
      if (value) setAudioUrl(0);
    });
    await fetchPrevoiusLsrts();
    await fetchHabits();
    if (edit) fetchData();
    super.onInit();
  }

  @override
  void onClose() async {
    _app.link.value = '';
    _player.dispose();
    super.onClose();
  }

  Future<bool> fetchPrevoiusLsrts() async {
    await lsrtRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          LsrtModel _script = LsrtModel.fromMap(doc);
          if (_script.audio != '') {
            vlindex.value = vlindex.value + 1;
            visualizationlist.add(
              AppModel(
                _script.title!,
                _script.script!,
                value: vlindex.value,
                link: _script.audio,
                docid: _script.id,
              ),
            );
          }
        }
        return true;
      }
    }).whenComplete(() {
      return true;
    });
    return false;
  }

  Future<bool> fetchScripts() async {
    await scriptRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 'visualization')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          ScriptModel _script = ScriptModel.fromMap(doc);
          if (_script.link != '') {
            vlindex.value = vlindex.value + 1;
            visualizationlist.add(
              AppModel(
                _script.title!,
                _script.detail!,
                value: vlindex.value,
                link: _script.link,
                docid: _script.id,
              ),
            );
          }
        }
        return true;
      }
    }).whenComplete(() {
      return true;
    });
    return false;
  }

  Future<bool> fetchHabits() async {
    await bdRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          HabitModel _script = HabitModel.fromMap(doc);
          if (_script.audio != '') {
            vlindex.value = vlindex.value + 1;
            visualizationlist.add(
              AppModel(
                _script.name!,
                _script.script!,
                value: vlindex.value,
                link: _script.audio,
                docid: _script.id,
              ),
            );
          }
        }
        return true;
      }
    }).whenComplete(() {
      return true;
    });
    return false;
  }

  RxInt visualValue = 0.obs;
  RxString scriptid = ''.obs;

  final AudioPlayer _player = AudioPlayer();

  setAudioUrl(int index) async {
    await _player.setUrl(visualizationlist[index].link!);
    currentScript.text = visualizationlist[index].description;
    scriptid.value = visualizationlist[index].docid!;
  }

  Future playAudio() async {
    if (visualValue.value != 0) {
      if (_player.playing) {
        await _player.pause();
      } else {
        _player.play();
      }
    }
  }

  final Rx<LsrtModel> _lsrt = LsrtModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  setBasic() {
    _lsrt.value.vscript = LsrtScript(
      id: visualizationlist[visualValue.value].docid,
      value: visualValue.value,
      detail: visualizationlist[visualValue.value].description,
      link: visualizationlist[visualValue.value].link,
      topic: visualizationlist[visualValue.value].title,
    );
    _lsrt.value.vividness = vividness.value;
    _lsrt.value.ease = easeVal.value;
    _lsrt.value.controllability = controlability.value;
    _lsrt.value.senses = SensesModel(
      sight: visual.value,
      hearing: auditory.value,
      touch: tactile.value,
      music: kinesthetic.value,
      taste: geustetary.value,
      smell: olfactory.value,
    );
    _lsrt.value.emotions = emotions.text;
    _lsrt.value.first = person1.value;
    _lsrt.value.third = person3.value;
    _lsrt.value.vAngle = angle.text;
    _lsrt.value.layer = CheckModel(
      sight: sight.value,
      hearing: hearing.value,
      touch: touch.value,
      music: music.value,
      taste: taste.value,
      smell: smell.value,
      vperspective: vperspective.value,
      viewAngle: vangle.value,
      emotional: emotional.value,
    );
  }

  DateTime initial = DateTime.now();
  setScripts(DateTime end) {
    _lsrt.value.title = name.text;
    _lsrt.value.mentalImage = mentalImage.text;
    _lsrt.value.script = currentScript.text;
    _lsrt.value.audio = _app.link.value;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _lsrt.value.duration = _lsrt.value.duration! + diff;
    } else {
      _lsrt.value.duration = diff;
    }
  }

  Future addtoCalendar() async {
    final Event event = Event(
      title: name.text,
      description: currentScript.text,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 2)),
    );
    await Add2Calendar.addEvent2Cal(event).then((value) {
      if (value) {
        customToast(message: 'Visualization added to calendar successfully');
      }
    });
  }

  final bool edit = Get.arguments[0];

  fetchData() async {
    _lsrt.value = Get.arguments[1] as LsrtModel;
    visualValue.value = visualizationlist
        .where((p0) => p0.docid == _lsrt.value.vscript!.id!)
        .first
        .value!;
    setAudioUrl(visualValue.value);
    vividness.value = _lsrt.value.vividness!;
    easeVal.value = _lsrt.value.ease!;
    controlability.value = _lsrt.value.controllability!;
    SensesModel _senses = _lsrt.value.senses!;
    visual.value = _senses.sight!;
    auditory.value = _senses.hearing!;
    tactile.value = _senses.touch!;
    kinesthetic.value = _senses.music!;
    geustetary.value = _senses.taste!;
    olfactory.value = _senses.smell!;
    emotions.text = _lsrt.value.emotions!;
    person1.value = _lsrt.value.first!;
    person3.value = _lsrt.value.third!;
    angle.text = _lsrt.value.vAngle!;
    CheckModel _layer = _lsrt.value.layer!;
    sight.value = _layer.sight!;
    hearing.value = _layer.hearing!;
    touch.value = _layer.touch!;
    music.value = _layer.music!;
    taste.value = _layer.taste!;
    smell.value = _layer.smell!;
    vperspective.value = _layer.vperspective!;
    vangle.value = _layer.viewAngle!;
    emotional.value = _layer.emotional!;
    name.text = _lsrt.value.title!;
    mentalImage.text = _lsrt.value.mentalImage!;
    currentScript.text = _lsrt.value.script!;
    _app.link.value = _lsrt.value.audio!;
  }

  Future updateData() async {
    loadingDialog(Get.context!);
    final end = DateTime.now();
    setScripts(end);
    await lsrtRef.doc(_lsrt.value.id).update(_lsrt.value.toMap());
    Get.back();
    Get.back();
    customToast(message: 'Visualization updated successfully');
  }
}

class LSRT extends StatefulWidget {
  const LSRT({Key? key}) : super(key: key);

  @override
  _LSRTState createState() => _LSRTState();
}

class _LSRTState extends State<LSRT> {
  RxBool playing = false.obs;
  final LsrtController _lsrt = Get.put(LsrtController());
  final GlobalKey<FormState> _page1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _page2 = GlobalKey<FormState>();

  int index = 0;

  previousIndex() {
    setState(() {
      index = index - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(
          leading: backButton(() => index == 0 ? Get.back() : previousIndex()),
          implyLeading: true,
        ),
        bottomNavigationBar: index == 1
            ? SizedBox(
                height: 70,
                child: BottomButtons(
                  button2: 'Add to Calendar',
                  onPressed1: () async {
                    Get.focusScope!.unfocus();
                    _page2.currentState!.save();
                    if (_page2.currentState!.validate()) {
                      if (_lsrt.edit) {
                        await _lsrt.updateData();
                      } else {
                        await _lsrt.addLsrt();
                      }
                    }
                  },
                  onPressed2: () async => await _lsrt.addtoCalendar(),
                  b1: Get.width * 0.25,
                  b2: Get.width * 0.4,
                  onPressed3: () {
                    setState(() {
                      index = index - 1;
                    });
                  },
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.focusScope!.unfocus();
                      _page1.currentState!.save();
                      if (_page1.currentState!.validate()) {
                        _lsrt.setBasic();
                        index = 1;
                        setState(() {});
                      }
                    },
                    icon: const Icon(Icons.last_page, color: AppColors.black),
                  ),
                ],
              ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              verticalSpace(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextWidget(
                    text: 'LSRT (Practice)',
                    weight: FontWeight.bold,
                    alignment: Alignment.center,
                  ),
                  IconButton(
                    onPressed: () => Get.to(
                      () => ReadingScreen(
                        title: 'V102- Visualization Improvement',
                        link:
                            'https://docs.google.com/document/d/1AoM3znyfd1XxxlLYnNBnijNHHmpAfWBr/',
                        linked: () =>
                            Get.off(() => const LSRT(), arguments: [false]),
                        function: () {
                          if (Get.find<VisualizationController>()
                                  .history
                                  .value
                                  .value ==
                              29) {
                            final end = DateTime.now();
                            debugPrint('disposing');
                            Get.find<VisualizationController>().updateHistory(
                                end.difference(_lsrt.initial).inSeconds);
                            debugPrint('disposed');
                          }
                          Get.log('closed');
                        },
                      ),
                    ),
                    // Get.to(
                    //   () => const VisualizationImprovementsReading(),
                    // ),
                    icon: assetImage(AppIcons.read),
                  ),
                ],
              ),
              verticalSpace(height: 10),
              JournalTop(
                controller: _lsrt.name,
                label: 'Name your LSRT',
                add: () => {_lsrt.clearData(), index = 0, setState(() {})},
                save: () async => await _lsrt.addLsrt(true),
                drive: () => Get.off(() => const LsrtPrevious()),
              ),
              verticalSpace(height: 15),
              index == 0 ? page1() : page2()
            ],
          ),
        ),
      ),
    );
  }

  Widget page2() {
    return Form(
      key: _page2,
      child: Column(
        children: [
          const TextWidget(
            text:
                'How would you like to develop your mental image further to make it more vivid and realistic?',
            weight: FontWeight.bold,
          ),
          TextFormField(
            controller: _lsrt.mentalImage,
            decoration: inputDecoration(
              hint: 'Develop my emotional state before competition',
            ),
          ),
          verticalSpace(height: 10),

          ///
          const TextWidget(
            text: 'New Script',
            fontStyle: FontStyle.italic,
            weight: FontWeight.bold,
          ),
          const TextWidget(
            text: 'Edit your script to make it more vivid and realistic.',
            fontStyle: FontStyle.italic,
          ),
          TextFormField(
            maxLines: 20,
            controller: _lsrt.currentScript,
            decoration: inputDecoration(
              hint:
                  'Autopopulates script from chosen visualization in dropdown at the beginning of the exercise. Editable',
            ),
          ),
          verticalSpace(height: 15),

          ///
          Container(
            width: Get.width,
            height: 100,
            margin: const EdgeInsets.only(left: 10, right: 10),
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            child: TextButton(
              onPressed: () async {
                Get.focusScope!.unfocus();
                _page2.currentState!.save();
                if (_page2.currentState!.validate()) {
                  loadingDialog(context);
                  await convertToAudio(
                    _lsrt.currentScript.text,
                    filename: _lsrt.name.text,
                    firebasepath:
                        'LSRT/Audio/${Get.find<AuthServices>().userid}',
                    loader: true,
                    option: true,
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
    );
  }

  Widget page1() {
    return Form(
      key: _page1,
      child: Column(
        children: [
          const TextWidget(
            text: 'Choose a visualization to review',
            fontStyle: FontStyle.italic,
          ),
          Row(
            children: [
              Obx(
                () => SizedBox(
                  child: CustomDropDownStruct(
                    child: DropdownButton(
                      value: _lsrt.visualValue.value,
                      hint: const TextWidget(
                        text: 'Visualization',
                        alignment: Alignment.centerLeft,
                      ),
                      onChanged: (val) {
                        setState(() {
                          _lsrt.visualValue.value = val;
                          _lsrt.setAudioUrl(_lsrt.visualValue.value);
                          setState(() {});
                        });
                      },
                      items: _lsrt.visualizationlist
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.value,
                              child: SizedBox(
                                width: Get.width * 0.6,
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
              ),
              IconButton(
                onPressed: () async => await _lsrt.playAudio(),
                icon: const Icon(Icons.play_arrow, color: AppColors.black),
              ),
              IconButton(
                onPressed: () async => await _lsrt.playAudio(),
                icon: const Icon(Icons.pause, color: AppColors.black),
              ),
            ],
          ),

          /// current script
          verticalSpace(height: 10),
          const TextWidget(
            size: 16,
            text: 'Current Script',
            weight: FontWeight.bold,
          ).marginOnly(bottom: 5),
          const TextWidget(
            text:
                'Write your highly detailed script in the space provided. Think about the minor details like your viewing angle. Remember to evoke powerful emotions, feel all five senses, and associate positive emotions with wanted behaviors.',
            size: 12,
            fontStyle: FontStyle.italic,
            color: Colors.black54,
          ).marginOnly(),
          TextFormField(
            readOnly: true,
            maxLines: 5,
            controller: _lsrt.currentScript,
            decoration: inputDecoration(
              hint:
                  'Autopopulates script from chosen visualization in dropdown. Not editable',
            ),
          ),

          /// radio button
          verticalSpace(height: 10),
          _richText(
            'Rate the vividness and clarity of the visualization experience from 1-5',
            ' (1=No visualization at all, only thinking of the scenario; 5=Perfectly clear and vivid visualization)',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              radioList.length,
              (radio) => CustomRadioButton(
                value: radioList[radio],
                width: 50,
                groupValue: _lsrt.vividness.value,
                title: radioList[radio].toString(),
                onChanged: (value) {
                  setState(() {
                    _lsrt.vividness.value = value;
                  });
                },
              ),
            ),
          ),
          verticalSpace(height: 10),
          _richText(
            'Rate the ease of forming the visualization from 1-5',
            ' (1=Impossible; 5=Automatic)',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              radioList.length,
              (idx) => CustomRadioButton(
                value: radioList[idx],
                width: 50,
                groupValue: _lsrt.easeVal.value,
                title: radioList[idx].toString(),
                onChanged: (value) {
                  setState(() {
                    _lsrt.easeVal.value = value;
                  });
                },
              ),
            ),
          ),
          verticalSpace(height: 10),
          _richText(
            'Rate the controllability of the visualization from 1-5 ',
            '(1=No control; 5=Complete control over all aspects of the visualization)',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              radioList.length,
              (idx) => CustomRadioButton(
                value: radioList[idx],
                width: 50,
                groupValue: _lsrt.controlability.value,
                title: radioList[idx].toString(),
                onChanged: (value) {
                  setState(() {
                    _lsrt.controlability.value = value;
                  });
                },
              ),
            ),
          ),

          ///
          const TextWidget(
            text: 'What senses were engaged? (check all that apply)',
            weight: FontWeight.bold,
          ),
          verticalSpace(height: 10),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomCheckBox(
                    value: _lsrt.visual.value,
                    onChanged: (value) {
                      setState(() {
                        _lsrt.visual.value = value;
                      });
                    },
                    title: 'Visual (sight)',
                    width: Get.width * 0.45,
                  ),
                  CustomCheckBox(
                    value: _lsrt.auditory.value,
                    onChanged: (value) {
                      setState(() {
                        _lsrt.auditory.value = value;
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
                    value: _lsrt.tactile.value,
                    onChanged: (value) {
                      setState(() {
                        _lsrt.tactile.value = value;
                      });
                    },
                    title: 'Tactile (touch)',
                    width: Get.width * 0.4,
                  ),
                  CustomCheckBox(
                    value: _lsrt.kinesthetic.value,
                    onChanged: (value) {
                      setState(() {
                        _lsrt.kinesthetic.value = value;
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
                    value: _lsrt.geustetary.value,
                    onChanged: (value) {
                      setState(() {
                        _lsrt.geustetary.value = value;
                      });
                    },
                    title: 'Gustatory (taste)',
                    width: Get.width * 0.45,
                  ),
                  CustomCheckBox(
                    value: _lsrt.olfactory.value,
                    onChanged: (value) {
                      setState(() {
                        _lsrt.olfactory.value = value;
                      });
                    },
                    title: 'Olfactory (smell)',
                    width: Get.width * 0.45,
                  ),
                ],
              ),
            ],
          ),

          ///
          verticalSpace(height: 10),
          const TextWidget(
            text: 'What emotions (if any) were felt?',
            weight: FontWeight.bold,
          ),
          TextFormField(
            controller: _lsrt.emotions,
            decoration: inputDecoration(hint: 'Joy, confidence, anxiety'),
          ),

          ///
          verticalSpace(height: 10),
          const TextWidget(
            text: 'What was your perspective? (check all that apply)',
            weight: FontWeight.bold,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomCheckBox(
                value: _lsrt.person1.value,
                onChanged: (value) {
                  setState(() {
                    _lsrt.person1.value = value;
                  });
                },
                title: '1st person',
                width: Get.width * 0.45,
              ),
              CustomCheckBox(
                value: _lsrt.person3.value,
                onChanged: (value) {
                  setState(() {
                    _lsrt.person3.value = value;
                  });
                },
                title: '3rd person',
                width: Get.width * 0.45,
              ),
            ],
          ),

          ///
          verticalSpace(height: 10),
          const TextWidget(
            text: 'What was your viewing angle?',
            weight: FontWeight.bold,
          ),
          TextFormField(
            controller: _lsrt.angle,
            decoration: inputDecoration(
              hint:
                  'From the side, from the bleachers, overhead, from the opponents right corner of the field,',
            ),
          ),

          ///
          verticalSpace(height: 10),
          const TextWidget(
            text: 'What new layer(s) will you add to your visualization?',
            weight: FontWeight.bold,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomCheckBox(
                    value: _lsrt.sight.value,
                    onChanged: (value) {
                      setState(() {
                        _lsrt.sight.value = value;
                      });
                    },
                    title: 'Visual (sight)',
                    width: Get.width * 0.45,
                  ),
                  CustomCheckBox(
                    value: _lsrt.hearing.value,
                    onChanged: (value) {
                      setState(() {
                        _lsrt.hearing.value = value;
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
                    value: _lsrt.touch.value,
                    onChanged: (value) {
                      setState(() {
                        _lsrt.touch.value = value;
                      });
                    },
                    title: 'Tactile (touch)',
                    width: Get.width * 0.4,
                  ),
                  CustomCheckBox(
                    value: _lsrt.music.value,
                    onChanged: (value) {
                      setState(() {
                        _lsrt.music.value = value;
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
                    value: _lsrt.taste.value,
                    onChanged: (value) {
                      setState(() {
                        _lsrt.taste.value = value;
                      });
                    },
                    title: 'Gustatory (taste)',
                    width: Get.width * 0.45,
                  ),
                  CustomCheckBox(
                    value: _lsrt.smell.value,
                    onChanged: (value) {
                      setState(() {
                        _lsrt.smell.value = value;
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
                    value: _lsrt.vperspective.value,
                    onChanged: (value) {
                      setState(() {
                        _lsrt.vperspective.value = value;
                      });
                    },
                    title: 'Visual perspective',
                    width: Get.width * 0.5,
                  ),
                  CustomCheckBox(
                    value: _lsrt.vangle.value,
                    onChanged: (value) {
                      setState(() {
                        _lsrt.vangle.value = value;
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
                    value: _lsrt.emotional.value,
                    onChanged: (value) {
                      setState(() {
                        _lsrt.emotional.value = value;
                      });
                    },
                    title: 'Emotional',
                    width: Get.width * 0.45,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _richText(String title, String subtitle) {
    return RichText(
      text: TextSpan(
        text: title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: subtitle,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
