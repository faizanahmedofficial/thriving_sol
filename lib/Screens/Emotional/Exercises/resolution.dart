// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/er_models.dart';
import 'package:schedular_project/Screens/Emotional/er_home.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/progress_indicator.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../../Constants/constants.dart';
import '../../../Model/app_user.dart';
import '../../../Widgets/custom_images.dart';
import '../../../app_icons.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';

class Resolution extends StatefulWidget {
  const Resolution({Key? key}) : super(key: key);

  @override
  _ResolutionState createState() => _ResolutionState();
}

class _ResolutionState extends State<Resolution> {
  final _resolve = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController easy = TextEditingController();
  TextEditingController matters = TextEditingController();
  TextEditingController advice = TextEditingController();
  TextEditingController steps = TextEditingController();
  TextEditingController currentTime = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      name.text =
          'ResolveTheSituation${formatTitelDate(DateTime.now()).trim()}';
      currentTime.text = formateDate(DateTime.now());
      if (edit) fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(leading: backButton(), implyLeading: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: _resolve,
          child: Column(
            children: [
              verticalSpace(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: TextWidget(
                      text: 'Resolve the Situation (Practice)',
                      weight: FontWeight.bold,
                      alignment: Alignment.center,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.to(
                      () => ReadingScreen(
                        title: 'ER101a- Resolve the Situation',
                        link:
                            'https://docs.google.com/document/d/10h8qjNmn61kP5pmyokNPtfJ2ahrBFvhZ/',
                        linked: () => Get.back(),
                        function: () {
                          if (Get.find<ErController>().history.value.value ==
                              74) {
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
                    //   () => const ER101aReading(),
                    // ),
                    icon: assetImage(AppIcons.read),
                  ),
                ],
              ),
              verticalSpace(height: 10),
              JournalTop(
                controller: name,
                label: 'Name',
                add: () => clearResolution(),
                save: () async => edit
                    ? await updateResolution(true)
                    : await addResolutin(true),
                drive: () => Get.off(() => const PreviousResolution()),
              ),

              ///1
              verticalSpace(height: 15),
              const TextWidget(
                text:
                    'This is your time to focus on the practical ways to resolve troubling situations, especially those that pop up repeatedly. By having a plan in place you can drastically reduce the chances of negative outcomes and resolve situations before they even occur.',
                fontStyle: FontStyle.italic,
              ),
              verticalSpace(height: 10),
              TextFormField(
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
              verticalSpace(height: 15),

              ///
              verticalSpace(height: 10),
              const TextWidget(
                  text:
                      'What would be the simplest and easiest way to change the outcome positively?'),
              TextFormField(
                controller: easy,
                decoration: inputDecoration(hint: 'Simple or easy solution'),
              ),

              ///
              verticalSpace(height: 15),
              const TextWidget(
                  text: 'Will this matter in 5 years? Why/ why not?'),
              TextFormField(
                controller: matters,
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
                controller: advice,
                decoration: inputDecoration(
                  hint: 'What advice would I give a loved once?',
                ),
              ),

              ///
              verticalSpace(height: 15),
              const TextWidget(
                text:
                    'Write out an alternate more positive outcome and how exactly that could come to pass. Write the exact steps you could take to make this positive outcome occur.',
              ),
              TextFormField(
                maxLines: 10,
                controller: steps,
                decoration: inputDecoration(
                  hint: 'What steps will I take to resolve the situation?',
                ),
              ),

              ///
              verticalSpace(height: Get.height * 0.01),
              BottomButtons(
                button1: 'Done',
                button2: 'Save',
                onPressed1: () async =>
                    edit ? await updateResolution() : await addResolutin(),
                onPressed2: () async => await addResolutin(true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final bool edit = Get.arguments[0];
  final Rx<ResolutionModel> _resolution = ResolutionModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _resolution.value.title = name.text;
    _resolution.value.date = currentTime.text;
    _resolution.value.solution = easy.text;
    _resolution.value.fiveYears = matters.text;
    _resolution.value.advice = advice.text;
    _resolution.value.alternative = steps.text;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _resolution.value.duration = _resolution.value.duration! + diff;
    } else {
      _resolution.value.duration = diff;
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
        id: _resolution.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addResolutin([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _resolve.currentState!.save();
    if (_resolve.currentState!.validate()) {
      loadingDialog(context);
       final end = DateTime.now();
      setData(end);
      if (edit) _resolution.value.id = generateId();
      await erRef.doc(_resolution.value.id).set(_resolution.value.toMap());
      await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<ErController>().history.value.value == 75) {
          Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      Get.back();
      customToast(message: 'Resolution added successfully');
    }
  }

  Future updateResolution([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _resolve.currentState!.save();
    if (_resolve.currentState!.validate()) {
      loadingDialog(context);
       final end = DateTime.now();
      setData(end);
      await erRef.doc(_resolution.value.id).update(_resolution.value.toMap());
      if (!fromsave) Get.back();
      Get.back();
      customToast(message: 'Resolution added successfully');
    }
  }

  fetchData() {
    _resolution.value = Get.arguments[1] as ResolutionModel;
    name.text = _resolution.value.title!;
    currentTime.text = _resolution.value.date!;
    easy.text = _resolution.value.solution!;
    matters.text = _resolution.value.fiveYears!;
    advice.text = _resolution.value.advice!;
    steps.text = _resolution.value.alternative!;
  }

  void clearResolution() {
    name.clear();
    easy.clear();
    matters.clear();
    advice.clear();
    steps.clear();
  }
}

class PreviousResolution extends StatelessWidget {
  const PreviousResolution({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(implyLeading: true, title: '', actions: []),
      body: StreamBuilder(
        initialData: const [],
        stream: erRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 2)
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
              final ResolutionModel model =
                  ResolutionModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const Resolution(),
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
