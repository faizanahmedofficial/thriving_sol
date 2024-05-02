// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Functions/time_picker.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/er_models.dart';
import 'package:schedular_project/Screens/Emotional/er_home.dart';
import 'package:schedular_project/Screens/custom_bottom.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_button.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/progress_indicator.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../../Constants/constants.dart';
import '../../../Functions/date_picker.dart';
import '../../../Model/app_user.dart';
import '../../../Widgets/custom_images.dart';
import '../../../app_icons.dart';
import '../../readings.dart';

class BAPrevious extends StatelessWidget {
  const BAPrevious({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: '', implyLeading: true, actions: []),
      body: StreamBuilder(
        initialData: const [],
        stream: erRef
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
              final BAModel _data = BAModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.only(top: 10, left: 10, right: 10),
                  onTap: () => Get.to(
                    () => const BAScreen(),
                    arguments: [true, _data],
                  ),
                  title: TextWidget(
                    text: _data.title!,
                    weight: FontWeight.bold,
                  ),
                  subtitle: Column(
                    children: List.generate(
                      _data.events!.length,
                      (indx) {
                        final BAEvents _event = _data.events![indx];
                        return Row(
                          children: [
                            SizedBox(
                              width: width * 0.35,
                              child: TextFormField(
                                initialValue: _event.description,
                                readOnly: true,
                                decoration:
                                    decoration(hint: 'Event Desctiption'),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.2,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: _event.start,
                                decoration: decoration(hint: 'HH:MM'),
                              ),
                            ),
                            const TextWidget(text: '-'),
                            SizedBox(
                              width: width * 0.2,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: _event.end,
                                decoration: decoration(hint: 'HH:MM'),
                              ),
                            ),
                            Checkbox(
                              value: _event.completed,
                              onChanged: (val) {},
                            ),
                          ],
                        ).marginOnly(bottom: 5);
                      },
                    ),
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

class BAController extends GetxController {
  final TextEditingController currentTime = TextEditingController(
    text: formateDate(DateTime.now()),
  );
  final TextEditingController title = TextEditingController(
    text: 'BabyReframing${formatTitelDate(DateTime.now())}',
  );

  RxList<BAEvents> events = <BAEvents>[BAEvents(completed: false)].obs;
  final Rx<BAModel> bamodel = BAModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  bool edit = Get.arguments[0];

  fetchData() {
    bamodel.value = Get.arguments[1] as BAModel;
    events.assignAll(bamodel.value.events!);
  }

  @override
  void onInit() {
    if (edit) fetchData();
    super.onInit();
  }

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    bamodel.value.title = title.text;
    bamodel.value.date = currentTime.text;
    bamodel.value.events = <BAEvents>[];
    for (int i = 0; i < events.length; i++) {
      bamodel.value.events!.add(events[i]);
    }
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      bamodel.value.duration = bamodel.value.duration! + diff;
    } else {
      bamodel.value.duration = diff;
    }
  }

  Future addBA([bool fromsave = false]) async {
    loadingDialog(Get.context!);
    final end = DateTime.now();
    setData(end);
    if (edit) bamodel.value.id = generateId();
    await erRef.doc(bamodel.value.id).set(bamodel.value.toMap());
    await addAccomplishment(end);
    if (!fromsave) {
      if (Get.find<ErController>().history.value.value == 69) {
        Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
      }
    }
    if (!fromsave) Get.back();
    Get.back();
    customToast(message: 'Behavioral Activation created successfully');
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
        id: bamodel.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future updateBA() async {
    loadingDialog(Get.context!);
    final end = DateTime.now();
    setData(end);
    await erRef.doc(bamodel.value.id).update(bamodel.value.toMap());
    Get.back();
    Get.back();
    customToast(message: 'Behavioral Activation updated successfully');
  }

  clearData() async {
    events.clear();
    events = <BAEvents>[BAEvents(completed: false)].obs;
  }

  Future addtoCalendar() async {
    for (int i = 0; i < events.length; i++) {
      var doc = events[i];
      Future.delayed(Duration(seconds: i == 0 ? 0 : i + 10), () async {
        print(doc);
        await Add2Calendar.addEvent2Cal(Event(
          title: doc.description!,
          startDate: setDateTime(currentTime.text, doc.start!),
          endDate: setDateTime(currentTime.text, doc.end!),
        )).then((value) {});
      });
    }
  }

  setDateTime(String currentdate, String time) {
    final _date = DateFormat('MM/dd/yy').parse(currentdate);
    final _time = getTimeFromString(time);
    return DateTime(
        _date.year, _date.month, _date.day, _time.hour, _time.minute);
  }
}

class BAScreen extends StatefulWidget {
  const BAScreen({Key? key}) : super(key: key);

  @override
  State<BAScreen> createState() => _BAScreenState();
}

class _BAScreenState extends State<BAScreen> {
  final BAController controller = Get.put(BAController());
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Future _add([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      await controller.addBA(fromsave);
    }
  }

  Future _update() async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      await controller.updateBA();
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
            button2: 'Add to Calendar',
            onPressed1: () async => controller.edit ? _update() : _add(),
            onPressed2: () async => await controller.addtoCalendar(),
            b1: width * 0.25,
            b2: width * 0.39,
          ),
        ),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: title2('Behavioral Activation (Practice)')
                          .marginOnly(bottom: 10),
                    ),
                    IconButton(
                      onPressed: () => Get.to(
                        () => ReadingScreen(
                          title: 'ER100- A Brief Introduction to CBT',
                          link:
                              'https://docs.google.com/document/d/1HoVvGqqLHWLH-ATn-DoS4MXO_2ZlY9jD/',
                          linked: () => Get.back(),
                          function: () {
                            if (Get.find<ErController>().history.value.value ==
                                68) {
                                   final end = DateTime.now();
                              debugPrint('disposing');
                              Get.find<ErController>().updateHistory(end.difference(controller.initial).inSeconds);
                              debugPrint('disposed');
                            }
                            Get.log('closed');
                          },
                        ),
                      ),
                      // () => Get.to(() => const ER100Reading()),
                      icon: assetImage(AppIcons.read),
                    ),
                  ],
                ),
                JournalTop(
                  controller: controller.title,
                  add: () => controller.clearData(),
                  save: () async => _add(true),
                  drive: () => Get.off(() => const BAPrevious()),
                ).marginOnly(bottom: 15),
                subtitle(
                  'Schedule at least one fun activity, enjoyable activity, or an activity that gives you a sense of mastery for tomorrow.',
                ).marginOnly(bottom: 5),
                DateWidget(
                  alignment: Alignment.centerLeft,
                  date: controller.currentTime.text,
                  ontap: () async {
                    await customDatePicker(
                      Get.context!,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    ).then((value) {
                      controller.currentTime.text = formateDate(value);
                      setState(() {});
                    });
                  },
                ).marginOnly(bottom: 10),
                const TextWidget(
                  text: 'Completed?',
                  size: 16,
                  alignment: Alignment.centerRight,
                ),
                Column(
                  children: List.generate(
                    controller.events.length,
                    (index) {
                      final BAEvents _event = controller.events[index];
                      return Row(
                        children: [
                          SizedBox(
                            width: width * 0.35,
                            child: TextFormField(
                              initialValue: _event.description,
                              onChanged: (val) => setState(() {
                                _event.description = val;
                              }),
                              decoration: decoration(hint: 'Event Desctiption'),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.2,
                            child: InkWell(
                              child: TextWidget(text: _event.start ?? 'HH:MM'),
                              onTap: () async {
                                await customTimePicker(context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  setState(() {
                                    _event.start = value.format(context);
                                  });
                                });
                              },
                            ),
                          ),
                          const TextWidget(text: '-'),
                          SizedBox(
                            width: width * 0.2,
                            child: InkWell(
                              child: TextWidget(text: _event.end ?? 'HH:MM'),
                              onTap: () async {
                                await customTimePicker(context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  _event.end = value.format(context);
                                  setState(() {});
                                });
                              },
                            ),
                          ),
                          Checkbox(
                            value: _event.completed,
                            onChanged: (val) {
                              _event.completed = val;
                              setState(() {});
                            },
                          ),
                        ],
                      ).marginOnly(bottom: 5);
                    },
                  ),
                ),
                CustomTextButton(
                  text: 'Add Event...',
                  ontap: () {
                    controller.events.add(BAEvents(completed: false));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
