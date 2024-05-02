// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Screens/Emotional/gratitude_home.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';
import 'package:schedular_project/Global/firebase_collections.dart';

import '../../../Constants/constants.dart';
import '../../../Model/app_user.dart';
import '../../../Model/gratitude_model.dart';
import '../../../Widgets/custom_images.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../app_icons.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';

class GJournalController extends GetxController {
  TextEditingController currentTime = TextEditingController();

  /// Journal
  TextEditingController thankful = TextEditingController();
  TextEditingController journal = TextEditingController();
  TextEditingController grateful = TextEditingController();
  TextEditingController laugh = TextEditingController();
  TextEditingController proud = TextEditingController();
  TextEditingController sights = TextEditingController();
  TextEditingController neccessaties = TextEditingController();
  TextEditingController journalName = TextEditingController();
  TextEditingController circumstances = TextEditingController();
  TextEditingController recentlyEnjoyed = TextEditingController();
  TextEditingController luckyHappend = TextEditingController();
  TextEditingController comfortable = TextEditingController();
  TextEditingController troubles = TextEditingController();
  TextEditingController growth = TextEditingController();
  TextEditingController failure = TextEditingController();
  TextEditingController reframe = TextEditingController();
  TextEditingController othersLack = TextEditingController();

  clearJournalData() {
    thankful.clear();
    journal.clear();
    grateful.clear();
    laugh.clear();
    proud.clear();
    sights.clear();
    neccessaties.clear();
    journalName.clear();
    circumstances.clear();
    recentlyEnjoyed.clear();
    luckyHappend.clear();
    comfortable.clear();
    troubles.clear();
    growth.clear();
    failure.clear();
    reframe.clear();
    othersLack.clear();
  }

  final journalKey = GlobalKey<FormState>();

  @override
  void onInit() {
    journalName.text =
        'GratitudeJournal${formatTitelDate(DateTime.now()).trim()}';
    currentTime.text = formateDate(DateTime.now());
    if (edit) fetchData();
    super.onInit();
  }

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;
  previousIndex() => index.value = index.value - 1;

  final bool edit = Get.arguments[0];
  final Rx<GratitudeModel> _journal = GratitudeModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _journal.value.title = journalName.text;
    _journal.value.thankful = thankful.text;
    _journal.value.grateful = grateful.text;
    _journal.value.laugh = laugh.text;
    _journal.value.proud = proud.text;
    _journal.value.necessities = neccessaties.text;
    _journal.value.sights = sights.text;
    _journal.value.circumstances = circumstances.text;
    _journal.value.doneRecently = recentlyEnjoyed.text;
    _journal.value.luckyHappend = luckyHappend.text;
    _journal.value.comfortable = comfortable.text;
    _journal.value.positive = troubles.text;
    _journal.value.challenges = growth.text;
    _journal.value.failure = failure.text;
    _journal.value.negative = reframe.text;
    _journal.value.things = othersLack.text;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _journal.value.duration = _journal.value.duration! + diff;
    } else {
      _journal.value.duration = diff;
    }
  }

  fetchData() {
    _journal.value = Get.arguments[1] as GratitudeModel;
    journalName.text = _journal.value.title!;
    thankful.text = _journal.value.thankful!;
    grateful.text = _journal.value.grateful!;
    laugh.text = _journal.value.laugh!;
    proud.text = _journal.value.proud!;
    neccessaties.text = _journal.value.necessities!;
    sights.text = _journal.value.sights!;
    circumstances.text = _journal.value.circumstances!;
    recentlyEnjoyed.text = _journal.value.doneRecently!;
    luckyHappend.text = _journal.value.luckyHappend!;
    comfortable.text = _journal.value.comfortable!;
    troubles.text = _journal.value.positive!;
    growth.text = _journal.value.challenges!;
    failure.text = _journal.value.failure!;
    reframe.text = _journal.value.negative!;
    othersLack.text = _journal.value.things!;
  }

Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == gratitude);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: journalName.text,
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
    journalKey.currentState!.save();
    if (journalKey.currentState!.validate()) {
      loadingDialog(Get.context!);
       final end = DateTime.now();
      setData(end);
      if (edit) _journal.value.id = generateId();
      await gratitudeRef.doc(_journal.value.id).set(_journal.value.toMap());
      await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<GratitudeController>().history.value.value == 63) {
          await gratitudeRef
              .where('userid', isEqualTo: Get.find<AuthServices>().userid)
              .where('type', isEqualTo: 1)
              .get()
              .then((value) {
            if (value.docs.isNotEmpty) {
              if (value.docs.length >= 3) {
                Get.find<GratitudeController>().updateHistory(end.difference(initial).inSeconds);
              }
            }
          });
        }
        Get.back();
      }
      Get.back();
      customToast(message: 'Added sucessfully');
    }
  }

  Future updateJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    journalKey.currentState!.save();
    if (journalKey.currentState!.validate()) {
      loadingDialog(Get.context!);
       final end = DateTime.now();
      setData(end);
      await gratitudeRef.doc(_journal.value.id).update(_journal.value.toMap());
      if (!fromsave) Get.back();
      Get.back();
      customToast(message: 'Updated sucessfully');
    }
  }
}

class GratitudeJournal1 extends StatefulWidget {
  const GratitudeJournal1({Key? key}) : super(key: key);

  @override
  _GratitudeJournal1State createState() => _GratitudeJournal1State();
}

class _GratitudeJournal1State extends State<GratitudeJournal1> {
  final GJournalController _controller = Get.put(GJournalController());

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
        bottomNavigationBar: _controller.index.value == 0
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.navigate_next),
                    onPressed: () => _controller.updateIndex(),
                  ),
                ],
              )
            : SizedBox(
                height: 70,
                child: BottomButtons(
                  button1: 'Done',
                  button2: 'Save',
                  onPressed1: () async => _controller.edit
                      ? await _controller.updateJournal()
                      : await _controller.addJournal(),
                  onPressed2: () async => _controller.addJournal(true),
                  onPressed3: () => _controller.index.value != 0
                      ? _controller.previousIndex()
                      : Get.back(),
                ),
              ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _controller.journalKey,
            child: Column(
              children: [
                verticalSpace(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: TextWidget(
                        text: 'Gratitude Journal (Practice)',
                        weight: FontWeight.bold,
                        alignment: Alignment.center,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.to(
                        () => ReadingScreen(
                          title: 'G101- Gratitude Journal',
                          link:
                              'https://docs.google.com/document/d/1_GmNRM8xmINp0ml_gB_l9pg2-UlmNEyo/',
                          linked: () => Get.back(),
                          function: () {
                            if (Get.find<GratitudeController>()
                                    .history
                                    .value
                                    .value ==
                                62) {
                                   final end = DateTime.now();
                              debugPrint('disposing');
                              Get.find<GratitudeController>().updateHistory(end.difference(_controller.initial).inSeconds);
                              debugPrint('disposed');
                            }
                            Get.log('closed');
                          },
                        ),
                      ),
                      // () => Get.to(
                      //   () => const G101Reading(),
                      // ),
                      icon: assetImage(AppIcons.read),
                    ),
                  ],
                ),
                verticalSpace(height: 10),
                JournalTop(
                  controller: _controller.journalName,
                  label: 'Name',
                  add: () => _controller.clearJournalData(),
                  save: () async => _controller.edit
                      ? await _controller.updateJournal(true)
                      : await _controller.addJournal(true),
                  drive: () => Get.off(() => const Previousjournals()),
                ),
                verticalSpace(height: 15),
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
        verticalSpace(height: 15),
        const TextWidget(
          text: 'Which challenges have helped me grow?',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _controller.growth,
          decoration: inputDecoration(),
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text: 'How was failure helped me?',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _controller.failure,
          decoration: inputDecoration(),
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text: 'How can I reframe a negative into a positive?',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _controller.reframe,
          decoration: inputDecoration(),
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text:
              'What things do I have that people in other places or time periods lack?',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _controller.othersLack,
          decoration: inputDecoration(),
        ),
        verticalSpace(height: 5),
      ],
    );
  }

  Widget page1() {
    return Column(
      children: [
        const TextWidget(
          text: 'I feel thankful for...',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _controller.thankful,
          decoration: inputDecoration(),
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text: 'Who am I grateful to have in my life?',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _controller.grateful,
          decoration: inputDecoration(),
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text: 'What has made me laugh or smile recently?',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _controller.laugh,
          decoration: inputDecoration(),
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text: 'What has made me proud recently?',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _controller.proud,
          decoration: inputDecoration(),
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text: 'What necessities am I grateful to have?',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _controller.neccessaties,
          decoration: inputDecoration(),
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text:
              'What beautiful sights, sounds, tastes, and feelings have I expeirenced?',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _controller.sights,
          decoration: inputDecoration(),
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text: 'What circumstances am I grateful for?',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _controller.circumstances,
          decoration: inputDecoration(),
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text: 'What have I done recently that I enjoyed?',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _controller.recentlyEnjoyed,
          decoration: inputDecoration(),
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text: 'Has anything lucky happened to me?',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _controller.luckyHappend,
          decoration: inputDecoration(),
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text:
              'What things do I have that make me or my loved ones more comfortable/ safe/ happy?',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _controller.comfortable,
          decoration: inputDecoration(),
        ),
        verticalSpace(height: 5),
        const TextWidget(
          text:
              'What troubles have I had that made possible something positive in my life?',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _controller.troubles,
          decoration: inputDecoration(),
        ),
        verticalSpace(height: 5),
      ],
    );
  }
}

class Previousjournals extends StatelessWidget {
  const Previousjournals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Gratitude Journals',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: gratitudeRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 1)
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
              final GratitudeModel model =
                  GratitudeModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const GratitudeJournal1(),
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
