// ignore_for_file: avoid_print, unused_local_variable, no_leading_underscores_for_local_identifiers, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/diet_model.dart';
import 'package:schedular_project/Screens/custom_bottom.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/drop_down_button.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../../Functions/calender_logic.dart';
import '../../../Model/app_user.dart';
import '../../../Widgets/checkboxes.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../readings.dart';
import '../diet_home.dart';

class ES1Controller extends GetxController {
  TextEditingController currentTime = TextEditingController();

  /// 1
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController weight = TextEditingController();
  RxList<TextEditingController> proteinController =
      <TextEditingController>[].obs;
  RxList<Padding> proteins = <Padding>[].obs;
  RxList<TextEditingController> vegetableController =
      <TextEditingController>[].obs;
  RxList<Padding> vegetables = <Padding>[].obs;
  RxList<TextEditingController> carbsController = <TextEditingController>[].obs;
  RxList<Padding> carbs = <Padding>[].obs;
  RxList<TextEditingController> fatController = <TextEditingController>[].obs;
  RxList<Padding> fats = <Padding>[].obs;
  RxInt unit = 0.obs;

  /// 2
  TextEditingController want = TextEditingController();
  TextEditingController weightgain = TextEditingController();
  TextEditingController answer = TextEditingController();
  RxInt question1 = 0.obs;
  TextEditingController question2 = TextEditingController();
  RxInt gainUnit = 0.obs;
  RxBool calender = true.obs;

  ///
  void clearData() {
    index.value = 0;
    question1.value = 0;
    question2.clear();
    gainUnit.value = 0;
    calender.value = false;
    unit.value = 0;
    name.clear();
    date.clear();
    weight.clear();
    want.clear();
    weightgain.clear();
    answer.clear();
    clearCarbs();
    clearProtein();
    clearCarbs();
    clearFat();
  }

  clearFat() {
    findx.value = 0;
    fatController.clear();
    fats.clear();
  }

  clearCarbs() {
    cindx.value = 0;
    carbsController.clear();
    carbs.clear();
  }

  clearVegetables() {
    vindx.value = 0;
    vegetableController.clear();
    vegetables.clear();
  }

  clearProtein() {
    pindx.value = 0;
    proteinController.clear();
    proteins.clear();
  }

  RxInt pindx = 0.obs;
  RxInt vindx = 0.obs;
  RxInt cindx = 0.obs;
  RxInt findx = 0.obs;

  void addProtein() {
    TextEditingController _protein = TextEditingController();
    proteinController.add(_protein);
  }

  void addVegetable() {
    TextEditingController _vegetable = TextEditingController();
    vegetableController.add(_vegetable);
  }

  void addCarbs() {
    TextEditingController _carbs = TextEditingController();
    carbsController.add(_carbs);
  }

  void addFats() {
    TextEditingController _fats = TextEditingController();
    fatController.add(_fats);
  }

  void addFields() {
    addFats();
    addCarbs();
    addProtein();
    addVegetable();
  }

  ///
  @override
  void onInit() {
    getPreviousDates();
    getData();
    name.text =
        'EasyShoppingListLevel1${formatTitelDate(DateTime.now()).trim()}';
    currentTime.text = formateDate(DateTime.now());
    _setFields();
    if (edit) fetchData();
    super.onInit();
  }

  _setFields() {
    for (int i = 0; i < 3; i++) {
      pindx.value = i;
      vindx.value = i;
      cindx.value = i;
      findx.value = i;
      addFields();
    }
  }

  var fjl0Key = GlobalKey<FormState>();
  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;

  final bool edit = Get.arguments[0];
  final Rx<ShoppingListModel> _journal = ShoppingListModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _journal.value.name = name.text;
    _journal.value.operation = want.text;
    _journal.value.changeWeight = WeightModel(
      weight: weightgain.text.isEmpty ? 0.0 : double.parse(weightgain.text),
      unit: gainUnit.value,
    );
    _journal.value.progressing = answer.text;
    _journal.value.progressingValue = question1.value;
    _journal.value.goingForward = question2.text;
    _journal.value.date = date.text;
    _journal.value.weight = WeightModel(
      weight: weight.text.isEmpty ? 0.0 : double.parse(weight.text),
      unit: unit.value,
    );
    _journal.value.proteins = <String>[];
    for (int i = 0; i < proteinController.length; i++) {
      _journal.value.proteins!.add(proteinController[i].text);
    }
    _journal.value.vegetables = <String>[];
    for (int i = 0; i < vegetableController.length; i++) {
      _journal.value.vegetables!.add(vegetableController[i].text);
    }
    _journal.value.complexCarbs = <String>[];
    for (int i = 0; i < carbsController.length; i++) {
      _journal.value.complexCarbs!.add(carbsController[i].text);
    }
    _journal.value.healthyFats = <String>[];
    for (int i = 0; i < fatController.length; i++) {
      _journal.value.healthyFats!.add(fatController[i].text);
    }
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _journal.value.duration = _journal.value.duration! + diff;
    } else {
      _journal.value.duration = diff;
    }
  }

  fetchData() {
    _journal.value = Get.arguments[1] as ShoppingListModel;
    name.text = _journal.value.name!;
    want.text = _journal.value.operation!;
    final WeightModel _change = _journal.value.changeWeight!;
    weightgain.text = _change.weight!.toString();
    gainUnit.value = _change.unit!;
    answer.text = _journal.value.progressing!;
    question1.value = _journal.value.progressingValue!;
    question2.text = _journal.value.goingForward!;
    date.text = _journal.value.date!;
    final WeightModel _weight = _journal.value.weight!;
    weight.text = _weight.weight.toString();
    unit.value = _weight.unit!;
    clearProtein();
    for (int i = 0; i < _journal.value.proteins!.length; i++) {
      addProtein();
      pindx.value = i;
      proteinController[i].text = _journal.value.proteins![i];
    }
    clearVegetables();
    for (int i = 0; i < _journal.value.vegetables!.length; i++) {
      addVegetable();
      vindx.value = i;
      vegetableController[i].text = _journal.value.vegetables![i];
    }
    clearCarbs();
    for (int i = 0; i < _journal.value.complexCarbs!.length; i++) {
      addCarbs();
      cindx.value = i;
      carbsController[i].text = _journal.value.complexCarbs![i];
    }
    clearFat();
    for (int i = 0; i < _journal.value.healthyFats!.length; i++) {
      addFats();
      findx.value = i;
      fatController[i].text = _journal.value.proteins![i];
    }
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == diet);
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
    fjl0Key.currentState!.save();
    if (fjl0Key.currentState!.validate()) {
      loadingDialog(Get.context!);
      final end = DateTime.now();
      setData(end);
      if (edit) _journal.value.id = generateId();
      await dietRef.doc(_journal.value.id).set(_journal.value.toMap());
      await addAccomplishment(end);
      Get.back();
      if (!fromsave) {
        if (Get.find<DietController>().history.value.value == 146) {
          Get.find<DietController>()
              .updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      customToast(message: 'Added Successfully');
    }
  }

  Future updateJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    fjl0Key.currentState!.save();
    if (fjl0Key.currentState!.validate()) {
      loadingDialog(Get.context!);
      final end = DateTime.now();
      setData(end);
      await dietRef.doc(_journal.value.id).update(_journal.value.toMap());
      Get.back();
      if (!fromsave) Get.back();
      customToast(message: 'Updated Successfully');
    }
  }

  previousIndex() => index.value = index.value - 1;

  RxList<double> weightList = <double>[].obs;
  RxList<double> waterstars = <double>[].obs;
  RxList<double> measurestars = <double>[].obs;
  RxList<double> eatuntilstars = <double>[].obs;
  RxList<double> slowstars = <double>[].obs;
  RxList<double> fasting = <double>[].obs;
  RxList<int> dates = <int>[].obs;

  RxDouble first = 0.0.obs;
  RxDouble last = 0.0.obs;

  void getData() {
    final date =
        convertToDateTime(days[6]['date']).add(const Duration(days: 1));
    dietRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('date', isGreaterThanOrEqualTo: days[0]['date'])
        .where('date', isLessThanOrEqualTo: formateDate(date))
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        print('fetched');
        for (int i = 0; i < value.docs.length; i++) {
          var doc = value.docs[i];
          if (doc['type'] == 1) {
            final ShoppingListModel _shopping = ShoppingListModel.fromMap(doc);
          } else if (doc['type'] == 0) {
            dates.add(convertToDateTime(doc['date']).day);
            final FoodJournalModel _food = FoodJournalModel.fromMap(doc);
            final _heathly = _food.healthy!;
            if (i == 0) first.value = _heathly.weight!.weight!;
            if (i == (value.docs.length - 1)) {
              last.value = _heathly.weight!.weight!;
            }
            weightList.add(_heathly.weight!.weight!);
            waterstars.add(_heathly.water!);
            measurestars.add(_heathly.portion!);
            eatuntilstars.add(_heathly.eatUntil!);
            slowstars.add(_heathly.slow!);
            fasting.add(_heathly.fasting!);
          }
        }
        addDataRows();
        weightgain.text = (last.value - first.value).abs().toStringAsFixed(2);
        if ((last.value - first.value) < 0) {
          want.text = '-';
        } else {
          want.text = '+';
        }
      }
    }).whenComplete(() {});
  }

  RxList<Map<String, dynamic>> days = <Map<String, dynamic>>[].obs;
  void getPreviousDates() {
    for (int i = 0; i < 7; i++) {
      days.add({
        'day': getPreviousDate(i, DateTime.now()).day,
        'date': formateDate(getPreviousDate(i, DateTime.now())),
      });
    }
    days.assignAll(days.reversed.toList());
    print(days);
  }

  RxList<DataColumn> pcolumn() =>
      [DataColumn(label: Container()), datacolumn(' ')].obs;

  List<DataRow> prow() {
    return [
      DataRow(
        cells: [
          const DataCell(
            Icon(Icons.monitor_weight_outlined, color: AppColors.black),
          ),
          _cell(getWeightPercentage(), weight: FontWeight.bold),
        ],
      ),
      DataRow(
        cells: [
          const DataCell(Icon(Icons.water, color: Colors.blue)),
          _cell(getWaterPercentage(), weight: FontWeight.bold),
        ],
      ),
      DataRow(
        cells: [
          const DataCell(Icon(Icons.handyman, color: Colors.red)),
          _cell(getPortionPercentage(), weight: FontWeight.bold),
        ],
      ),
      DataRow(
        cells: [
          const DataCell(Icon(Icons.traffic, color: Colors.yellow)),
          _cell(getEatSlowPercentage(), weight: FontWeight.bold),
        ],
      ),
      DataRow(
        cells: [
          const DataCell(Icon(Icons.pie_chart_outline, color: Colors.grey)),
          _cell(getEatUntilPercentage(), weight: FontWeight.bold),
        ],
      ),
      DataRow(
        cells: [
          const DataCell(
            Icon(Icons.food_bank, color: Colors.blue),
          ),
          _cell(getFastingPercentage(), weight: FontWeight.bold),
        ],
      ),
    ];
  }

  List<DataColumn> columns() {
    return [
      divisions(),
      datacolumn(days[0]['day'].toString()),
      divisions(),
      datacolumn(days[1]['day'].toString()),
      divisions(),
      datacolumn(days[2]['day'].toString()),
      divisions(),
      datacolumn(days[3]['day'].toString()),
      divisions(),
      datacolumn(days[4]['day'].toString()),
      divisions(),
      datacolumn(days[5]['day'].toString()),
      divisions(),
      datacolumn(days[6]['day'].toString()),
      divisions(),
    ];
  }

  DataColumn divisions() => const DataColumn(label: VerticalDivider());
  DataCell rowdivisions() => const DataCell(VerticalDivider());

  DataCell _cell(String text, {FontWeight weight = FontWeight.normal}) {
    return DataCell(
      TextWidget(
        text: text,
        weight: weight,
        alignment: Alignment.centerLeft,
      ),
    );
  }

  RxList<DataRow> datarows = <DataRow>[].obs;

  void addWeight() {
    List<DataCell> cells = [];
    cells.add(rowdivisions());
    // print(dates.length);
    int windex = 0;
    for (int i = 0; i < days.length; i++) {
      try {
        bool add = false;
        if (dates.contains(days[i]['day'])) {
          // print(days[i]['day']);
          // print(weightList[windex]);
          cells.add(_cell(weightList[windex].toString()));
          cells.add(rowdivisions());
          windex = windex + 1;
          add = true;
        }
        // print('$i: $add');
        if (!add) {
          cells.add(_cell(''));
          cells.add(rowdivisions());
        }
      } catch (e) {
        cells.add(_cell(''));
        cells.add(rowdivisions());
      }
    }
    datarows.add(DataRow(cells: cells));
    // print(cells.length);
  }

  void addFasting() {
    List<DataCell> cells = [];
    cells.add(rowdivisions());
    // print(dates.length);
    int windex = 0;
    for (int i = 0; i < days.length; i++) {
      try {
        bool add = false;
        if (dates.contains(days[i]['day'])) {
          // print(days[i]['day']);
          // print(weightList[windex]);
          cells.add(_cell(fasting[windex].toString()));
          cells.add(rowdivisions());
          windex = windex + 1;
          add = true;
        }
        // print('$i: $add');
        if (!add) {
          cells.add(_cell(''));
          cells.add(rowdivisions());
        }
      } catch (e) {
        cells.add(_cell(''));
        cells.add(rowdivisions());
      }
    }
    datarows.add(DataRow(cells: cells));
    // setState(() {});
  }

  void addWater() {
    List<DataCell> cells = [];
    cells.add(rowdivisions());
    // print(dates.length);
    int windex = 0;
    for (int i = 0; i < days.length; i++) {
      try {
        bool add = false;
        if (dates.contains(days[i]['day'])) {
          // print(days[i]['day']);
          // print(weightList[windex]);
          cells.add(_cell(waterstars[windex].toString()));
          cells.add(rowdivisions());
          windex = windex + 1;
          add = true;
        }
        // print('$i: $add');
        if (!add) {
          cells.add(_cell(''));
          cells.add(rowdivisions());
        }
      } catch (e) {
        cells.add(_cell(''));
        cells.add(rowdivisions());
      }
    }
    datarows.add(DataRow(cells: cells));
    // setState(() {});
  }

  void addPortion() {
    List<DataCell> cells = [];
    cells.add(rowdivisions());
    // print(dates.length);
    int windex = 0;
    for (int i = 0; i < days.length; i++) {
      try {
        bool add = false;
        if (dates.contains(days[i]['day'])) {
          // print(days[i]['day']);
          // print(weightList[windex]);
          cells.add(_cell(measurestars[windex].toString()));
          cells.add(rowdivisions());
          windex = windex + 1;
          add = true;
        }
        // print('$i: $add');
        if (!add) {
          cells.add(_cell(''));
          cells.add(rowdivisions());
        }
      } catch (e) {
        cells.add(_cell(''));
        cells.add(rowdivisions());
      }
    }
    datarows.add(DataRow(cells: cells));
    // setState(() {});
  }

  void addEatUntil() {
    List<DataCell> cells = [];
    cells.add(rowdivisions());
    // print(dates.length);
    int windex = 0;
    for (int i = 0; i < days.length; i++) {
      try {
        bool add = false;
        if (dates.contains(days[i]['day'])) {
          // print(days[i]['day']);
          // print(weightList[windex]);
          cells.add(_cell(eatuntilstars[windex].toString()));
          cells.add(rowdivisions());
          windex = windex + 1;
          add = true;
        }
        // print('$i: $add');
        if (!add) {
          cells.add(_cell(''));
          cells.add(rowdivisions());
        }
      } catch (e) {
        cells.add(_cell(''));
        cells.add(rowdivisions());
      }
    }
    datarows.add(DataRow(cells: cells));
    // setState(() {});
  }

  void addEatSlow() {
    List<DataCell> cells = [];
    cells.add(rowdivisions());
    // print(dates.length);
    int windex = 0;
    for (int i = 0; i < days.length; i++) {
      try {
        bool add = false;
        if (dates.contains(days[i]['day'])) {
          // print(days[i]['day']);
          // print(weightList[windex]);
          cells.add(_cell(slowstars[windex].toString()));
          cells.add(rowdivisions());
          windex = windex + 1;
          add = true;
        }
        // print('$i: $add');
        if (!add) {
          cells.add(_cell(''));
          cells.add(rowdivisions());
        }
      } catch (e) {
        cells.add(_cell(''));
        cells.add(rowdivisions());
      }
    }
    datarows.add(DataRow(cells: cells));
    // setState(() {});
  }

  void addDataRows() {
    addWeight();
    addWater();
    addPortion();
    addEatSlow();
    addEatUntil();
    addFasting();
  }

  String getWeightPercentage() {
    if (weightList.isEmpty) {
      return '0';
    } else {
      double total = 0;
      print(weightList.length);
      for (int i = 0; i < weightList.length; i++) {
        total = total + weightList[i];
      }
      var divide = total / (weightList.length); //* 60
      // var percent = divide * 100;
      return divide.toStringAsFixed(1);
    }
  }

  String getFastingPercentage() {
    if (fasting.isEmpty) {
      return '0';
    } else {
      double total = 0;
      for (int i = 0; i < fasting.length; i++) {
        total = total + fasting[i];
      }
      var divide = total / (fasting.length); // *3
      // var percent = divide * 100;
      return divide.toStringAsFixed(1);
    }
  }

  String getWaterPercentage() {
    if (waterstars.isEmpty) {
      return '0';
    } else {
      double total = 0;
      for (int i = 0; i < waterstars.length; i++) {
        total = total + waterstars[i];
      }
      var divide = total / ((waterstars.length));
      // var percent = divide * 100;
      return divide.toStringAsFixed(1);
    }
  }

  String getPortionPercentage() {
    if (measurestars.isEmpty) {
      return '0';
    } else {
      double total = 0;
      for (int i = 0; i < measurestars.length; i++) {
        total = total + measurestars[i];
      }
      var divide = total / ((measurestars.length));
      // var percent = divide * 100;
      return divide.toStringAsFixed(1);
    }
  }

  String getEatUntilPercentage() {
    if (eatuntilstars.isEmpty) {
      return '0';
    } else {
      double total = 0;
      for (int i = 0; i < eatuntilstars.length; i++) {
        total = total + eatuntilstars[i];
      }
      var divide = total / ((eatuntilstars.length));
      // var percent = divide * 100;
      return divide.toStringAsFixed(1);
    }
  }

  String getEatSlowPercentage() {
    if (slowstars.isEmpty) {
      return '0';
    } else {
      double total = 0;
      for (int i = 0; i < slowstars.length; i++) {
        total = total + slowstars[i];
      }
      var divide = total / ((slowstars.length));
      // var percent = divide * 100;
      return divide.toStringAsFixed(1);
    }
  }

  DataColumn datacolumn(String text) {
    return DataColumn(
      label: TextWidget(text: text, alignment: Alignment.centerLeft),
    );
  }
}

class EasyShoppingList1 extends StatefulWidget {
  const EasyShoppingList1({Key? key}) : super(key: key);

  @override
  _EasyShoppingList1State createState() => _EasyShoppingList1State();
}

class _EasyShoppingList1State extends State<EasyShoppingList1> {
  final ES1Controller _journal = Get.put(ES1Controller());

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
            button1: _journal.index.value == 0 ? 'Continue' : 'Done',
            button2: 'Save',
            onPressed1: _journal.index.value == 0
                ? () => _journal.updateIndex()
                : () async => _journal.edit
                    ? await _journal.updateJournal()
                    : await _journal.addJournal(),
            onPressed2: () async => await _journal.addJournal(true),
            onPressed3: () => _journal.index.value != 0
                ? _journal.previousIndex()
                : Get.back(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _journal.fjl0Key,
            child: Column(
              children: [
                verticalSpace(height: 10),
                ExerciseTitle(
                  title: 'Easy Shopping List Level 1 (Practice)',
                  onPressed: () => Get.to(
                    () => ReadingScreen(
                      title: 'Hand Portion Guide',
                      link:
                          'https://docs.google.com/document/d/1h4sHSzdMNkD0xTMux4uyo9dMlXhIvqY8/',
                      linked: () => Get.back(),
                      function: () {
                        if (Get.find<DietController>().history.value.value ==
                            144) {
                          final end = DateTime.now();
                          Get.find<DietController>().updateHistory(
                              end.difference(_journal.initial).inSeconds);
                        }
                        Get.log('closed');
                      },
                    ),
                  ),
                  // () =>
                  //     Get.to(() => const HandPortionGuideReading()),
                ),
                verticalSpace(height: 10),
                JournalTop(
                  controller: _journal.name,
                  label: 'Name',
                  add: () => _journal.clearData(),
                  save: () async => _journal.edit
                      ? await _journal.updateJournal(true)
                      : await _journal.addJournal(true),
                  drive: () => Get.off(() => const PreviousShoppingList()),
                ),
                _journal.index.value == 0
                    ? page1()
                    : _journal.index.value == 1
                        ? page2()
                        : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding proteinWidget({required int index}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: SizedBox(
        width: Get.width * 0.4,
        child: TextFormField(
          controller: _journal.proteinController[index],
          decoration: inputDecoration(hint: 'Halibut'),
        ),
      ),
    );
  }

  Padding vegetableWidget({required int index}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: SizedBox(
        width: Get.width * 0.4,
        child: TextFormField(
          controller: _journal.vegetableController[index],
          decoration: inputDecoration(hint: 'Broccoli'),
        ),
      ),
    );
  }

  Padding carbsWidget({required int index}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: SizedBox(
        width: Get.width * 0.4,
        child: TextFormField(
          controller: _journal.carbsController[index],
          decoration: inputDecoration(hint: 'Sweet Potatos'),
        ),
      ),
    );
  }

  Padding fatsWidget({required int index}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: SizedBox(
        width: Get.width * 0.4,
        child: TextFormField(
          controller: _journal.fatController[index],
          decoration: inputDecoration(hint: 'Dark Chocolate'),
        ),
      ),
    );
  }

  Widget page2() {
    return Column(
      children: [
        verticalSpace(height: 10),
        const Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10),
          child: TextWidget(
            text: 'Weekly Review',
            textAlign: TextAlign.left,
            weight: FontWeight.bold,
            alignment: Alignment.center,
            fontStyle: FontStyle.italic,
            size: 17,
          ),
        ),
        verticalSpace(height: 5),
        CustomCheckBox(
          value: _journal.calender.value,
          title: 'Calendar',
          onChanged: (value) {
            setState(() {
              _journal.calender.value = value;
            });
          },
        ),

        /// Table
        if (_journal.calender.value)
          Column(
            children: [
              verticalSpace(height: 10),
              const TextWidget(
                text: 'Last 7 days',
                weight: FontWeight.bold,
                size: 15,
                alignment: Alignment.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 0.25,
                    child: DataTable(
                      columnSpacing: width * 0.05,
                      columns: _journal.pcolumn(),
                      rows: _journal.prow(),
                      showBottomBorder: true,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.69,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: width * 0.05,
                        showBottomBorder: true,
                        columns: _journal.columns(),
                        rows: _journal.datarows,
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(height: 20),
            ],
          ),

        /// Weight
        verticalSpace(height: 10),
        Row(
          children: [
            const Icon(Icons.monitor_weight_outlined, color: AppColors.black),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: Get.width * 0.25,
                child: TextFormField(
                  controller: _journal.want,
                  decoration: inputDecoration(hint: '+ or -'),
                  keyboardType: TextInputType.none,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[+,-]")),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: Get.width * 0.25,
              child: TextFormField(
                controller: _journal.weightgain,
                keyboardType: TextInputType.number,
                decoration: inputDecoration(hint: '3'),
              ),
            ),
            SizedBox(
              width: Get.width * 0.25,
              child: CustomDropDownStruct(
                height: 40,
                child: DropdownButton(
                  value: _journal.gainUnit.value,
                  onChanged: (val) {
                    setState(() {
                      _journal.gainUnit.value = val!;
                    });
                  },
                  items: weighUnitList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.value,
                          child: TextWidget(
                            text: e.title,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),

        /// question 1
        verticalSpace(height: 15),
        const TextWidget(
          text:
              'Am I progressing towards my ideal weight and/ or ideal body? If so, what is helping the most? If not, what habit (s) need more consistency?',
          textAlign: TextAlign.left,
          fontStyle: FontStyle.italic,
          weight: FontWeight.bold,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5, top: 10),
          child: Row(
            children: [
              SizedBox(
                width: Get.width * 0.15,
                child: TextFormField(
                  controller: _journal.answer,
                  decoration: inputDecoration(hint: 'Yes'),
                ),
              ),
              SizedBox(
                width: Get.width * 0.7,
                child: CustomDropDownStruct(
                  child: DropdownButton(
                    value: _journal.question1.value,
                    onChanged: (value) {
                      setState(() {
                        _journal.question1.value = value;
                      });
                    },
                    items: progressingList
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.value,
                            child: TextWidget(
                              text: e.title,
                              size: 10,
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        )
                        .toList(),
                    hint: const TextWidget(
                      text: 'Drink 1 gallon of water a day',
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        /// question 2
        verticalSpace(height: 15),
        const TextWidget(
          text:
              'What will I do to increase my chances of doing the habit going forward?',
          textAlign: TextAlign.left,
          fontStyle: FontStyle.italic,
          weight: FontWeight.bold,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5, top: 10),
          child: TextFormField(
            controller: _journal.question2,
            decoration: inputDecoration(
              hint:
                  'Find your deepest motivation, design your environment, be more mindful, reframe your food thoughts',
            ),
          ),
        ),
      ],
    );
  }

  Widget page1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(height: 5),
        const Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10),
          child: TextWidget(
            text:
                'Focus on eating whole food. Limit/ eliminate processed food/drinks and added sugar from your shopping list and diet',
            textAlign: TextAlign.left,
            weight: FontWeight.bold,
            alignment: Alignment.center,
            fontStyle: FontStyle.italic,
            size: 15,
          ),
        ),
        verticalSpace(height: 20),

        /// date
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, color: AppColors.black),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SizedBox(
                  width: Get.width * 0.5,
                  child: TextFormField(
                    readOnly: true,
                    controller: _journal.date,
                    decoration: inputDecoration(
                      hint: 'MM/DD/YYYY (Date)',
                    ),
                    onTap: () {
                      customDatePicker(
                        context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.utc(1900),
                        lastDate: DateTime.utc(2100),
                      ).then((value) {
                        _journal.date.text =
                            DateFormat('MM/dd/yyyy').format(value);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        /// weight
        verticalSpace(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Row(
            children: [
              const Icon(
                Icons.monitor_weight_outlined,
                color: AppColors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SizedBox(
                  width: Get.width * 0.3,
                  child: TextFormField(
                    controller: _journal.weight,
                    keyboardType: TextInputType.number,
                    decoration: inputDecoration(hint: '150'),
                  ),
                ),
              ),
              horizontalSpace(width: 10),
              CustomDropDownStruct(
                height: 45,
                child: DropdownButton(
                  value: _journal.unit.value,
                  onChanged: (val) {
                    setState(() {
                      _journal.unit.value = val!;
                    });
                  },
                  items: weighUnitList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.value,
                          child: TextWidget(
                            text: e.title,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),

        /// fields
        verticalSpace(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /// protein
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  text: 'Protein',
                  size: 15,
                  fontStyle: FontStyle.italic,
                  weight: FontWeight.bold,
                ),
                Column(
                  children: [
                    for (var i = 0; i < _journal.proteinController.length; i++)
                      proteinWidget(index: i),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _journal.pindx.value = _journal.pindx.value + 1;
                    });
                    _journal.addProtein();
                  },
                  icon: const Icon(Icons.add, color: AppColors.black),
                  label: const TextWidget(
                    text: 'Add Protein',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),

            /// Vegetables
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  text: 'Vegetables',
                  size: 15,
                  fontStyle: FontStyle.italic,
                  weight: FontWeight.bold,
                ),
                Column(
                  children: [
                    for (var i = 0;
                        i < _journal.vegetableController.length;
                        i++)
                      vegetableWidget(index: i),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _journal.vindx.value = _journal.vindx.value + 1;
                    });
                    _journal.addVegetable();
                  },
                  icon: const Icon(Icons.add, color: AppColors.black),
                  label: const TextWidget(
                    text: 'Add Vegetable',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
        verticalSpace(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /// complex carbs
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const TextWidget(
                  text: 'Complex Carbs',
                  size: 15,
                  fontStyle: FontStyle.italic,
                  weight: FontWeight.bold,
                ),
                Column(
                  children: [
                    for (var i = 0; i < _journal.carbsController.length; i++)
                      carbsWidget(index: i),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _journal.cindx.value = _journal.cindx.value + 1;
                    });
                    _journal.addCarbs();
                  },
                  icon: const Icon(Icons.add, color: AppColors.black),
                  label: const TextWidget(
                    text: 'Add Complex Carbs',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),

            /// Healthy Fats
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  text: 'Healthy Fats',
                  size: 15,
                  fontStyle: FontStyle.italic,
                  weight: FontWeight.bold,
                ),
                Column(
                  children: [
                    for (var i = 0; i < _journal.fatController.length; i++)
                      fatsWidget(index: i),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _journal.findx.value = _journal.findx.value + 1;
                    });
                    _journal.addFats();
                  },
                  icon: const Icon(Icons.add, color: AppColors.black),
                  label: const TextWidget(
                      text: 'Add Healthy Fats', fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class PreviousShoppingList extends StatelessWidget {
  const PreviousShoppingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Easy Shopping List Level 1',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: dietRef
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
              final ShoppingListModel model =
                  ShoppingListModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const EasyShoppingList1(),
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
