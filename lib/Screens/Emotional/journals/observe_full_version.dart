// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Model/er_models.dart';
import 'package:schedular_project/Screens/Emotional/er_home.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';

import '../../../Constants/constants.dart';
import '../../../Model/app_user.dart';
import '../../../Widgets/custom_images.dart';
import '../../../Widgets/drop_down_button.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../app_icons.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';

class ERJournal0 extends GetxController {
  TextEditingController currentTime = TextEditingController();
  TextEditingController name = TextEditingController();

  RxInt observe = 0.obs;

  void clearData() {
    observe.value = 1;
    index.value = 1;
    name.clear();
  }

  @override
  void onInit() {
    name.text =
        'ERJournalLevel0Observe${formatTitelDate(DateTime.now()).trim()}';
    currentTime.text = formateDate(DateTime.now());
    if (edit) fetchData();
    super.onInit();
  }

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;

  final formkey = GlobalKey<FormState>();
  final bool edit = Get.arguments[0];
  final Rx<ObserveModel> _observe = ObserveModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;
DateTime initial = DateTime.now();
  setData(DateTime end) {
    _observe.value.title = name.text;
    _observe.value.date = currentTime.text;
    _observe.value.stress = observe.value;
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

  Future addObserve([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    formkey.currentState!.save();
    if (formkey.currentState!.validate()) {
      loadingDialog(Get.context!);
       final end = DateTime.now();
      setData(end);
      if (edit) _observe.value.id = generateId();
      await erRef.doc(_observe.value.id).set(_observe.value.toMap());
      await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<ErController>().history.value.value == 71) {
          Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      Get.back();
      customToast(message: 'Added successfully');
    }
  }

  Future updateObserve([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    formkey.currentState!.save();
    if (formkey.currentState!.validate()) {
      loadingDialog(Get.context!);
       final end = DateTime.now();
      setData(end);
      await erRef.doc(_observe.value.id).update(_observe.value.toMap());
      if (!fromsave) Get.back();
      Get.back();
      customToast(message: 'Update successfully');
    }
  }

  fetchData() {
    _observe.value = Get.arguments[1] as ObserveModel;
    name.text = _observe.value.title!;
    currentTime.text = _observe.value.date!;
    observe.value = _observe.value.stress!;
  }

  previousIndex() => index.value = index.value - 1;
}

class ObservePrevious extends StatelessWidget {
  const ObservePrevious({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'ER Journal Level 0 - Observe (Practice)',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: erRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 9)
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
              final ObserveModel model =
                  ObserveModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const ObserveFullForm(),
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

class ObserveFullForm extends StatefulWidget {
  const ObserveFullForm({Key? key}) : super(key: key);

  @override
  _ObserveFullFormState createState() => _ObserveFullFormState();
}

class _ObserveFullFormState extends State<ObserveFullForm> {
  final ERJournal0 _journal = Get.put(ERJournal0());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(
          leading: backButton(
            () => _journal.index.value == 0
                ? Get.back()
                : _journal.previousIndex(),
          ),
          implyLeading: true,
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomButtons(
            button1: _journal.index.value == 2 ? 'Done' : 'Continue',
            button2: 'Save',
            onPressed1: _journal.index.value == 2
                ? () async => _journal.edit
                    ? await _journal.updateObserve()
                    : await _journal.addObserve()
                : () => _journal.updateIndex(),
            onPressed2: () async => await _journal.addObserve(true),
            onPressed3: () => _journal.index.value != 0
                ? _journal.previousIndex()
                : Get.back(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Form(
            key: _journal.formkey,
            child: Column(
              children: [
                verticalSpace(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: TextWidget(
                        text: 'ER Journal Level 0- Observe (Practice)',
                        weight: FontWeight.bold,
                        alignment: Alignment.center,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.to(
                        () => ReadingScreen(
                          title: 'ER Intro- Generational Curses and Their Cure',
                          link:
                              'https://docs.google.com/document/d/1sQBau2cQ--qGDobCDCx_RchOCSS0SzpZ/',
                          linked: () => Get.back(),
                          function: () {
                            if (Get.find<ErController>().history.value.value ==
                                67) {
                                   final end = DateTime.now();
                              debugPrint('disposing');
                              Get.find<ErController>().updateHistory(end.difference(_journal.initial).inSeconds);
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
                  controller: _journal.name,
                  label: 'Name',
                  add: () => _journal.clearData(),
                  save: () async => _journal.edit
                      ? await _journal.updateObserve(true)
                      : await _journal.addObserve(true),
                  drive: () => Get.off(() => const ObservePrevious()),
                ),
                verticalSpace(height: 5),
                _journal.index.value == 0
                    ? page1()
                    : _journal.index.value == 1
                        ? page2()
                        : _journal.index.value == 2
                            ? page3()
                            : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget page3() {
    return Column(
      children: [
        verticalSpace(height: 15),

        ///
        verticalSpace(height: 20),
        richtext(
          'Impartially observe yourself.',
          ' Observe yourself simply as you are in this exact moment. View yourself in the present moment and feel compassion for yourself and anyone else present. Observe yourself and the situation without judgment as an impartial 3rd party. Will this matter in 5 years? ',
        ),

        ///
        verticalSpace(height: 25),
        richtext(
          'Find your level.',
          ' Pause. Excuse yourself from the area if you feel the need to. How stressed are you on a scale from 1-10 where Level 1 is feeling wonderful and Level 10 is considered very stressed. Find your level and accept it. ',
        ),

        ///
        verticalSpace(height: height * 0.2),
        const TextWidget(
          text: 'What are you feeling right now?',
          weight: FontWeight.bold,
        ),

        Obx(
          () => Align(
            alignment: Alignment.topLeft,
            child: CustomDropDownStruct(
              child: DropdownButton(
                value: _journal.observe.value,
                onChanged: (val) {
                  setState(() {
                    _journal.observe.value = val;
                  });
                },
                items: observeList
                    .map(
                      (e) => DropdownMenuItem<int>(
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

  Widget page1() {
    return Column(
      children: [
        verticalSpace(height: 30),
        const TextWidget(
          text: 'Induce a relaxation response.',
          size: 17,
          weight: FontWeight.bold,
        ),

        ///
        verticalSpace(height: 25),
        richtextwidget(
          1,
          'Take a deep breath in through your nose. Focus on following the sensation of your breath moving through your body. Feel the air moving into your body.',
        ),

        ///
        verticalSpace(height: 25),
        richtextwidget(
          2,
          'Breathe out as slowly as you can without straining, either, through your mouth or through your nose. Feel the exact area of your body the air is touching at this moment.',
        ),

        ///
        verticalSpace(height: 25),
        richtextwidget(
          3,
          'Breathe deeply at least once, but feel free to repeat this process multiple times for more relaxation.',
        ),
      ],
    );
  }

  Widget page2() {
    return Column(
      children: [
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
        verticalSpace(height: 15),

        ///
        Center(
          child: TextFormField(
            controller: _journal.currentTime,
            readOnly: true,
            onTap: () {
              customDatePicker(
                context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              ).then((value) {
                setState(() {
                  _journal.currentTime.text = formateDate(value);
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
        const TextWidget(
          text: 'Induce a confident State',
          weight: FontWeight.bold,
          size: 16,
        ),
        verticalSpace(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textwidget(1, 'Sit or stand up straight'),
            textwidget(
                2, 'Puff your chest out slightly, move your shoulders back.'),
            textwidget(3, 'Put your chin up just a little bit'),
          ],
        ),

        ///
        verticalSpace(height: 30),
        const TextWidget(
          text:
              'When you do these actions your body naturally signals your brain that you are feeling confident,',
        ),
      ],
    );
  }
}
