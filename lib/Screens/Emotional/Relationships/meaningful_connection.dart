// ignore_for_file: avoid_print, unnecessary_const, no_leading_underscores_for_local_identifiers, library_private_types_in_public_api

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Functions/time_picker.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/connection_models.dart';
import 'package:schedular_project/Screens/Emotional/connection_home.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/checkboxRows.dart';
import 'package:schedular_project/Widgets/checkboxes.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/drop_down_button.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../../Model/app_user.dart';
import '../../../Widgets/custom_images.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../app_icons.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';

class MeaningfulConnection extends StatefulWidget {
  const MeaningfulConnection({Key? key}) : super(key: key);

  @override
  _MeaningfulConnectionState createState() => _MeaningfulConnectionState();
}

class _MeaningfulConnectionState extends State<MeaningfulConnection> {
  final _key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  List<TextEditingController> activityname = <TextEditingController>[];
  List<TextEditingController> activitytime = <TextEditingController>[];
  List<TextEditingController> activity = <TextEditingController>[];
  List<String> pos = <String>[];
  List<String> durations = ['M', 'T', 'W', 'Th', 'F', 'Sa', 'Su'];
  List<List<bool>> values = <List<bool>>[];
  List<bool> val = [false, false, false, false, false, false, false];
  List<bool> biMonthly = <bool>[];
  List<TextEditingController> relationshipControllers =
      <TextEditingController>[];
  List<TextFormField> relationshipsList = <TextFormField>[];
  List<Widget> relationshipwidget = <Widget>[];
  // int indx = 0;
  String time = '';

  void addRelationship() {
    pos.add('1');
    biMonthly.add(false);
    values.add([false, false, false, false, false, false, false]);
    TextEditingController _relationship = TextEditingController();
    relationshipControllers.add(_relationship);
    TextEditingController _activityname = TextEditingController();
    activityname.add(_activityname);
    TextEditingController _activitytime = TextEditingController();
    activitytime.add(_activitytime);
    TextEditingController _activity = TextEditingController();
    activity.add(_activity);
    // relationshipsList.add(relationshipWidget(index: indx));
    // relationshipwidget.add(relationshipsWidget(indx));
  }

  void removeRelationship(int index) async {
    pos.removeAt(index);
    biMonthly.removeAt(index);
    values.removeAt(index);
    relationshipControllers.removeAt(index);
    activityname.removeAt(index);
    activitytime.removeAt(index);
    activity.removeAt(index);
    // relationshipsList.removeAt(index);
    // relationshipwidget.removeAt(index);
  }

  Future fetchRelationship() async {
    await connectionRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 3)
        .orderBy('created', descending: true)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        clearRelationship();
        print('fetching');
        for (var doc in value.docs) {
          final MRModel _model = MRModel.fromMap(doc);
          print('adding');
          for (int i = 0; i < _model.events!.length; i++) {
            final MREvent _event = _model.events![i];
            // indx = i;
            addRelationship();
            pos[i] = _event.pos!;
            biMonthly[i] = _event.biMonthly!;
            values[i] = _event.days!;
            relationshipControllers[i].text = _event.canDo!;
            activityname[i].text = _event.name!;
            activitytime[i].text = _event.time!;
            activity[i].text = _event.activity!;
          }
        }
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    setState(() {
      addRelationship();
      name.text =
          'MeaningfulRelationships${formatTitelDate(DateTime.now()).trim()}';
      currentTime.text = formateDate(DateTime.now());
      fetchRelationship();
      if (edit) fetchData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(leading: backButton(), implyLeading: true),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomButtons(
          button1: 'Done',
          button2: 'Save',
          onPressed1: () async => edit ? await updateMR() : await addMR(),
          onPressed2: () async => await addMR(true),
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
                  const TextWidget(
                    text: 'Meaningful Relationships (Practice)',
                    weight: FontWeight.bold,
                    alignment: Alignment.center,
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    onPressed: () => Get.to(
                      () => ReadingScreen(
                        title: 'C101- Building Meaningful Relationship',
                        link:
                            'https://docs.google.com/document/d/1cFCoktCffSynkSe4UVPe3ALGEPg05uVc/',
                        linked: () => Get.back(),
                        function: () {
                          if (Get.find<ConnectionController>()
                                  .history
                                  .value
                                  .value ==
                              96) {
                                 final end = DateTime.now();
                            debugPrint('disposing');
                            Get.find<ConnectionController>().updateHistory(end.difference(initial).inSeconds);
                            debugPrint('disposed');
                          }
                          Get.log('closed');
                        },
                      ),
                    ),
                    // Get.to(() => const BuildMeaningfulConnection()),
                    icon: assetImage(AppIcons.read),
                  ),
                ],
              ),
              verticalSpace(height: 10),
              JournalTop(
                controller: name,
                label: 'Name',
                add: () => clearJournalData(),
                save: () async =>
                    edit ? await updateMR(true) : await addMR(true),
                drive: () => Get.off(() => const PreviousRelationships()),
              ),
              verticalSpace(height: 15),

              ///
              Center(
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
              verticalSpace(height: 30),

              ///
              const TextWidget(
                text: 'Meaningful Relationships',
                weight: FontWeight.bold,
              ),
              const Divider(color: Colors.black),

              ///
              Column(
                children: [
                  for (int i = 0; i < activityname.length; i++)
                    relationshipsWidget(i),
                ],
              ),

              ///
              verticalSpace(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      addRelationship();
                      // indx = indx + 1;
                    });
                  },
                  label: const TextWidget(
                    text: 'Add a meaningful relationship',
                    fontStyle: FontStyle.italic,
                  ),
                  icon: const Icon(Icons.add, color: AppColors.black),
                ),
              ),

              ///
              verticalSpace(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField relationshipWidget({required int index}) {
    return TextFormField(
      controller: relationshipControllers[index],
      decoration: inputDecoration(
        hint: 'What can I do to be a better partner?',
      ),
    );
  }

  Widget relationshipsWidget(int index) {
    return Column(
      children: [
        verticalSpace(height: 20),
        Container(
          width: Get.width,
          height: 150,
          decoration: const ShapeDecoration(
            shape: const RoundedRectangleBorder(
              side: const BorderSide(width: 1.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(const Radius.circular(0)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Get.width * 0.5,
                      child: TextFormField(
                        controller: activityname[index],
                        decoration: inputDecoration(hint: 'Name'),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.5,
                      child: CustomDropDownStruct(
                        height: 50,
                        child: DropdownButton<String>(
                          value: pos[index],
                          onChanged: (val) {
                            setState(() {
                              pos[index] = val!;
                            });
                          },
                          items: posList
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  value: e.description,
                                  child: TextWidget(
                                    text: e.title,
                                    maxline: 3,
                                    alignment: Alignment.centerLeft,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: activitytime[index],
                      decoration: inputDecoration(
                        hint: 'Scheduled Time (HH:MM:SS)',
                      ),
                      onTap: () {
                        customTimePicker(
                          context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          setState(() {
                            time = value.format(context);
                            activitytime[index].text = value.format(context);
                          });
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width * 0.435,
                // height: 150,
                child: Align(
                  // alignment: Alignment.bottomCenter,
                  child: TextFormField(
                    maxLines: 7,
                    controller: activity[index],
                    decoration: inputDecoration(hint: 'Schedule Activity'),
                  ),
                ),
              ),
            ],
          ),
        ),

        ///
        verticalSpace(height: 5),
        CustomCheckBox(
          value: biMonthly[index],
          title: 'Bi-Monthly',
          alignment: Alignment.centerLeft,
          onChanged: (value) {
            setState(() {
              biMonthly[index] = value;
            });
          },
        ),
        CheckBoxRows(
          titles: durations,
          values: values[index],
          titleAlignment: Alignment.centerLeft,
          size: 60,
        ),

        ///
        verticalSpace(height: 7),
        TextButton(
          onPressed: () => addtoCalendar(index), //Get.toNamed('/Habits')
          child: const TextWidget(
            text: 'Add to Calendar',
            size: 13,
            fontStyle: FontStyle.italic,
          ),
        ),
        verticalSpace(height: 5),
        relationshipWidget(index: index),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              // print(indx);
              removeRelationship(index);
              // indx = indx - 1;
              setState(() {});
            },
            icon: const Icon(Icons.delete),
          ),
        ),
      ],
    );
  }

  Future addtoCalendar(int index) async {
    final Event event = Event(
      title: activityname[index].text,
      description: activity[index].text,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 2)),
      recurrence: Recurrence(
        frequency: biMonthly[index] ? Frequency.monthly : Frequency.weekly,
      ),
    );
    await Add2Calendar.addEvent2Cal(event).then((value) {
      if (value) {
        customToast(message: 'Visualization added to calendar successfully');
      }
    });
  }

  void clearJournalData() {
    setState(() {
      durations = ['M', 'T', 'W', 'Th', 'F', 'Sa', 'Su'];
      values.clear();
      biMonthly.clear();
      // indx = 0;
      time = '';
    });
    pos.clear();
    name.clear();
    activity.clear();
    activityname.clear();
    activitytime.clear();
    relationshipsList.clear();
    relationshipControllers.clear();
    relationshipwidget.clear();

    ///
    addRelationship();
  }

  TextEditingController currentTime = TextEditingController();

  final bool edit = Get.arguments[0];
  final Rx<MRModel> _relationships = MRModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _relationships.value.title = name.text;
    _relationships.value.date = currentTime.text;
    _relationships.value.events = <MREvent>[];
    for (int i = 0; i < activity.length; i++) {
      _relationships.value.events!.add(
        MREvent(
          activity: activity[i].text,
          biMonthly: biMonthly[i],
          days: values[i],
          time: activitytime[i].text,
          pos: pos[i],
          canDo: relationshipControllers[i].text,
          name: activityname[i].text,
          date: currentTime.text,
        ),
      );
    }
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _relationships.value.duration = _relationships.value.duration! + diff;
    } else {
      _relationships.value.duration = diff;
    }
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == connection);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: name.text,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _relationships.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addMR([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      loadingDialog(context);
       final end = DateTime.now();
      setData(end);
      if (edit) _relationships.value.id = generateId();
      await connectionRef
          .doc(_relationships.value.id)
          .set(_relationships.value.toMap());
          await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<ConnectionController>().history.value.value == 97) {
          Get.find<ConnectionController>().updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      Get.back();
      customToast(message: 'Added successfully');
    }
  }

  Future updateMR([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      loadingDialog(context);
       final end = DateTime.now();
      setData(end);
      await connectionRef
          .doc(_relationships.value.id)
          .update(_relationships.value.toMap());
      if (!fromsave) Get.back();
      Get.back();
      customToast(message: 'Updated successfully');
    }
  }

  clearRelationship() {
    pos.clear();
    biMonthly.clear();
    values.clear();
    relationshipControllers.clear();
    activityname.clear();
    activitytime.clear();
    activity.clear();
    relationshipsList.clear();
    relationshipwidget.clear();
  }

  fetchData() {
    _relationships.value = Get.arguments[1] as MRModel;
    name.text = _relationships.value.title!;
    currentTime.text = _relationships.value.date!;
    clearRelationship();
    for (int i = 0; i < _relationships.value.events!.length; i++) {
      final MREvent _event = _relationships.value.events![i];
      // indx = i;
      addRelationship();
      pos[i] = _event.pos!;
      biMonthly[i] = _event.biMonthly!;
      values[i] = _event.days!;
      relationshipControllers[i].text = _event.canDo!;
      activityname[i].text = _event.name!;
      activitytime[i].text = _event.time!;
      activity[i].text = _event.activity!;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class PreviousRelationships extends StatelessWidget {
  const PreviousRelationships({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Meaningful Relationships',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: connectionRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 3)
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
              final MRModel model = MRModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const MeaningfulConnection(),
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
