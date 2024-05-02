// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/sexual_model.dart';
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
import '../../../Widgets/progress_indicator.dart';
import '../sexual_home.dart';

class PCJournalLvl0 extends StatefulWidget {
  const PCJournalLvl0({Key? key}) : super(key: key);

  @override
  _PCJournalLvl0State createState() => _PCJournalLvl0State();
}

class _PCJournalLvl0State extends State<PCJournalLvl0> {
  final _key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  bool findPc = false;
  TextEditingController currentTime = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      name.text = 'PCJournalLevel0FindingYourPC${formatTitelDate(DateTime.now()).trim()}';
      currentTime.text = formateDate(DateTime.now());
      if (edit) fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: _key,
          child: Column(
            children: [
              verticalSpace(height: 10),
              const TextWidget(
                text: 'PC Journal Level 0 - Finding your PC (Practice)',
                weight: FontWeight.bold,
                alignment: Alignment.center,
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
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10),
                child: TextWidget(
                  text:
                      'Imagine you are stopping yourself from peeing midstream or actually try to when you urinating. That is your PC muscle. Try to squeeze this muscle lightly.',
                  weight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  alignment: Alignment.center,
                  textAlign: TextAlign.center,
                ),
              ),
              verticalSpace(height: 20),
              TextFormField(
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
              verticalSpace(height: 20),
              CustomCheckBox(
                value: findPc,
                onChanged: (pc) {
                  setState(() {
                    findPc = pc;
                  });
                },
                title: 'Did you find your PC muscle?',
                width: Get.width,
              ),
              verticalSpace(height: Get.height * 0.4),
              BottomButtons(
                button1: 'Done',
                button2: 'Save',
                onPressed2: () async => await addJournal(true),
                onPressed1: () async =>
                    edit ? await updateJournal() : await addJournal(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void clearData() {
    setState(() {
      findPc = false;
    });
    name.clear();
  }

  final bool edit = Get.arguments[0];
  final Rx<PCJ0Model> _journal = PCJ0Model(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();

  setData(DateTime end) {
    _journal.value.name = name.text;
    _journal.value.date = currentTime.text;
    _journal.value.find = findPc;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _journal.value.duration = _journal.value.duration! + diff;
    } else {
      _journal.value.duration = diff;
    }
  }

  fetchData() {
    _journal.value = Get.arguments[1] as PCJ0Model;
    name.text = _journal.value.name!;
    currentTime.text = _journal.value.date!;
    findPc = _journal.value.find!;
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == sexual);
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
      await sexualRef.doc(_journal.value.id).set(_journal.value.toMap());
      await addAccomplishment(end);
      Get.back();
      if (!fromsave) {
        if (Get.find<SexualController>().history.value.value == 140) {
          Get.find<SexualController>().updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      customToast(message: 'Added Successfully');
    }
  }

  Future updateJournal([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      loadingDialog(context);
       final end = DateTime.now();
      setData(end);
      await sexualRef.doc(_journal.value.id).update(_journal.value.toMap());
      Get.back();
      if (!fromsave) Get.back();
      customToast(message: 'Updated Successfully');
    }
  }
}

class PreviousJournal extends StatelessWidget {
  const PreviousJournal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'PC Journal Level 0 - Finding your PC',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: sexualRef
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
              final PCJ0Model model =
                  PCJ0Model.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const PCJournalLvl0(),
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
