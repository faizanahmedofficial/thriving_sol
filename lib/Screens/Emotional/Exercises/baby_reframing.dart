import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Screens/Emotional/er_home.dart';

import '../../../Common/bottom_buttons.dart';
import '../../../Common/journal_top.dart';
import '../../../Constants/constants.dart';
import '../../../Functions/date_picker.dart';
import '../../../Functions/functions.dart';
import '../../../Global/firebase_collections.dart';
import '../../../Model/app_user.dart';
import '../../../Model/er_models.dart';
import '../../../Services/auth_services.dart';
import '../../../Theme/input_decoration.dart';
import '../../../Widgets/app_bar.dart';
import '../../../Widgets/custom_images.dart';
import '../../../Widgets/custom_toast.dart';
import '../../../Widgets/drop_down_button.dart';
import '../../../Widgets/loading_dialog.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../Widgets/text_widget.dart';
import '../../../app_icons.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';

class PreviousBframing extends StatelessWidget {
  const PreviousBframing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Previous Baby Reframing',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: erRef
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
              onCompleteText: 'No previous entry to display...',
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(left: 15, right: 15),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              final BfModel data = BfModel.fromMap(snapshot.data.docs[index]);
              return InkWell(
                onTap: () => Get.to(
                  () => BabyReframing(),
                  arguments: [true, data],
                ),
                child: Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    children: [
                      titles(data.title!)
                          .marginOnly(left: 15, right: 15, top: 20),
                      ListTile(
                        title: title2(
                          'Unreasonable Expectation',
                          alignment: Alignment.centerLeft,
                        ),
                        subtitle: TextWidget(text: data.expectation!),
                        trailing: SizedBox(
                          width: 100,
                          child: TextWidget(
                            text: 'Belief Level: ${data.expBelief}',
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      ListTile(
                        title: title2('Reframed Version',
                            alignment: Alignment.centerLeft),
                        subtitle: TextWidget(text: data.reframed!),
                        trailing: SizedBox(
                          width: 100,
                          child: TextWidget(
                            text: 'Belief Level: ${data.reframedBelief}',
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ],
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

class BfController extends GetxController {
  final TextEditingController currentTime = TextEditingController(
    text: formateDate(DateTime.now()),
  );
  final TextEditingController title = TextEditingController(
    text: 'BabyReframing${formatTitelDate(DateTime.now())}',
  );

  RxInt urbelief = 0.obs;
  RxInt rfbelief = 0.obs;

  TextEditingController expectation = TextEditingController();
  TextEditingController reframed = TextEditingController();

  final Rx<BfModel> _babyReframing = BfModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  final bool edit = Get.arguments[0];

  DateTime initial = DateTime.now();

  @override
  void onInit() {
    if (edit) fetchData();
    super.onInit();
  }

  Future fetchData() async {
    _babyReframing.value = Get.arguments[1] as BfModel;
    currentTime.text = _babyReframing.value.date!;
    title.text = _babyReframing.value.title!;
    expectation.text = _babyReframing.value.expectation!;
    reframed.text = _babyReframing.value.reframed!;
    urbelief.value = _babyReframing.value.expBelief!;
    rfbelief.value = _babyReframing.value.reframedBelief!;
  }

  setData(DateTime end) {
    _babyReframing.value.date = currentTime.text;
    _babyReframing.value.title = title.text;
    _babyReframing.value.expBelief = urbelief.value;
    _babyReframing.value.expectation = expectation.text;
    _babyReframing.value.reframedBelief = rfbelief.value;
    _babyReframing.value.reframed = reframed.text;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _babyReframing.value.duration = _babyReframing.value.duration! + diff;
    } else {
      _babyReframing.value.duration = diff;
    }
  }

  Future addToFirebase([bool fromsave = false]) async {
    loadingDialog(Get.context!);
    final end = DateTime.now();
    setData(end);
    if (edit) _babyReframing.value.id = generateId();
    await erRef.doc(_babyReframing.value.id).set(_babyReframing.value.toMap());
    await addAccomplishment(end);
    if (!fromsave) {
      if (Get.find<ErController>().history.value.value == 70) {
        Get.find<ErController>()
            .updateHistory(end.difference(initial).inSeconds);
      }
      Get.back();
    }
    Get.back();
    customToast(message: 'Added successfully');
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == er);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: title.text,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _babyReframing.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future updatetoFirebase([bool fromsave = false]) async {
    loadingDialog(Get.context!);
    final end = DateTime.now();
    setData(end);
    await erRef
        .doc(_babyReframing.value.id)
        .update(_babyReframing.value.toMap());
    if (!fromsave) Get.back();
    Get.back();
    customToast(message: 'Updated successfully');
  }

  void clearData() {
    urbelief.value = 0;
    rfbelief.value = 0;
    expectation.clear();
    reframed.clear();
  }
}

class BabyReframing extends StatelessWidget {
  BabyReframing({Key? key}) : super(key: key);
  final BfController controller = Get.put(BfController());
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Future _add([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      await controller.addToFirebase(fromsave);
    }
  }

  Future _updated() async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      await controller.updatetoFirebase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(leading: backButton(), implyLeading: true),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomButtons(
            button1: 'Done',
            button2: 'Save',
            onPressed1: () async =>
                controller.edit ? await _updated() : await _add(),
            onPressed2: () async => await _add(true),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    title2('Baby Reframing (Practice)').marginOnly(bottom: 20),
                    IconButton(
                      onPressed: () => Get.to(
                        () => ReadingScreen(
                          title: 'ER100- A Brief Introduction to CBT',
                          link:
                              'https://docs.google.com/document/d/1HoVvGqqLHWLH-ATn-DoS4MXO_2ZlY9jD/',
                          linked: () =>
                              Get.to(() => BabyReframing(), arguments: [false]),
                          function: () {
                            if (Get.find<ErController>().history.value.value ==
                                68) {
                              final end = DateTime.now();
                              debugPrint('disposing');
                              Get.find<ErController>().updateHistory(
                                  end.difference(controller.initial).inSeconds);
                              debugPrint('disposed');
                            }
                            Get.log('closed');
                          },
                        ),
                      ),
                      icon: assetImage(AppIcons.read),
                    ),
                  ],
                ),
                JournalTop(
                  controller: controller.title,
                  add: () => controller.clearData(),
                  save: () async => controller.edit
                      ? await controller.updatetoFirebase(true)
                      : await controller.addToFirebase(true),
                  drive: () => Get.off(() => const PreviousBframing()),
                ).marginOnly(bottom: 5),
                subtitle(
                  'Identify an unreasonable expectation you had for yourself or someone else. How can you reframe that thought into a realistic expectation? If you\'re having trouble reframing then try to add gratitude, compassion, and rationality to the thought.',
                ).marginOnly(bottom: 15),
                dateWidget(),
                BfWidget(
                  question: 'What was your unreasonable expectation?',
                  controller: controller.expectation,
                  beliefVal: controller.urbelief.value,
                  hint: 'Unreasonable Expectation',
                  onchanged: (val) => controller.urbelief.value = val,
                ).marginOnly(bottom: height * 0.15),
                BfWidget(
                  question: 'Reframed Version',
                  controller: controller.reframed,
                  beliefVal: controller.rfbelief.value,
                  hint: 'Reframed/ Realistic Thought',
                  onchanged: (val) => controller.rfbelief.value = val,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dateWidget() {
    return InkWell(
      child: TextWidget(
        text: controller.currentTime.text,
        alignment: Alignment.center,
        textAlign: TextAlign.left,
        size: 16,
      ),
      onTap: () async {
        await customDatePicker(
          Get.context!,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        ).then((value) {
          controller.currentTime.text = formateDate(value);
        });
      },
    ).marginOnly(bottom: 50);
  }
}

class BfWidget extends StatelessWidget {
  const BfWidget({
    Key? key,
    required this.question,
    this.belief = 'Belief (1-10)',
    required this.controller,
    required this.beliefVal,
    required this.hint,
    this.onchanged,
  }) : super(key: key);
  final String question, belief, hint;
  final TextEditingController controller;
  final int beliefVal;
  final void Function(dynamic)? onchanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width * 0.7,
              child: TextWidget(text: question, weight: FontWeight.bold),
            ),
            TextWidget(text: belief, weight: FontWeight.bold),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width * 0.795,
              child: TextFormField(
                controller: controller,
                decoration: inputDecoration(hint: hint),
              ),
            ),
            CustomDropDownStruct(
              height: 48,
              child: DropdownButton(
                value: beliefVal,
                onChanged: onchanged,
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
}
