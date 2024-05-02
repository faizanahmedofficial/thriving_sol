// ignore_for_file: avoid_print, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/connection_models.dart';
import 'package:schedular_project/Screens/Emotional/connection_home.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/checkboxes.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../../Constants/constants.dart';
import '../../../Model/app_user.dart';
import '../../../Widgets/custom_images.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../app_icons.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';

class ConnectionJournalLvl0 extends StatefulWidget {
  const ConnectionJournalLvl0({Key? key}) : super(key: key);

  @override
  _ConnectionJournalLvl0State createState() => _ConnectionJournalLvl0State();
}

class _ConnectionJournalLvl0State extends State<ConnectionJournalLvl0> {
  final _key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController how = TextEditingController();
  bool reachout = false;
  bool acknowledge = false;
  bool forHelp = false;
  bool toHelp = false;
  bool randomAct = false;
  TextEditingController currentTime = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      name.text = 'Connection Journal Level 0- Simply Reach Out${formatTitelDate(DateTime.now()).trim()}';
      currentTime.text = formateDate(DateTime.now());
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
          button2: 'Save',
          onPressed1: () async =>
              edit ? await updateJournal() : await addJournal(),
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
                      text:
                          'Connection Journal Level 0 - \nSimply Reach Out (Practice)',
                      weight: FontWeight.bold,
                      alignment: Alignment.center,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.to(
                      () => ReadingScreen(
                        title:
                            'Connection Intro- Double Your Risk of Early Death by Not Reading This',
                        link:
                            'https://docs.google.com/document/d/1scvS_eFJzCwbWoKUkSKGlFtYodhVLn0A/',
                        linked: () => Get.back(),
                        function: () {
                          if (Get.find<ConnectionController>()
                                  .history
                                  .value
                                  .value ==
                              94) {
                                 final end = DateTime.now();
                            debugPrint('disposing');
                            Get.find<ConnectionController>().updateHistory(end.difference(initial).inSeconds);
                            debugPrint('disposed');
                          }
                          Get.log('closed');
                        },
                      ),
                    ),
                    //  Get.to(
                    //   () => const ConnectionIntro(),
                    // ),
                    icon: assetImage(AppIcons.read),
                  ),
                ],
              ),
              verticalSpace(height: 10),
              JournalTop(
                controller: name,
                label: 'Name',
                add: () => clearData(),
                save: () async =>
                    edit ? await updateJournal(true) : await addJournal(true),
                drive: () => Get.off(() => const PreviousJournal()),
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
                text: 'Reach out to someone by:',
                weight: FontWeight.bold,
              ),

              ///
              Column(
                children: [
                  verticalSpace(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.how_to_reg_outlined,
                        size: 50,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: Get.width * 0.8,
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontFamily: 'Arial',
                            ),
                            children: [
                              TextSpan(
                                text: 'Acknowledging them.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text:
                                    ' Show them you care about their life, see them, and hear them simply by acknowledging them.',
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                  ///
                  verticalSpace(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.how_to_reg_outlined,
                        size: 50,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: Get.width * 0.8,
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontFamily: 'Arial',
                            ),
                            children: [
                              TextSpan(
                                text: 'Asking for help.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text:
                                    ' Most people like to give advice and get satisfaction from helping others.',
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                  ///
                  verticalSpace(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.how_to_reg_outlined,
                        size: 50,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: Get.width * 0.8,
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontFamily: 'Arial',
                            ),
                            children: [
                              TextSpan(
                                text: 'Asking to help.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text:
                                    ' Helping others is proven to provide happiness to the person doing the helping.',
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                  ///
                  verticalSpace(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.how_to_reg_outlined,
                        size: 50,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: Get.width * 0.8,
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontFamily: 'Arial',
                            ),
                            children: [
                              TextSpan(
                                text: 'Do a random act of kindness.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text:
                                    ' It that can be as simple as smiling at someone or giving words of encouragement.',
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),

              ///
              Column(
                children: [
                  verticalSpace(height: 10),
                  CustomCheckBox(
                    value: reachout,
                    width: Get.width,
                    title: 'Did you reach out to someone?',
                    onChanged: (value) {
                      setState(() {
                        reachout = value;
                      });
                    },
                  ),

                  ///
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        CustomCheckBox(
                          value: acknowledge,
                          onChanged: (value) {
                            setState(() {
                              acknowledge = value;
                            });
                          },
                          title: 'Acknowledged somone?',
                          width: Get.width * 0.5,
                        ),
                        CustomCheckBox(
                          value: forHelp,
                          onChanged: (value) {
                            setState(() {
                              forHelp = value;
                            });
                          },
                          title: 'Asked for Help?',
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
                          value: randomAct,
                          onChanged: (value) {
                            setState(() {
                              randomAct = value;
                            });
                          },
                          title: 'Random act of kindness?',
                          width: Get.width * 0.5,
                        ),
                        CustomCheckBox(
                          value: toHelp,
                          onChanged: (value) {
                            setState(() {
                              toHelp = value;
                            });
                          },
                          title: 'Asked to Help?',
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
                controller: how,
                decoration: inputDecoration(
                  hint: 'How did you reach out to someone?',
                ),
              ),

              /// bottom
            ],
          ),
        ),
      ),
    );
  }

  void clearData() {
    setState(() {
      reachout = false;
      acknowledge = false;
      forHelp = false;
      toHelp = false;
      randomAct = false;
    });
    name.clear();
    how.clear();
  }

  final bool edit = Get.arguments[0];
  final Rx<CJL0Model> _journal = CJL0Model(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _journal.value.title = name.text;
    _journal.value.date = currentTime.text;
    _journal.value.reachout = ReachOutModel(
      reachout: reachout,
      forHelp: forHelp,
      acknowledged: acknowledge,
      kindness: randomAct,
      how: how.text,
      toHelp: toHelp,
    );
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
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      loadingDialog(context);
       final end = DateTime.now();
      setData(end);
      if (edit) _journal.value.id = generateId();
      await connectionRef.doc(_journal.value.id).set(_journal.value.toMap());
      await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<ConnectionController>().history.value.value == 95) {
          Get.find<ConnectionController>().updateHistory(end.difference(initial).inSeconds);
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
      await connectionRef.doc(_journal.value.id).update(_journal.value.toMap());
      if (!fromsave) Get.back();
      Get.back();
      customToast(message: 'Updated successfully');
    }
  }

  fetchData() {
    _journal.value = Get.arguments[1] as CJL0Model;
    name.text = _journal.value.title!;
    currentTime.text = _journal.value.date!;
    final ReachOutModel _reach = _journal.value.reachout!;
    reachout = _reach.reachout!;
    acknowledge = _reach.acknowledged!;
    forHelp = _reach.forHelp!;
    randomAct = _reach.kindness!;
    how.text = _reach.how!;
    toHelp = _reach.toHelp!;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class PreviousJournal extends StatelessWidget {
  const PreviousJournal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Connection Journal Level 0 - \nSimply Reach Out',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: connectionRef
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
              final CJL0Model model =
                  CJL0Model.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const ConnectionJournalLvl0(),
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
