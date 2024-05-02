// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/er_models.dart';
import 'package:schedular_project/Screens/Emotional/er_home.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/drop_down_button.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../../Model/app_user.dart';
import '../../../Theme/input_decoration.dart';
import '../../../Widgets/custom_images.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../app_icons.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';

class ObserveSF extends StatefulWidget {
  const ObserveSF({Key? key}) : super(key: key);

  @override
  _ObserveSFState createState() => _ObserveSFState();
}

class _ObserveSFState extends State<ObserveSF> {
  final ObserveSfController _controller = Get.put(ObserveSfController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(leading: backButton(), implyLeading: true),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomButtons(
          button1: 'Done',
          button2: 'Save',
          onPressed1: () async => _controller.edit
              ? await _controller.updateOserve()
              : await _controller.addOserve(),
          onPressed2: () async => _controller.addOserve(true),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TextWidget(
                    text:
                        'ER Journal Level 0 - \nObserve- Short Form (Practice)',
                    weight: FontWeight.bold,
                    alignment: Alignment.center,
                  ),
                  IconButton(
                    onPressed: () => Get.to(
                      () => ReadingScreen(
                        title: 'ER Intro- Generational Curses and Their Cure',
                        link:
                            'https://docs.google.com/document/d/1sQBau2cQ--qGDobCDCx_RchOCSS0SzpZ/',
                        linked: () =>
                            Get.to(() => const ObserveSF(), arguments: [false]),
                        function: () {
                          if (Get.find<ErController>().history.value.value ==
                              67) {
                                 final end = DateTime.now();
                            debugPrint('disposing');
                            Get.find<ErController>().updateHistory(end.difference(_controller.initial).inSeconds);
                            debugPrint('disposed');
                          }
                          Get.log('closed');
                        },
                      ),
                    ),
                    // () => Get.to(() => const ERIntro()),
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
                    ? await _controller.updateOserve(true)
                    : await _controller.addOserve(true),
                drive: () => Get.off(() => const ObserveSfPrevious()),
              ),
              verticalSpace(height: 5),
              const TextWidget(
                text:
                    'This is your time to check in with yourself.\nYou can reflect on a prior event or on the present moment.',
                fontStyle: FontStyle.italic,
                weight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              verticalSpace(height: 15),

              ///
              instructions(),
              verticalSpace(height: 10),

              ///
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
              verticalSpace(height: 10),
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
          ),
        ),
      ),
    );
  }
}

class ObserveSfController extends GetxController {
  RxBool relax = false.obs;
  RxBool confident = false.obs;
  RxBool obsryourself = false.obs;
  RxBool level = false.obs;

  RxInt observe = 9.obs;

  TextEditingController name = TextEditingController();
  TextEditingController currentTime = TextEditingController();

  clearData() {
    relax.value = false;
    confident.value = false;
    observe.value = 10;
    obsryourself.value = false;
    level.value = false;
    name.clear();
  }

  @override
  void onInit() {
    name.text = 'ERJournalLevel0ObserveShortForm${formatTitelDate(DateTime.now()).trim()}';
    currentTime.text = formateDate(DateTime.now());
    if (edit) fetchData();
    super.onInit();
  }

  final formKey = GlobalKey<FormState>();
  final bool edit = Get.arguments[0];

  final Rx<ObserveSfModel> _observe = ObserveSfModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _observe.value.title = name.text;
    _observe.value.date = currentTime.text;
    _observe.value.observe = observe.value;
    _observe.value.relaxation = relax.value;
    _observe.value.confident = confident.value;
    _observe.value.observeYourself = obsryourself.value;
    _observe.value.yourLevel = level.value;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _observe.value.duration = _observe.value.duration! + diff;
    } else {
      _observe.value.duration = diff;
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
        id: _observe.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addOserve([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      loadingDialog(Get.context!);
       final end = DateTime.now();
      setData(end);
      if (edit) _observe.value.id = generateId();
      await erRef.doc(_observe.value.id).set(_observe.value.toMap());
      await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<ErController>().history.value.value == 72) {
          Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      Get.back();
      customToast(message: 'Added successfully');
    }
  }

  Future updateOserve([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      loadingDialog(Get.context!);
       final end = DateTime.now();
      setData(end);
      await erRef.doc(_observe.value.id).update(_observe.value.toMap());
      if (!fromsave) Get.back();
      Get.back();
      customToast(message: 'updated successfully');
    }
  }

  fetchData() {
    _observe.value = Get.arguments[1] as ObserveSfModel;
    name.text = _observe.value.title!;
    currentTime.text = _observe.value.date!;
    confident.value = _observe.value.confident!;
    relax.value = _observe.value.relaxation!;
    obsryourself.value = _observe.value.observeYourself!;
    level.value = _observe.value.yourLevel!;
    observe.value = _observe.value.observe!;
  }
}

class CheckboxRichText extends StatefulWidget {
  const CheckboxRichText({Key? key}) : super(key: key);

  @override
  _CheckboxRichTextState createState() => _CheckboxRichTextState();
}

class _CheckboxRichTextState extends State<CheckboxRichText> {
  final ObserveSfController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
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
        ));
  }
}

class ObserveSfPrevious extends StatelessWidget {
  const ObserveSfPrevious({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'ER Journal Level 0 - Observe- Short Form (Practice)',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: erRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 8)
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
              final ObserveSfModel model =
                  ObserveSfModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () =>
                      Get.to(() => const ObserveSF(), arguments: [true, model]),
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
