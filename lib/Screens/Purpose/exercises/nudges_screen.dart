// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/bd_models.dart';
import 'package:schedular_project/Model/routine_model.dart';
import 'package:schedular_project/Screens/custom_bottom.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/buttons_theme.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_images.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/drop_down_button.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/text_widget.dart';
import 'package:schedular_project/app_icons.dart';

import '../../../Model/app_modal.dart';
import '../../../Model/app_user.dart';
import '../../readings.dart';
import '../Readings/bd_reading.dart';
import '../bd_home.dart';

class NudgesScreen extends StatefulWidget {
  const NudgesScreen({Key? key}) : super(key: key);

  @override
  State<NudgesScreen> createState() => _NudgesScreenState();
}

class _NudgesScreenState extends State<NudgesScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController(
    text: 'Nudges ${formatTitelDate(DateTime.now())}',
  );
  final TextEditingController currentDate = TextEditingController(
    text: formateDate(DateTime.now()),
  );

  RxInt routine = 0.obs;
  RxInt cue = 0.obs;
  RxInt chain = 0.obs;
  RxInt reward = 0.obs;
  RxInt setup = 0.obs;

  @override
  void initState() {
    setState(() {
      fetchRoutines();
      if (edit) fetchData();
    });
    super.initState();
  }

  RxList<AppModel> routinesList =
      <AppModel>[AppModel('Choose Routine', '', value: 0, type: -1)].obs;
  RxInt rindex = 1.obs;
  int routineIndex(int value) =>
      routinesList.indexWhere((element) => element.value == value);
  Future fetchRoutines() async {
    await routineRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          final RoutineModel routineModel = RoutineModel.fromMap(doc);

          for (int i = 0; i < routineModel.routines!.length; i++) {
            final Routines routine = routineModel.routines![i];
            if (routine.elements!.isNotEmpty) {
              routinesList.add(
                AppModel(
                  routine.name!,
                  routineModel.id!,
                  value: rindex.value,
                ),
              );
              rindex.value = rindex.value + 1;
            }
          }
        }
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(
          leading: backButton(
            () => index.value == 0 ? Get.back() : previousIndex(),
          ),
          implyLeading: true,
        ),
        bottomNavigationBar: Container(
          height: 70,
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              index.value == 0
                  ? SizedBox(
                      width: width * 0.3,
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: outlineButton(),
                        child: const TextWidget(
                          text: 'Cancel',
                          alignment: Alignment.center,
                          size: 16,
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () => previousIndex(),
                      child: const CustomImageWidget(image: AppIcons.share),
                    ),
              SizedBox(
                width: width * 0.5,
                child: OutlinedButton(
                  onPressed: index.value == 0
                      ? () => updateIndex()
                      : () async =>
                          edit ? await updateNudge() : await _addNudge(),
                  style: outlineButton(),
                  child: TextWidget(
                    text: index.value == 0 ? 'Continue' : 'Done',
                    alignment: Alignment.center,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _key,
            child: index.value == 0
                ? page1()
                : index.value == 1
                    ? page2()
                    : Container(),
          ),
        ),
      ),
    );
  }

  TextEditingController wchain = TextEditingController();
  TextEditingController wreward = TextEditingController();
  TextEditingController wcue = TextEditingController();
  TextEditingController wsetup = TextEditingController();

  Widget page2() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(border: Border.all()),
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 20,
            bottom: 30,
          ),
          child: TextWidget(
            text: routinesList[routineIndex(routine.value)].title.capitalize!,
            alignment: Alignment.center,
            textAlign: TextAlign.center,
            weight: FontWeight.bold,
            size: 17,
          ),
        ),
        ExerciseTitle(
          title: 'Your Nudges',
          onPressed: () => Get.to(() => const Bd101Reading()),
        ).marginOnly(bottom: 30),
        dropdownWidget(
          cue.value,
          (p0) => cue.value = p0,
          cueList,
          AppIcons.cue,
          'Cue',
          cue.value == 3,
          wcue,
        ).marginOnly(bottom: 30),
        dropdownWidget(
          chain.value,
          (p0) => chain.value = p0,
          chainList,
          AppIcons.chain,
          'Chain',
          chain.value == 0,
          wchain,
        ).marginOnly(bottom: 30),
        dropdownWidget(
          reward.value,
          (p0) => reward.value = p0,
          rewardList,
          AppIcons.reward,
          'Reward',
          reward.value == 8,
          wreward,
        ).marginOnly(bottom: 30),
        dropdownWidget(
          setup.value,
          (p0) => setup.value = p0,
          setupList,
          AppIcons.setup,
          'Setup',
          setup.value == 4,
          wsetup,
        ).marginOnly(bottom: 0),
        Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () {},
            child: const CustomImageWidget(image: AppIcons.add),
          ),
        ),
      ],
    );
  }

  Widget dropdownWidget(
    int value,
    Function(dynamic)? onChanged,
    List<AppModel> list,
    String icon,
    String title,
    bool writein,
    TextEditingController write,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomImageWidget(
          image: icon,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(text: title, size: 16),
            CustomDropDownStruct(
              child: DropdownButton(
                value: value,
                onChanged: onChanged,
                items: list
                    .map((e) => DropdownMenuItem(
                        value: e.value,
                        child: SizedBox(
                          width: width * 0.6,
                          child: TextWidget(
                            text: e.title,
                            alignment: Alignment.centerLeft,
                          ),
                        )))
                    .toList(),
              ),
            ),
            if (writein)
              SizedBox(
                width: width * 0.7,
                child: TextFormField(
                  controller: write,
                  decoration: inputDecoration(hint: 'Write in...'),
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
        ExerciseTitle(
          title: 'Nudges (Practice)',
          onPressed: () => Get.to(
            () => ReadingScreen(
              title: 'BD101- Habits & Behavioral Design',
              link:
                  'https://docs.google.com/document/d/1WKopjoxtn5Bc8KueOEPt0C4xQ02T3zAm/',
              linked: () => Get.back(),
              function: ()  {
                if (Get.find<BdController>().history.value.value == 116)
                  {
                     final end = DateTime.now();
                    Get.find<BdController>().updateHistory(end.difference(initial).inSeconds);
                  }
                Get.log('closed');
              },
            ),
          ),
          //  () => Get.to(() => const Bd101Reading()),
        ).marginOnly(bottom: 15),
        subtitle(
          'Design your surroundings and hack your mind to make showing up to your routine easy and natural. Drastically increase the likelihood of showing up and create lifelong habits.',
        ).marginOnly(bottom: 40),
        const TextWidget(text: 'Choose a routine to add nudges to')
            .marginOnly(top: 40),
        CustomDropDownStruct(
          height: 95,
          width: width,
          child: DropdownButton(
            value: routine.value,
            onChanged: (val) => routine.value = val,
            items: routinesList
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
    );
  }

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;
  previousIndex() => index.value = index.value - 1;

  final bool edit = Get.arguments[0];
  final Rx<NudgeModel> _nudge = NudgeModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _nudge.value.chain = chain.value;
    _nudge.value.cue = cue.value;
    _nudge.value.reward = reward.value;
    _nudge.value.setup = setup.value;
    _nudge.value.routine = routine.value;
    _nudge.value.chainWritein = wchain.text;
    _nudge.value.rewardWritein = wreward.text;
    _nudge.value.cueWritein = wcue.text;
    _nudge.value.setups = wsetup.text;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _nudge.value.duration = _nudge.value.duration! + diff;
    } else {
      _nudge.value.duration = diff;
    }
  }

  fetchData() {
    _nudge.value = Get.arguments[1] as NudgeModel;
    chain.value = _nudge.value.chain!;
    cue.value = _nudge.value.cue!;
    reward.value = _nudge.value.reward!;
    setup.value = _nudge.value.setup!;
    routine.value = _nudge.value.routine!;
    wchain.text = _nudge.value.chainWritein!;
    wcue.text = _nudge.value.cueWritein!;
    wsetup.text = _nudge.value.setups!;
    wreward.text = _nudge.value.rewardWritein!;
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == bd);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: name.text,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _nudge.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future _addNudge([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      loadingDialog(context);
      final end = DateTime.now();
      setData(end);
      if (edit) _nudge.value.id = generateId();
      await bdRef.doc(_nudge.value.id).set(_nudge.value.toMap());
      final _selected = routinesList[
          routinesList.indexWhere((element) => element.value == routine.value)];
      await routineRef.doc(_selected.description).get().then((value) {
        if (value.data() != null) {
          final RoutineModel model = RoutineModel.fromMap(value.data());
          final routine = model.routines!
              .where((element) => element.name == _selected.title);
          if (routine.isNotEmpty) {
            print('adding');
            routine.first.nudges = Nudges(
              chain: chain.value,
              cue: cue.value,
              reward: reward.value,
              setup: setup.value == 4
                  ? wsetup.text
                  : setupList[setupList.indexWhere(
                          (element) => element.value == setup.value)]
                      .title,
              wchain: wchain.text,
              wcue: wcue.text,
              wreward: wreward.text,
            );
            routineRef.doc(_selected.description).update(model.toMap());
          }
        }
      });
      await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<BdController>().history.value.value == 117) {
          Get.find<BdController>().updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      Get.back();
      customToast(message: 'Added successfully');
    }
  }

  Future updateNudge([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      loadingDialog(context);
      final end = DateTime.now();
      setData(end);
      await bdRef.doc(_nudge.value.id).update(_nudge.value.toMap());
      Get.back();
      if (!fromsave) Get.back();
      customToast(message: 'Updated successfully');
    }
  }
}
