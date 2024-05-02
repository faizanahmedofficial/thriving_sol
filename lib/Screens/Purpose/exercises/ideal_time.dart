// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/bd_models.dart';
import 'package:schedular_project/Screens/custom_bottom.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_button.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../../Constants/constants.dart';
import '../../../Functions/date_picker.dart';
import '../../../Model/app_user.dart';
import '../../../Theme/input_decoration.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../readings.dart';
import '../bd_home.dart';

class IdealTimeScreen extends StatefulWidget {
  const IdealTimeScreen({Key? key}) : super(key: key);

  @override
  State<IdealTimeScreen> createState() => _IdealTimeScreenState();
}

class _IdealTimeScreenState extends State<IdealTimeScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController(
      text: 'IdealTimeUse ${formatTitelDate(DateTime.now())}');
  TextEditingController currentTime =
      TextEditingController(text: formateDate(DateTime.now()));

  RxList<TextEditingController> categoryList = <TextEditingController>[].obs;
  RxList<double> catePercentage = <double>[].obs;
  List<Color> colorList = const <Color>[
    Color(0xffADE256),
    Color(0xffE2CF56),
    Color(0xffE38955),
    Color(0xffE25667),
    Color(0xffE256AD),
    Color(0xffCF56E3),
    Color(0xff8B56E2),
    Color(0xff5868E3),
    Color(0xff57AEE3),
    Color(0xff57E2CF),
    Color(0xff56E289),
    Color(0xff68E357),
  ];

  void addCategory() {
    categoryList.add(TextEditingController());
    catePercentage.add(0.0);
  }

  void addCategories() {
    for (int i = 0; i < 10; i++) {
      addCategory();
    }
  }

  checkPercentage() {
    double total = 0.0;
    for (int i = 0; i < catePercentage.length; i++) {
      total = total + catePercentage[i];
    }
    if (total <= 100) {
      updateIndex();
    } else {
      Get.defaultDialog(
        title: 'Can\'t Proceed',
        middleText:
            'The total percentage of time spend on the entered categories, are exceeding from 100. Please verify the data again.',
        titlePadding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        middleTextStyle: const TextStyle(fontFamily: arail, fontSize: 14),
        titleStyle: const TextStyle(
          fontFamily: arail,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        textConfirm: 'Okay',
        onConfirm: () => Get.back(),
        buttonColor: Colors.black,
        confirmTextColor: Colors.white,
      );
    }
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
        bottomNavigationBar: BottomButtons(
          button1: index.value == 2 ? 'Done' : 'Continue',
          onPressed1: index.value == 2
              ? () async => edit ? await updateJournal() : await addJournal()
              : () => index.value == 0 ? updateIndex() : checkPercentage(),
          onPressed2: () async => await addJournal(true),
          onPressed3: () => index.value != 0 ? previousIndex() : Get.back(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _key,
            child: Column(
              children: [
                ExerciseTitle(
                  title: 'Ideal Time Use (Practice)',
                  onPressed: () => Get.to(
                    () => ReadingScreen(
                      title: 'Ideal Time Use',
                      link:
                          'https://docs.google.com/document/d/1zzGpY1ejo4qzuTphvlhnowj_Kgj7J34t/',
                      linked: () => Get.back(),
                      function: ()  {
                        if (Get.find<BdController>().history.value.value == 123)
                          {
                             final end = DateTime.now();
                            Get.find<BdController>().updateHistory(end.difference(initial).inSeconds);
                          }
                      },
                    ),
                  ),
                  // () => Get.to(() => const IdealTImeUseReading()),
                ).marginOnly(bottom: 10),
                JournalTop(
                  controller: name,
                  add: () => clearData(),
                  save: () async =>
                      edit ? await updateJournal(true) : await addJournal(true),
                  drive: () => Get.off(() => const PreviousIdealTime()),
                ).marginOnly(bottom: 20),
                index.value == 0
                    ? page1()
                    : index.value == 1
                        ? page2()
                        : index.value == 2
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
        titles(
          'Your Ideal Time Use',
          alignment: Alignment.center,
        ).marginOnly(bottom: 30, top: 30),
        SizedBox(
          height: height * 0.35,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 0,
              sections: List.generate(
                catePercentage.length,
                (index) => PieChartSectionData(
                  // showTitle: false,
                  radius: 150,
                  value: catePercentage[index] / 100,
                  color: index > colorList.length - 1
                      ? colorList[index - (colorList.length - 1)]
                      : colorList[index],
                  title: catePercentage[index].toInt().toString(),
                  titlePositionPercentageOffset: 1.1,
                ),
              ),
              // centerSpaceRadius: 0,
            ),
          ),
        ).marginOnly(top: 20, bottom: 20),
        GridView.builder(
          shrinkWrap: true,
          itemCount: categoryList.length,
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemBuilder: (context, index) {
            return Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 15,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: index > colorList.length - 1
                        ? colorList[index - (colorList.length - 1)]
                        : colorList[index],
                  ),
                ),
                TextWidget(
                  text: categoryList[index].text,
                  alignment: Alignment.center,
                  maxline: 1,
                  overflow: TextOverflow.visible,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget page2() {
    return Column(
      children: [
        const TextWidget(
          text: 'Ideal Time Use by Category',
          weight: FontWeight.bold,
          size: 17,
        ).marginOnly(bottom: 5),
        const TextWidget(
          text:
              'Estimate the ideal and realistic amount of time you will spend on each category in a given week. ',
          fontStyle: FontStyle.italic,
        ).marginOnly(bottom: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextWidget(text: 'Category', weight: FontWeight.bold),
            SizedBox(
              width: width * 0.5,
              child: const TextWidget(
                text: '% of week spent on this category',
                weight: FontWeight.bold,
                alignment: Alignment.centerRight,
              ),
            ),
          ],
        ).marginOnly(bottom: 10),
        Column(
          children: List.generate(
            categoryList.length,
            (index) => categoryWidget(index),
          ),
        ),
      ],
    ).marginOnly(left: 10, right: 10);
  }

  Widget categoryWidget(int index) {
    return Row(
      children: [
        SizedBox(width: width * 0.55, child: categoryField(index)),
        SizedBox(
          width: width * 0.2,
          child: TextFormField(
            keyboardType: TextInputType.number,
            initialValue: (catePercentage[index] == 0
                ? null
                : catePercentage[index].toString()),
            decoration: inputDecoration(hint: '%', radius: 0),
            onChanged: (val) {
              setState(() {
                catePercentage[index] = double.parse(val);
              });
            },
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              categoryList.removeAt(index);
              catePercentage.removeAt(index);
            });
          },
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.delete),
        ),
      ],
    ).marginOnly(bottom: 10);
  }

  Widget page1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: TextFormField(
            readOnly: true,
            controller: currentTime,
            onTap: () {
              customDatePicker(context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100))
                  .then((value) {
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
          ).marginOnly(bottom: 20),
        ),
        const TextWidget(
          text:
              'What are the categories of the things you do daily and what are the categories of the things you want to do daily? You will use this customized list of categories to categorize everything you do each day. That means it needs to be broad enough to capture all of your activities. It also should be narrow enough to capture the specific ways you want to spend your time.',
          fontStyle: FontStyle.italic,
          alignment: Alignment.center,
        ).marginOnly(bottom: 10),
        const TextWidget(
          text: 'Your Categories',
          weight: FontWeight.bold,
          size: 17,
        ).marginOnly(bottom: 10),
        Column(
          children: List.generate(
            categoryList.length,
            (index) => categoryField(index).marginOnly(bottom: 10),
          ),
        ),
        CustomIconTextButton(
          text: 'Add Category',
          onPressed: () => setState(() => addCategory()),
        ),
      ],
    ).marginOnly(left: 15, right: 15);
  }

  TextFormField categoryField(int index) {
    return TextFormField(
      controller: categoryList[index],
      decoration: inputDecoration(hint: 'Category', radius: 0),
    );
  }

  clearCategory() {
    categoryList.clear();
    catePercentage.clear();
  }

  clearData() {
    index.value = 0;
    clearCategory();
    addCategories();
  }

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;
  previousIndex() => index.value = index.value - 1;

  final bool edit = Get.arguments[0];
  final Rx<IdealTimeModel> _ideal = IdealTimeModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;
  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _ideal.value.name = name.text;
    _ideal.value.date = currentTime.text;
    _ideal.value.categories = <IdealCategory>[];
    for (int i = 0; i < categoryList.length; i++) {
      _ideal.value.categories!.add(IdealCategory(
        category: categoryList[i].text,
        percentage: catePercentage[i],
      ));
    }
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _ideal.value.duration = _ideal.value.duration! + diff;
    } else {
      _ideal.value.duration = diff;
    }
  }

  fetchData() {
    _ideal.value = Get.arguments[1] as IdealTimeModel;
    name.text = _ideal.value.name!;
    currentTime.text = _ideal.value.date!;
    clearCategory();
    for (int i = 0; i < _ideal.value.categories!.length; i++) {
      final IdealCategory _category = _ideal.value.categories![i];
      addCategory();
      categoryList[i].text = _category.category!;
      catePercentage[i] = _category.percentage!;
    }
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
        id: _ideal.value.id,
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
      if (edit) _ideal.value.id = generateId();
      await bdRef.doc(_ideal.value.id).set(_ideal.value.toMap());
       await addAccomplishment(end);
      Get.back();
      if (!fromsave) {
        if (Get.find<BdController>().history.value.value == 124) {
          Get.find<BdController>().updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
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
      await bdRef.doc(_ideal.value.id).update(_ideal.value.toMap());
      Get.back();
      if (!fromsave) Get.back();
      customToast(message: 'Updated successfully');
    }
  }

  @override
  void initState() {
    setState(() {
      addCategories();
      if (edit) fetchData();
    });
    super.initState();
  }
}

class PreviousIdealTime extends StatelessWidget {
  const PreviousIdealTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Ideal Time Use',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: bdRef
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
              final IdealTimeModel model =
                  IdealTimeModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const IdealTimeScreen(),
                      arguments: [true, model]),
                  title: TextWidget(
                    text: model.name!,
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
