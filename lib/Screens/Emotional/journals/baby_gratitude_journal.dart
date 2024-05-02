// ignore_for_file: prefer_final_fields, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/gratitude_model.dart';
import 'package:schedular_project/Screens/Emotional/gratitude_home.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/progress_indicator.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../../Constants/constants.dart';
import '../../../Model/app_user.dart';
import '../../../Services/auth_services.dart';
import '../../../Widgets/custom_images.dart';
import '../../../app_icons.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';

// ignore: must_be_immutable
class BabyGratitudeJournal extends StatefulWidget {
  const BabyGratitudeJournal({Key? key}) : super(key: key);

  @override
  _BabyGratitudeJournalState createState() => _BabyGratitudeJournalState();
}

class _BabyGratitudeJournalState extends State<BabyGratitudeJournal> {
  var _key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController thankful = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      name.text =
          'BabyGratitudeJournal${formatTitelDate(DateTime.now()).trim()}';
      if (edit) fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(leading: backButton(), implyLeading: true),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomButtons(
          button1: 'Done',
          onPressed1: () async =>
              edit ? await updateJournal() : await addJournal(),
          button2: 'Save',
          onPressed2: () async => await addJournal(true),
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
                      text: 'Baby Gratitude Journal (Practice)',
                      weight: FontWeight.bold,
                      alignment: Alignment.center,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.to(
                      () => ReadingScreen(
                        title:
                            'G Intro- Say 2 words and be happier, healthier, and more likeable',
                        link:
                            'https://docs.google.com/document/d/1prPUmKmlyNpyEz1ISyYVUemwNHK425Qp/',
                        linked: () => Get.back(),
                        function: () {
                          if (Get.find<GratitudeController>()
                                  .history
                                  .value
                                  .value ==
                              60) {
                                 final end = DateTime.now();
                            debugPrint('disposing');
                            Get.find<GratitudeController>().updateHistory(end.difference(initial).inSeconds);
                            debugPrint('disposed');
                          }
                          Get.log('closed');
                        },
                      ),
                    ),
                    //  () => Get.to(() => const GIntroReading()),
                    icon: assetImage(AppIcons.read),
                  ),
                ],
              ),
              verticalSpace(height: 10),
              JournalTop(
                controller: name,
                label: 'Name',
                add: () {
                  name.clear();
                  thankful.clear();
                },
                save: () async =>
                    edit ? await updateJournal(true) : await addJournal(true),
                drive: () => Get.off(() => const Previousbjournals()),
              ),
              verticalSpace(height: 15),
              const TextWidget(
                text: 'List 1 to 5 things or people you feel thankful for.',
                fontStyle: FontStyle.italic,
              ),
              verticalSpace(height: 10),
              TextFormField(
                maxLines: 25,
                textInputAction: TextInputAction.newline,
                controller: thankful,
                decoration: inputDecoration(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  final bool edit = Get.arguments[0];
  final Rx<BabyGratitudeModel> _journal = BabyGratitudeModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _journal.value.title = name.text;
    _journal.value.journal = thankful.text;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _journal.value.duration = _journal.value.duration! + diff;
    } else {
      _journal.value.duration = diff;
    }
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == gratitude);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: name.text,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _journal.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      loadingDialog(context);
       final end = DateTime.now();
      setData(end);
      if (edit) _journal.value.id = generateId();
      await gratitudeRef.doc(_journal.value.id).set(_journal.value.toMap());
      await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<GratitudeController>().history.value.value == 61) {
          Get.find<GratitudeController>().updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      Get.back();
      customToast(message: 'Added successfully');
    }
  }

  Future updateJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      loadingDialog(context);
       final end = DateTime.now();
      setData(end);
      await gratitudeRef.doc(_journal.value.id).update(_journal.value.toMap());
      if (!fromsave) Get.back();
      Get.back();
      customToast(message: 'Updated successfully');
    }
  }

  fetchData() {
    _journal.value = Get.arguments[1] as BabyGratitudeModel;
    name.text = _journal.value.title!;
    thankful.text = _journal.value.journal!;
  }
}

class Previousbjournals extends StatelessWidget {
  const Previousbjournals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Baby Gratitude Journals',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: gratitudeRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 0)
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
              final BabyGratitudeModel model =
                  BabyGratitudeModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const BabyGratitudeJournal(),
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
