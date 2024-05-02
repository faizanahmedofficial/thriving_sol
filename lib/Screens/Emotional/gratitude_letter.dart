// ignore_for_file: avoid_print, deprecated_member_use, no_leading_underscores_for_local_identifiers, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Model/gratitude_model.dart';
import 'package:schedular_project/Functions/printing.dart';
import 'package:schedular_project/Screens/Emotional/gratitude_home.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/custom_snackbar.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:printing/printing.dart';

import '../../Constants/constants.dart';
import '../../Model/app_user.dart';
import '../../Widgets/checkboxes.dart';
import '../../Widgets/custom_images.dart';
import '../../Widgets/progress_indicator.dart';
import 'dart:developer';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:schedular_project/Global/firebase_collections.dart';

import '../../app_icons.dart';
import '../custom_bottom.dart';
import '../readings.dart';

class GratitudeLetterController extends GetxController {
  TextEditingController currentTime = TextEditingController();

  /// form keys
  final gratitudeLetterKey = GlobalKey<FormState>();

  /// textfield controllers
  /// Letter
  TextEditingController gletterName = TextEditingController();
  TextEditingController to = TextEditingController();
  TextEditingController thankfulFor = TextEditingController();
  TextEditingController gift = TextEditingController();
  TextEditingController deliveryMethod = TextEditingController();
  TextEditingController letterbody = TextEditingController();
  RxString audioLink = ''.obs;
  RxString pdfLink = ''.obs;
  RxBool scheduled = false.obs;
  RxBool deliver = false.obs;

  clearLetterData() {
    /// letter
    to.clear();
    gletterName.clear();
    letterbody.clear();
    deliveryMethod.clear();
    gift.clear();
    thankfulFor.clear();

    ///
    audioLink.value = '';
    pdfLink.value = '';
    scheduled.value = false;
  }

  ///
  addToCalendar({required DateTime now}) {
    DateTime _next = DateTime.now().add(const Duration(days: 365));
    DateTime _start = DateTime(now.year, now.month, now.day);
    DateTime _end = DateTime(_next.year, _next.month, _next.day);
    final Event _event = Event(
      title: gletterName.text,
      description:
          '${to.text}\n I just wanted to say that: ${letterbody.text}.',
      startDate: _start,
      endDate: _end,
      iosParams: const IOSParams(reminder: Duration(minutes: 30)),
    );
    Add2Calendar.addEvent2Cal(_event)
        .then((value) {})
        .whenComplete(() => log('added successfully!'));
  }

  @override
  void onInit() {
    gletterName.text =
        'GratitudeLetter${formatTitelDate(DateTime.now()).trim()}';
    currentTime.text = formateDate(DateTime.now());
    if (edit) fetchData();
    super.onInit();
  }

  RxInt index = 0.obs;
  updateIndex() => index.value = index.value + 1;
  previousIndex() => index.value = index.value - 1;

  final bool edit = Get.arguments[0];
  final Rx<LetterModel> _letter = LetterModel(
    id: generateId(),
    userid: Get.find<AuthServices>().userid,
  ).obs;

  DateTime initial = DateTime.now();
  setData(DateTime end) {
    _letter.value.title = gletterName.text;
    _letter.value.who = to.text;
    _letter.value.thankful = thankfulFor.text;
    _letter.value.gift = gift.text;
    _letter.value.delivery = deliveryMethod.text;
    _letter.value.letter = letterbody.text;
    _letter.value.delivered = deliver.value;
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _letter.value.duration = _letter.value.duration! + diff;
    } else {
      _letter.value.duration = diff;
    }
  }

  fetchData() {
    _letter.value = Get.arguments[1] as LetterModel;
    gletterName.text = _letter.value.title!;
    to.text = _letter.value.who!;
    thankfulFor.text = _letter.value.thankful!;
    gift.text = _letter.value.gift!;
    deliveryMethod.text = _letter.value.delivery!;
    letterbody.text = _letter.value.letter!;
    deliver.value = _letter.value.delivered!;
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == gratitude);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: gletterName.text,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _letter.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addLetter([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    gratitudeLetterKey.currentState!.save();
    if (gratitudeLetterKey.currentState!.validate()) {
      loadingDialog(Get.context!);
       final end = DateTime.now();
      setData(end);
      if (edit) _letter.value.id = generateId();
      await gratitudeRef.doc(_letter.value.id).set(_letter.value.toMap());
      await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<GratitudeController>().history.value.value == 65) {
          Get.find<GratitudeController>().updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      Get.back();
      customToast(message: 'Added successfully');
    }
  }

  Future updateLetter([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    gratitudeLetterKey.currentState!.save();
    if (gratitudeLetterKey.currentState!.validate()) {
      loadingDialog(Get.context!);
       final end = DateTime.now();
      setData(end);
      await gratitudeRef.doc(_letter.value.id).update(_letter.value.toMap());
      if (!fromsave) Get.back();
      Get.back();
      customToast(message: 'Updated successfully');
    }
  }
}

// ignore: must_be_immutable
class GratitudeLetter extends StatefulWidget {
  const GratitudeLetter({Key? key}) : super(key: key);

  @override
  _GratitudeLetterState createState() => _GratitudeLetterState();
}

class _GratitudeLetterState extends State<GratitudeLetter> {
  final GratitudeLetterController _gratitudeController =
      Get.put(GratitudeLetterController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: customAppbar(
          leading: backButton(
            () => _gratitudeController.index.value == 0
                ? Get.back()
                : _gratitudeController.previousIndex(),
          ),
          implyLeading: true,
        ),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomButtons(
            button1:
                _gratitudeController.index.value == 0 ? 'Continue' : 'Done',
            onPressed1: _gratitudeController.index.value == 0
                ? () => _gratitudeController.updateIndex()
                : () async => _gratitudeController.edit
                    ? await _gratitudeController.updateLetter()
                    : await _gratitudeController.addLetter(),
            button2: 'Save',
            onPressed2: () async => await _gratitudeController.addLetter(true),
            onPressed3: () => _gratitudeController.index.value != 0
                ? _gratitudeController.previousIndex()
                : Get.back(),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: _gratitudeController.gratitudeLetterKey,
            child: Column(
              children: [
                verticalSpace(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TextWidget(
                      text: 'Gratitude Letter (Practice)',
                      weight: FontWeight.bold,
                      alignment: Alignment.center,
                    ),
                    IconButton(
                      onPressed: () => Get.to(
                        () => ReadingScreen(
                          title: 'G102- Gratitude Letter',
                          link:
                              'https://docs.google.com/document/d/1yI_qm45vOOLx4MW8mGd877Qd2tsLFRBJ/',
                          linked: () => Get.back(),
                          function: () {
                            if (Get.find<GratitudeController>()
                                    .history
                                    .value
                                    .value ==
                                64) {
                                   final end = DateTime.now();
                              debugPrint('disposing');
                              Get.find<GratitudeController>().updateHistory(end.difference(_gratitudeController.initial).inSeconds);
                              debugPrint('disposed');
                            }
                            Get.log('closed');
                          },
                        ),
                      ),
                      // Get.to(
                      //   () => const GratitudeLetterReading(),
                      // ),
                      icon: assetImage(AppIcons.read),
                    ),
                  ],
                ),
                verticalSpace(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: Get.width * 0.5,
                      child: TextFormField(
                        controller: _gratitudeController.gletterName,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(fontFamily: 'Arial'),
                        decoration: inputDecoration(hint: 'Name'),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () =>
                              _gratitudeController.clearLetterData(),
                          tooltip: 'Add New Letter',
                          icon: const Icon(Icons.add, color: AppColors.black),
                        ),
                        IconButton(
                          onPressed: () async => _gratitudeController.edit
                              ? await _gratitudeController.updateLetter(true)
                              : await _gratitudeController.addLetter(true),
                          tooltip: 'Save',
                          icon: const Icon(Icons.save_outlined,
                              color: AppColors.black),
                        ),
                        IconButton(
                          onPressed: () =>
                              Get.off(() => const PreviousLetter()),
                          tooltip: 'Load Letter',
                          icon: const Icon(
                            Icons.drive_folder_upload_outlined,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                verticalSpace(height: 15),
                _gratitudeController.index.value == 0
                    ? page1()
                    : _gratitudeController.index.value == 1
                        ? page2()
                        : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget page2() {
    return Column(
      children: [
        const TextWidget(text: 'Delivery', weight: FontWeight.bold),
        Align(
          alignment: Alignment.topLeft,
          child: TextButton.icon(
            onPressed: () async {
              Get.log('--- printing---');
              await Printing.layoutPdf(
                onLayout: (format) => AppPrintings().generatePdf(format),
                name: 'Letter',
                format: PdfPageFormat.a4,
              );
            },
            icon: const Icon(Icons.print_outlined, color: AppColors.black),
            label: const TextWidget(text: 'Print'),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: TextButton.icon(
            onPressed: () {
              Get.log('--- Call ---');
              launch('tel:');
            },
            icon: const Icon(Icons.call_outlined, color: AppColors.black),
            label: const TextWidget(text: 'Call'),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: TextButton.icon(
            onPressed: () {
              Get.log('---Message---');
              launch('sms:?body=${_gratitudeController.letterbody.text}');
            },
            icon: const Icon(Icons.message_outlined, color: AppColors.black),
            label: const TextWidget(text: 'Text'),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: TextButton.icon(
            onPressed: () {
              _gratitudeController.addToCalendar(now: DateTime.now());
              // Get.log('--- schedule---');
              // Get.toNamed('/AddEvent', parameters: {
              //   'letter': 'true',
              //   'title': _gratitudeController.gletterName.text,
              // });
            },
            icon: const Icon(
              Icons.calendar_today_outlined,
              color: AppColors.black,
            ),
            label: const TextWidget(text: 'Schedule It'),
          ),
        ),
        verticalSpace(height: Get.width * 0.15),
        Obx(
          () => CustomCheckBox(
            width: width,
            value: _gratitudeController.deliver.value,
            onChanged: (val) {
              _gratitudeController.deliver.value = val;
            },
            title: 'Did you deliver the Gratitude Letter?',
          ),
        ),
      ],
    );
  }

  String setScriptString() {
    return 'To the ${_gratitudeController.to.text} for ${_gratitudeController.thankfulFor.text} ${_gratitudeController.letterbody.text}';
  }

  Widget page1() {
    return Column(
      children: [
        ///
        const TextWidget(
          text:
              'Who will this letter of gratitude be addressed to? (It can be a person, place, thing, or idea)',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _gratitudeController.to,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          decoration: inputDecoration(hint: 'Who or what'),
          validator: (val) {
            if (val!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
        verticalSpace(height: 5),

        ///
        const TextWidget(
          text:
              'Why are you thankful to this person (or idea, place, or thing)?',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _gratitudeController.thankfulFor,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          decoration: inputDecoration(hint: 'What are you thankful for?'),
          validator: (val) {
            if (val!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
        verticalSpace(height: 5),

        ///
        const TextWidget(
          text: 'What gift will you include with this letter?',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _gratitudeController.gift,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          decoration: inputDecoration(hint: 'Gift'),
        ),
        verticalSpace(height: 5),

        ///
        const TextWidget(
          text:
              'How will you deliver the letter to its recipient (by hand, call, text, email, mail, social media, etc.)',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          controller: _gratitudeController.deliveryMethod,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          decoration: inputDecoration(hint: 'Delivery Method'),
        ),

        ///
        verticalSpace(height: 5),
        const TextWidget(
          text: 'Write your letter of gratitude in the space provided below:',
          fontStyle: FontStyle.italic,
        ),
        TextFormField(
          maxLines: 10,
          controller: _gratitudeController.letterbody,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          decoration: inputDecoration(hint: 'Gratitude Letter'),
          validator: (val) {
            if (val!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
        verticalSpace(height: 5),

        ///
        Row(
          children: [
            IconButton(
              /// TODO: ios configurations for printing
              onPressed: () async {
                if (_gratitudeController.letterbody.text.isNotEmpty) {
                  Get.log('--- Printing ---');
                  await Printing.layoutPdf(
                    onLayout: (format) => AppPrintings().generatePdf(format),
                    name: 'Letter',
                    format: PdfPageFormat.a4,
                  );
                } else {
                  customSnackbar(
                    title: 'Cannot Generate Pdf!',
                    message: 'Please fill all the required information',
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                }
                _gratitudeController.gratitudeLetterKey.currentState!.save();
              },
              tooltip: 'Print',
              icon: const Icon(Icons.print_outlined, color: AppColors.black),
            ),
            IconButton(
              onPressed: () {
                launch('tel:');
                _gratitudeController.gratitudeLetterKey.currentState!.save();
              },
              tooltip: 'Call',
              icon: const Icon(Icons.call_outlined, color: AppColors.black),
            ),
            IconButton(
              onPressed: () {
                if (_gratitudeController.letterbody.text.isEmpty) {
                  customToast(
                      message:
                          'Gratitude Letter body is required to send message');
                } else {
                  launch('sms:?body=${_gratitudeController.letterbody.text}');
                  _gratitudeController.gratitudeLetterKey.currentState!.save();
                }
                _gratitudeController.gratitudeLetterKey.currentState!.save();
              },
              tooltip: 'Message',
              icon: const Icon(Icons.message_outlined, color: AppColors.black),
            ),
          ],
        ),
      ],
    );
  }
}

class PreviousLetter extends StatelessWidget {
  const PreviousLetter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Gratitude Letter',
        implyLeading: true,
        actions: [],
      ),
      body: StreamBuilder(
        initialData: const [],
        stream: gratitudeRef
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
              final LetterModel model =
                  LetterModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const GratitudeLetter(),
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
