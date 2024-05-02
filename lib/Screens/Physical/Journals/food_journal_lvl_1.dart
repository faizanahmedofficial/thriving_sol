// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
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
import 'package:schedular_project/Widgets/checkboxes.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/drop_down_button.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../../Model/app_user.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../readings.dart';
import '../diet_home.dart';

/// D101p- Food Journal Level 1 - Simple pg 1
class FJLvl1 extends StatefulWidget {
  const FJLvl1({Key? key}) : super(key: key);

  @override
  _FJLvl1State createState() => _FJLvl1State();
}

class _FJLvl1State extends State<FJLvl1> {
  var fjl1Key = GlobalKey<FormState>();
  // String portion = 'fist';
  TextEditingController name = TextEditingController();
  TextEditingController weight = TextEditingController();
  bool food = false;
  bool healthy = false;
  int type = 0;
  List<TextEditingController> foodController = <TextEditingController>[];
  List<TextEditingController> foodPortion = <TextEditingController>[];
  List<int> portionTypeList = <int>[];
  List<Padding> foodList = <Padding>[];
  int indx = 0;
  // List<bool> water = <bool>[false, false, false];
  // List<bool> portionsize = <bool>[false, false, false];
  // List<bool> eatslow = <bool>[false, false, false];
  // List<bool> eatuntil = <bool>[false, false, false];
  double water = 0.0;
  double portionsize = 0.0;
  double eatslow = 0.0;
  double eatuntil = 0.0;
  double fasting = 0.0;

  TextEditingController currentTime = TextEditingController();
  TextEditingController notes = TextEditingController();

  void addFood() {
    portionTypeList.add(0);
    TextEditingController _food = TextEditingController();
    foodController.add(_food);
    TextEditingController _count = TextEditingController();
    foodPortion.add(_count);
    foodList.add(foodWidget(indx));
  }

  @override
  void initState() {
    addFood();
    setState(() {
      name.text = 'FoodJournalLevel1SimpleEating${formatTitelDate(DateTime.now()).trim()}';
      currentTime.text = formateDate(DateTime.now());
      if (edit) fetchData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(leading: backButton(), implyLeading: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: fjl1Key,
          child: Column(
            children: [
              verticalSpace(height: 10),
              ExerciseTitle(
                title: 'Food Journal Level 1 - Simple Eating (Practice)',
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
                        Get.find<DietController>()
                            .updateHistory(end.difference(initial).inSeconds);
                      }
                      Get.log('closed');
                    },
                  ),
                ),
                // () => Get.to(() => const HandPortionGuideReading()),
              ),
              verticalSpace(height: 10),
              JournalTop(
                controller: name,
                add: () => clearData(),
                save: () async =>
                    edit ? await updateJournal(true) : await addJournal(true),
                drive: () => Get.off(() => const PreviousFoodJournal()),
              ),
              verticalSpace(height: 5),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10),
                child: TextWidget(
                  text:
                      'Track and rate how well you are following healthy eating habits. Simply stay consistant and see the transformation unfold.',
                  textAlign: TextAlign.left,
                  weight: FontWeight.bold,
                  alignment: Alignment.center,
                  fontStyle: FontStyle.italic,
                  size: 15,
                ),
              ),
              verticalSpace(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: TextFormField(
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
              ),
              verticalSpace(height: 10),
              CustomCheckBox(
                value: food,
                onChanged: (value) {
                  setState(() {
                    food = value!;
                  });
                },
                title: 'Food',
              ),
              if (food)
                Column(
                  children: [
                    Column(
                      children: [
                        for (int i = 0; i < foodList.length; i++) foodWidget(i),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            indx = indx + 1;
                          });
                          addFood();
                        },
                        icon: const Icon(Icons.add, color: Colors.black),
                        label: const TextWidget(text: 'Add Food'),
                      ),
                    ),
                  ],
                ),

              /// healthy
              CustomCheckBox(
                width: 200,
                value: healthy,
                onChanged: (value) {
                  setState(() {
                    healthy = value!;
                  });
                },
                title: 'Healthy Eating Habits',
              ),
              if (healthy)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// weight
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: Get.width * 0.2,
                          child: TextFormField(
                            controller: weight,
                            keyboardType: TextInputType.number,
                            decoration: inputDecoration(hint: '0.5'),
                          ),
                        ),
                        horizontalSpace(width: 7),
                        CustomDropDownStruct(
                          child: DropdownButton(
                            value: type,
                            onChanged: (val) {
                              setState(() {
                                type = val!;
                              });
                            },
                            items: weighUnitList
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
                        horizontalSpace(width: 7),
                        const Icon(
                          Icons.monitor_weight_outlined,
                          color: AppColors.black,
                        ).marginOnly(right: 5),
                        const TextWidget(
                          text: 'Weigh Yourself',
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: Get.width * 0.37,
                          child: RatingBar.builder(
                            allowHalfRating: true,
                            direction: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                const Icon(Icons.star),
                            onRatingUpdate: (rating) =>
                                setState(() => water = rating),
                            itemCount: 3,
                            initialRating: water,
                          ),
                        ),
                        const Icon(Icons.water, color: Colors.blue)
                            .marginOnly(right: 5),
                        const TextWidget(
                          text: 'Drink 1 gallon of water',
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: Get.width * 0.37,
                          child: RatingBar.builder(
                            allowHalfRating: true,
                            direction: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                const Icon(Icons.star),
                            onRatingUpdate: (rating) =>
                                setState(() => portionsize = rating),
                            itemCount: 3,
                            initialRating: portionsize,
                          ),
                        ),
                        const Icon(Icons.handyman, color: Colors.red)
                            .marginOnly(right: 7),
                        const TextWidget(
                          text: 'Measure Portion Size',
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: Get.width * 0.37,
                          child: RatingBar.builder(
                            allowHalfRating: true,
                            direction: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                const Icon(Icons.star),
                            onRatingUpdate: (rating) =>
                                setState(() => eatslow = rating),
                            itemCount: 3,
                            initialRating: eatslow,
                          ),
                        ),
                        const Icon(Icons.traffic, color: Colors.yellow)
                            .marginOnly(right: 7),
                        SizedBox(
                          width: Get.width * 0.4,
                          child: const TextWidget(
                            text: 'Eat Slow and mindfully savor each bite',
                            weight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: Get.width * 0.37,
                          child: RatingBar.builder(
                            allowHalfRating: true,
                            direction: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                const Icon(Icons.star),
                            onRatingUpdate: (rating) =>
                                setState(() => eatuntil = rating),
                            itemCount: 3,
                            initialRating: eatuntil,
                          ),
                        ),
                        const Icon(Icons.pie_chart_outline, color: Colors.grey)
                            .marginOnly(right: 7),
                        SizedBox(
                          width: width * 0.4,
                          child: const TextWidget(
                            text: 'Eat until 80% full then stop',
                            weight: FontWeight.bold,
                            maxline: 2,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: Get.width * 0.37,
                          child: RatingBar.builder(
                            allowHalfRating: true,
                            direction: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                const Icon(Icons.star),
                            onRatingUpdate: (rating) =>
                                setState(() => fasting = rating),
                            itemCount: 3,
                            initialRating: fasting,
                          ),
                        ),
                        const Icon(Icons.food_bank, color: Colors.blue)
                            .marginOnly(right: 5),
                        const TextWidget(
                          text: 'Intermittent Fasting',
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),

              /// bottom
              verticalSpace(height: Get.width * 0.25),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: notes,
                    decoration: inputDecoration(hint: 'Notes'),
                    maxLines: 4,
                  ).marginOnly(left: 15, right: 15),
                  BottomButtons(
                    button1: 'Done',
                    button2: 'Save',
                    onPressed2: () async => await addJournal(true),
                    onPressed1: () async =>
                        edit ? await updateJournal() : await addJournal(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding foodWidget(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const TextWidget(text: '#'),
              SizedBox(
                width: Get.width * 0.15,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: foodPortion[index],
                  decoration: inputDecoration(hint: '0.5'),
                ),
              ),
            ],
          ),
          Column(
            children: [
              const TextWidget(text: 'Hand Portions'),
              SizedBox(
                width: Get.width * 0.3,
                child: CustomDropDownStruct(
                  child: DropdownButton(
                    value: portionTypeList[index],
                    onChanged: (val) {
                      setState(() {
                        portionTypeList[index] = val;
                      });
                    },
                    hint: const TextWidget(
                      text: 'Fist',
                      alignment: Alignment.centerLeft,
                    ),
                    items: foodPortionList
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
                  ),
                ),
              ),
            ],
          ),
          const TextWidget(
              text: 'of', alignment: Alignment.bottomCenter, size: 16),
          Column(
            children: [
              const TextWidget(text: 'Food'),
              SizedBox(
                width: Get.width * 0.3,
                child: TextFormField(
                  controller: foodController[index],
                  decoration: inputDecoration(hint: 'Chicken Breast'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void clearData() {
    setState(() {
      indx = 0;
      // portion = 'fist';
      food = false;
      healthy = false;
      type = 0;
      water = 0.0;
      portionsize = 0.0;
      eatslow = 0.0;
      eatuntil = 0.0;
      fasting = 0.0;
    });
    name.clear();
    weight.clear();
    clearFood();

    ///
    addFood();
  }

  clearFood() {
    foodController.clear();
    foodPortion.clear();
    portionTypeList.clear();
    foodList.clear();
  }

  final bool edit = Get.arguments[0];
  final Rx<FoodJournalModel> _journal = FoodJournalModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;
  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _journal.value.name = name.text;
    _journal.value.date = currentTime.text;
    _journal.value.notes = notes.text;
    _journal.value.healthy = HealthyEatingModel(
      weight: WeightModel(
        weight: weight.text.isEmpty ? 0.0 : double.parse(weight.text),
        unit: type,
      ),
      water: water,
      eatUntil: eatuntil,
      slow: eatslow,
      portion: portionsize,
      fasting: fasting,
    );
    _journal.value.foods = <FoodModel>[];
    for (int i = 0; i < portionTypeList.length; i++) {
      _journal.value.foods!.add(
        FoodModel(
          type: portionTypeList[i],
          portion: foodPortion[i].text.isEmpty
              ? 0.0
              : double.parse(foodPortion[i].text),
          food: foodController[i].text,
          index: i,
        ),
      );
    }
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _journal.value.duration = _journal.value.duration! + diff;
    } else {
      _journal.value.duration = diff;
    }
  }

  fetchData() {
    _journal.value = Get.arguments[1] as FoodJournalModel;
    name.text = _journal.value.name!;
    currentTime.text = _journal.value.date!;
    final HealthyEatingModel _healthy = _journal.value.healthy!;
    healthy = true;
    final WeightModel _weight = _healthy.weight!;
    weight.text = _weight.weight.toString();
    type = _weight.unit!;
    water = _healthy.water!;
    eatuntil = _healthy.eatUntil!;
    eatslow = _healthy.slow!;
    portionsize = _healthy.portion!;
    fasting = _healthy.fasting!;
    notes.text = _journal.value.notes!;
    clearFood();
    for (int i = 0; i < _journal.value.foods!.length; i++) {
      food = true;
      final FoodModel _food = _journal.value.foods![i];
      addFood();
      portionTypeList[i] = _food.type!;
      foodPortion[i].text = _food.portion!.toString();
      foodController[i].text = _food.food!;
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
    fjl1Key.currentState!.save();
    if (fjl1Key.currentState!.validate()) {
      loadingDialog(context);
      final end = DateTime.now();
      setData(end);
      if (edit) _journal.value.id = generateId();
      await dietRef.doc(_journal.value.id).set(_journal.value.toMap());
      await addAccomplishment(end);
      Get.back();
      if (!fromsave) {
        if (Get.find<DietController>().history.value.value == 145) {
          Get.find<DietController>()
              .updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      customToast(message: 'Added sucessfully');
    }
  }

  Future updateJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    fjl1Key.currentState!.save();
    if (fjl1Key.currentState!.validate()) {
      loadingDialog(context);
      final end = DateTime.now();
      setData(end);
      await dietRef.doc(_journal.value.id).update(_journal.value.toMap());
      Get.back();
      if (!fromsave) Get.back();
      customToast(message: 'Update sucessfully');
    }
  }
}

class PreviousFoodJournal extends StatelessWidget {
  const PreviousFoodJournal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Food Journal Level 1 - Simple Eating',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: dietRef
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
              final FoodJournalModel model =
                  FoodJournalModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () =>
                      Get.to(() => const FJLvl1(), arguments: [true, model]),
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
