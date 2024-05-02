// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Screens/Emotional/connection_home.dart';
import 'package:schedular_project/Widgets/custom_images.dart';
import 'package:schedular_project/Widgets/custom_snackbar.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/app_icons.dart';
import '../../../Constants/constants.dart';
import '../../../Functions/time_picker.dart';
import '../../../Model/app_user.dart';
import '../../../Model/connection_models.dart';
import '../../../Services/auth_services.dart';
import '../../../Widgets/checkboxRows.dart';
import '../../../Widgets/progress_indicator.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/checkboxes.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../custom_bottom.dart';
import '../../readings.dart';

class CJ2Controller extends GetxController {
  /// 1
  TextEditingController name = TextEditingController();
  TextEditingController currentTime = TextEditingController();
  TextEditingController how = TextEditingController();
  RxBool reachout = false.obs;
  RxBool acknowledge = false.obs;
  RxBool forHelp = false.obs;
  RxBool toHelp = false.obs;
  RxBool randomAct = false.obs;

  /// 2
  RxList<TextEditingController> anameController = <TextEditingController>[].obs;
  RxList<TextEditingController> activityController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> posController = <TextEditingController>[].obs;
  RxList<TextEditingController> dateController = <TextEditingController>[].obs;
  RxList<TextEditingController> timeController = <TextEditingController>[].obs;
  RxList<TextEditingController> partnerController =
      <TextEditingController>[].obs;
  RxList<String> time = <String>[].obs;
  RxList<bool> showupList = <bool>[].obs;
  RxList<Column> activityList = <Column>[].obs;
  RxList<bool> editable = <bool>[].obs;
  RxList<String> docList = <String>[].obs;
  RxList<String> subDocList = <String>[].obs;
  RxList<String> eventidList = <String>[].obs;
  RxList<List<bool>> daysList = <List<bool>>[].obs;

  ///
  void clearJournalData() {
    reachout.value = false;
    acknowledge.value = false;
    forHelp.value = false;
    toHelp.value = false;
    randomAct.value = false;
    name.clear();
    how.clear();

    ///
    clearActivity();
  }

  clearActivity() {
    time.clear();
    editable.clear();
    activityList.clear();
    showupList.clear();
    partnerController.clear();
    anameController.clear();
    activityController.clear();
    posController.clear();
    dateController.clear();
    timeController.clear();
    docList.clear();
    subDocList.clear();
    eventidList.clear();
    daysList.clear();
  }

  final page1 = GlobalKey<FormState>();

  @override
  void onInit() async {
    name.text = 'ConnectionJournalLevel2MeaningfulRelationships&Community${formatTitelDate(DateTime.now()).trim()}';
    currentTime.text = formateDate(DateTime.now());
    await fetchMR();
    // await fetchCommunity();
    if (edit) fetchData();
    super.onInit();
  }

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;
  previousIndex() => index.value = index.value - 1;

  final RxList<MRModel> relationshipList = <MRModel>[].obs;
  final RxInt relationshipcount = 0.obs;

  void addActivity() {
    TextEditingController _name = TextEditingController();
    anameController.add(_name);
    TextEditingController _pos = TextEditingController();
    posController.add(_pos);
    TextEditingController _activity = TextEditingController();
    activityController.add(_activity);
    TextEditingController _date = TextEditingController();
    dateController.add(_date);
    TextEditingController _time = TextEditingController();
    timeController.add(_time);
    TextEditingController _partner = TextEditingController();
    partnerController.add(_partner);
    // time.add('');
    editable.add(false);
    showupList.add(false);
    daysList.add([false, false, false, false, false, false, false]);
  }

  final RxInt _relation = 0.obs;
  Future fetchMR() async {
    await connectionRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 3)
        .orderBy('created', descending: true)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        print('Fetcing relationships');
        print(value.docs.length);
        for (var doc in value.docs) {
          if (doc['type'] == 3) {
            final MRModel _mr = MRModel.fromMap(doc);
            relationshipList.add(_mr);
            fetchMRActivities(_mr.events!, _mr.date!);
          } else if (doc['type'] == 4) {
            final CommunityModel _mr = CommunityModel.fromMap(doc);
            communities.add(_mr);
            fetchCommunityActivities(_mr.events!, _mr.date!);
          }
        }
      }
    }).then((value) => fetchCommunity());
  }

  RxInt rindex = 0.obs;
  fetchMRActivities(List<MREvent> events, String date, [bool fromInit = true]) {
    for (int i = 0; i < events.length; i++) {
      _relation.value = _relation.value + 1;
      final MREvent _event = events[i];
      addActivity();
      if (fromInit) {
        rindex.value = i;
      } else {
        rindex.value = rindex.value + 1;
      }
      print('fetching relationship events');
      anameController[rindex.value].text = _event.name!;
      posController[rindex.value].text = _event.pos!;
      activityController[rindex.value].text = _event.activity!;
      dateController[rindex.value].text = _event.date ?? date;
      timeController[rindex.value].text = _event.time!;
      // partnerController[rindex.value].text = _event.canDo!;
      showupList[rindex.value] = _event.showup!;
      daysList[rindex.value] =
          _event.days ?? [false, false, false, false, false, false, false];
      relationshipcount.value = relationshipcount.value + 1;
    }
  }

  RxBool load = false.obs;
  RxInt total = 0.obs;

  final RxList<CommunityModel> communities = <CommunityModel>[].obs;

  Future fetchCommunity() async {
    await connectionRef
        .where('userid', isEqualTo: Get.find<AuthServices>().userid)
        .where('type', isEqualTo: 4)
        .orderBy('created', descending: true)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        print('fetching community');
        for (var doc in value.docs) {
          final CommunityModel _mr = CommunityModel.fromMap(doc);
          communities.add(_mr);
          fetchCommunityActivities(_mr.events!, _mr.date!);
        }
      }
    });
  }

  fetchCommunityActivities(List<CommunityEvent> events, String date,
      [bool fromInit = true]) {
    print(rindex.value);
    for (int i = 0; i < events.length; i++) {
      final CommunityEvent _event = events[i];

      if (anameController.isEmpty) {
        rindex.value = i;
        print('1st');
      } else {
        rindex.value = rindex.value + 1;
        print('fetching community events');
      }
      addActivity();
      anameController[rindex.value].text = _event.name!;
      posController[rindex.value].text = _event.pos!;
      activityController[rindex.value].text = _event.activity!;
      dateController[rindex.value].text = _event.date ?? date;
      timeController[rindex.value].text = _event.time!;
      // partnerController[rindex.value].text = _event.description!;
      showupList[rindex.value] = _event.showup!;
      daysList[rindex.value] =
          _event.days ?? [false, false, false, false, false, false, false];
    }
  }

  final bool edit = Get.arguments[0];
  final Rx<CJL2Model> _journal = CJL2Model(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) async {
    _journal.value.title = name.text;
    _journal.value.date = currentTime.text;
    _journal.value.reachout = ReachOutModel(
      reachout: reachout.value,
      acknowledged: acknowledge.value,
      toHelp: toHelp.value,
      forHelp: forHelp.value,
      kindness: randomAct.value,
      how: how.text,
    );
    _journal.value.relationships = <MREvent>[];
    for (int i = 0; i < _relation.value; i++) {
      _journal.value.relationships!.add(
        MREvent(
          activity: activityController[i].text,
          canDo: partnerController[i].text,
          name: anameController[i].text,
          date: dateController[i].text,
          time: timeController[i].text,
          pos: posController[i].text,
          showup: showupList[i],
          days: daysList[i],
        ),
      );
    }
    _journal.value.community = <CommunityEvent>[];
    for (int i = _relation.value; i < anameController.length; i++) {
      _journal.value.community!.add(
        CommunityEvent(
          activity: activityController[i].text,
          name: anameController[i].text,
          pos: posController[i].text,
          time: timeController[i].text,
          description: partnerController[i].text,
          showup: showupList[i],
          days: daysList[i],
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

  List<String> durations = ['M', 'T', 'W', 'Th', 'F', 'Sa', 'Su'];
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
        id: _journal.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    page1.currentState!.save();
    if (page1.currentState!.validate()) {
      loadingDialog(Get.context!);
      final end = DateTime.now();
      setData(end);
      if (edit) _journal.value.id = generateId();
      await connectionRef.doc(_journal.value.id).set(_journal.value.toMap());
      await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<ConnectionController>().history.value.value == 101) {
          Get.find<ConnectionController>()
              .updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      Get.back();
      customToast(message: 'Added successfully');
    }
  }

  Future updateJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    page1.currentState!.save();
    if (page1.currentState!.validate()) {
      loadingDialog(Get.context!);
      final end = DateTime.now();
      setData(end);
      await connectionRef.doc(_journal.value.id).update(_journal.value.toMap());
      if (!fromsave) Get.back();
      Get.back();
      customToast(message: 'Updated successfully');
    }
  }

  fetchData() async {
    _journal.value = Get.arguments[1] as CJL2Model;
    name.text = _journal.value.title!;
    currentTime.text = _journal.value.date!;
    final ReachOutModel _reach = _journal.value.reachout!;
    reachout.value = _reach.reachout!;
    acknowledge.value = _reach.acknowledged!;
    toHelp.value = _reach.toHelp!;
    forHelp.value = _reach.forHelp!;
    randomAct.value = _reach.kindness!;
    how.text = _reach.how!;
    clearActivity();
    fetchMRActivities(_journal.value.relationships!, _journal.value.date!);
    fetchCommunityActivities(_journal.value.community!, _journal.value.date!);
  }
}

class ConnectionJournalLvl2 extends StatefulWidget {
  const ConnectionJournalLvl2({Key? key}) : super(key: key);

  @override
  _ConnectionJournalLvl2State createState() => _ConnectionJournalLvl2State();
}

class _ConnectionJournalLvl2State extends State<ConnectionJournalLvl2> {
  final CJ2Controller _journal = Get.put(CJ2Controller());
  final RxInt first = 0.obs;
  final RxBool loaded = false.obs;

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
            button1: _journal.index.value == 1 ? 'Done' : 'Continue',
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
            key: _journal.page1,
            child: Column(
              children: [
                verticalSpace(height: 10),
                Row(
                  children: [
                    const Expanded(
                      child: TextWidget(
                        text:
                            'Connection Journal Level 2 - \nMeaningful Relationships & Community (Practice)',
                        weight: FontWeight.bold,
                        alignment: Alignment.center,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.to(
                        () => ReadingScreen(
                          title:
                              'C102- Building, Fun, Wealth, and Relationship',
                          link:
                              'https://docs.google.com/document/d/1-JSXX4KLABegk8fl-D92TYWM5vKXg-sM/',
                          linked: () => Get.back(),
                          function: () {
                            if (Get.find<ConnectionController>()
                                    .history
                                    .value
                                    .value ==
                                99) {
                              final end = DateTime.now();
                              debugPrint('disposing');
                              Get.find<ConnectionController>().updateHistory(
                                  end.difference(_journal.initial).inSeconds);
                              debugPrint('disposed');
                            }
                            Get.log('closed');
                          },
                        ),
                      ),
                      //  Get.to(() => const C102Reading()),
                      icon: assetImage(AppIcons.read),
                    ),
                  ],
                ),
                verticalSpace(height: 10),
                JournalTop(
                  controller: _journal.name,
                  label: 'Name',
                  add: () => _journal.clearJournalData(),
                  save: () async => _journal.edit
                      ? await _journal.updateJournal(true)
                      : await _journal.addJournal(true),
                  drive: () => Get.off(() => const PreviousJournal()),
                ),
                verticalSpace(height: 15),

                ///
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

  RxInt count = 0.obs;
  RxInt rcount = 0.obs;
  Widget page2() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextWidget(
              text: 'Meaningful Relationships & Community',
              weight: FontWeight.bold,
              size: 12,
            ),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _journal.load.value = !_journal.load.value;
                  if (first.value == 0) first.value = 1;
                });
              },
              icon: const Icon(
                Icons.folder_shared_outlined,
                color: Colors.black,
              ),
              label: const TextWidget(
                text: 'Load Connections',
                size: 10,
              ),
            ),
          ],
        ),
        const Divider(color: Colors.black54),

        ///
        verticalSpace(height: 10),
        // const TextWidget(
        //   text:
        //       'Scrollable list of every scheduled meaningful relationship activity with the next upcoming event first, events in the past above and events farther in the future below.',
        //   color: Colors.red,
        //   fontStyle: FontStyle.italic,
        // ),
        verticalSpace(height: 15),

        /// 1
        if (!_journal.load.value && loaded.value == false)
          Column(
            children: [
              for (var i = 0; i < _journal.anameController.length; i++)
                activityWidget(index: i),
            ],
          ),
        if (_journal.load.value)
          StreamBuilder(
            initialData: const [],
            stream: connectionRef
                .where('userid', isEqualTo: Get.find<AuthServices>().userid)
                // .where('type', isEqualTo: 3)
                .orderBy('created', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data.docs.isEmpty) {
                return CircularLoadingWidget(
                  height: height * 0.5,
                  onCompleteText: 'No meaningful relationships to show',
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  if (snapshot.data.docs[index].get('type') == 3) {
                    final MRModel mrmodel =
                        MRModel.fromMap(snapshot.data.docs[index]);
                    return InkWell(
                      onTap: () {
                        print('pressed');

                        if (rcount.value == 0) {
                          if (first.value == 1) {
                            _journal.rindex.value = 0;
                            _journal.clearActivity();
                            first.value = 2;
                          }
                          _journal.fetchMRActivities(
                            mrmodel.events!,
                            mrmodel.date!,
                          );
                          rcount.value = 1;
                        } else {
                          customSnackbar(
                            title: 'Already Loaded!',
                            message:
                                'Meaningful relationship has been already loaded from this list',
                          );
                        }
                        _journal.load.value = false;
                        loaded.value = true;
                        // _journal.rindex.value = _journal.rindex.value + 1;
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 15, bottom: 15),
                              child: TextWidget(text: mrmodel.title!),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.data.docs[index].get('type') == 4) {
                    final CommunityModel mrmodel =
                        CommunityModel.fromMap(snapshot.data.docs[index]);
                    return InkWell(
                      onTap: () {
                        print('pressed');

                        if (count.value == 0) {
                          if (first.value == 1) {
                            _journal.rindex.value = 0;
                            _journal.clearActivity();
                            first.value = 2;
                          }

                          _journal.fetchCommunityActivities(
                              mrmodel.events!, mrmodel.date!);
                          count.value = 1;
                        } else {
                          customSnackbar(
                            title: 'Already Loaded!',
                            message:
                                'Community relationship has been already loaded from this list',
                          );
                        }

                        _journal.load.value = false;
                        loaded.value = true;
                        // _journal.rindex.value = _journal.rindex.value + 1;
                        setState(() {});
                      },
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 15, bottom: 15),
                          child: TextWidget(text: mrmodel.title!),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            },
          ),

        if (loaded.value && !_journal.load.value)
          Column(
            children: [
              for (var i = 0; i < (_journal.anameController.length); i++)
                activityWidget(index: i),
            ],
          ),

        // Column(
        //   children: [
        //     for (var i = 0; i < _journal.anameController.length; i++)
        //       activityWidget(index: i),
        //   ],
        // ),
        // if (_journal.load.value)
        //   Column(
        //     children: [
        //       for (var i = 0; i < relationshipwidget.length; i++)
        //         relationshipsWidget(i),
        //     ],
        //   ),
      ],
    );
  }

  Column activityWidget({required int index}) {
    // _journal.partnerController[index].clear();
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: Get.width * 0.35,
              child: TextFormField(
                readOnly: !_journal.editable[index],
                controller: _journal.anameController[index],
                decoration: inputDecoration(hint: 'Name'),
              ),
            ),
            SizedBox(
              width: Get.width * 0.15,
              child: TextFormField(
                readOnly: !_journal.editable[index],
                controller: _journal.posController[index],
                decoration: inputDecoration(hint: 'Pos'),
              ),
            ),
            SizedBox(
              width: Get.width * 0.4,
              child: TextFormField(
                readOnly: !_journal.editable[index],
                controller: _journal.activityController[index],
                decoration: inputDecoration(hint: 'Scheduled Activity'),
              ),
            ),
          ],
        ),
        SizedBox(
          // width: Get.width * 0.45,
          child: TextFormField(
            readOnly: true,
            controller: _journal.timeController[index],
            decoration: inputDecoration(
              hint: 'Scheduled Time (HH:MM:SS)',
            ),
            onTap: _journal.editable[index]
                ? () {
                    customTimePicker(
                      context,
                      initialTime: TimeOfDay.now(),
                    ).then((value) {
                      setState(() {
                        _journal.time[index] = value.format(context);
                        var minute = value.minute < 10
                            ? '0${value.minute}'
                            : value.minute.toString();
                        _journal.timeController[index].text =
                            value.hourOfPeriod < 10
                                ? '0${value.hourOfPeriod}'
                                : '${value.hourOfPeriod}:$minute:00';
                      });
                    });
                  }
                : () {},
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomCheckBox(
              value: _journal.showupList[index],
              onChanged: (value) {
                setState(() {
                  _journal.showupList[index] = value;
                });
              },
              title: 'Did I show up?',
              width: Get.width * 0.4,
            ),
            // TextButton(
            //   onPressed: () {
            //     // setState(() {
            //     //   _journal.editable[index] = !_journal.editable[index];
            //     // });
            //     // Get.toNamed(
            //     //   '/AddEvent',
            //     //   arguments: true,
            //     //   parameters: {'docid': _journal.eventidList[index]},
            //     // );
            //   },
            //   child: const TextWidget(text: 'Edit Scheduled Event..'),
            // ),
          ],
        ),
        CheckBoxRows(
          titles: _journal.durations,
          values: _journal.daysList[index],
          titleAlignment: Alignment.centerLeft,
          size: 60,
          editable: false,
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey, width: 2.0),
          ),
          child: SingleChildScrollView(
            child: TextFormField(
              // readOnly: !_journal.editable[index],
              controller: _journal.partnerController[index],
              decoration: inputDecoration(
                border: InputBorder.none,
                focusBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                hint:
                    'Notes: What did we last speak about? What can we accomplish together? What can I do to be a better partner in this relationship?',
              ),
            ),
          ),
        ),
        verticalSpace(height: 40),
      ],
    );
  }

  Widget page1() {
    return Column(
      children: [
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
        verticalSpace(height: 20),

        ///
        Column(
          children: [
            verticalSpace(height: 10),
            CustomCheckBox(
              value: _journal.reachout.value,
              onChanged: (value) {
                setState(() {
                  _journal.reachout.value = value;
                });
              },
              title: 'Did you reach out to someone?',
              width: Get.width,
            ),

            ///
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  CustomCheckBox(
                    value: _journal.acknowledge.value,
                    onChanged: (value) {
                      setState(() {
                        _journal.acknowledge.value = value;
                      });
                    },
                    title: 'Acknowledged somone?',
                    width: Get.width * 0.5,
                  ),
                  CustomCheckBox(
                    value: _journal.forHelp.value,
                    onChanged: (value) {
                      setState(() {
                        _journal.forHelp.value = value;
                      });
                    },
                    title: 'Asked for help?',
                    width: Get.width * 0.4,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  CustomCheckBox(
                    value: _journal.randomAct.value,
                    onChanged: (value) {
                      setState(() {
                        _journal.randomAct.value = value;
                      });
                    },
                    title: 'Random act of kindness?',
                    width: Get.width * 0.5,
                  ),
                  CustomCheckBox(
                    value: _journal.toHelp.value,
                    onChanged: (value) {
                      setState(() {
                        _journal.toHelp.value = value;
                      });
                    },
                    title: 'Asked to help?',
                    width: Get.width * 0.4,
                  ),
                ],
              ),
            ),
          ],
        ),

        ///
        TextFormField(
          maxLines: 7,
          controller: _journal.how,
          decoration: inputDecoration(
            hint: 'How did you reach out to someone?',
          ),
        ),

        /// bottom
        verticalSpace(height: Get.height * 0.15),
      ],
    );
  }
}

class PreviousJournal extends StatelessWidget {
  const PreviousJournal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title:
            'Connection Journal Level 2 - \nMeaningful Relationships & Community',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: connectionRef
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
              final CJL2Model model =
                  CJL2Model.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const ConnectionJournalLvl2(),
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
