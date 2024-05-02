// ignore_for_file: avoid_print, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/bottom_buttons.dart';
import 'package:schedular_project/Common/journal_top.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Functions/date_picker.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Model/er_models.dart';
import 'package:schedular_project/Screens/Emotional/er_home.dart';
import 'package:schedular_project/Services/app_services.dart';
import 'package:schedular_project/Services/auth_services.dart';
import 'package:schedular_project/Theme/buttons_theme.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/checkboxes.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../../Model/app_user.dart';
import '../../../Widgets/custom_images.dart';
import '../../../Widgets/progress_indicator.dart';
import '../../../app_icons.dart';
import '../../custom_bottom.dart';
import '../../readings.dart';

class FactChecking extends StatefulWidget {
  const FactChecking({Key? key}) : super(key: key);

  @override
  _FactCheckingState createState() => _FactCheckingState();
}

class _FactCheckingState extends State<FactChecking> {
  final _key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  bool idiot = false;
  bool ugly = false;
  bool fired = false;
  bool hate = false;
  bool friends = false;
  bool horrible = false;
  bool bad = false;
  bool weak = false;
  bool overweight = false;
  bool love = false;
  bool forever = false;
  bool single = false;
  bool alwaySingle = false;
  bool nojob = false;
  bool loser = false;
  bool debt = false;
  bool sports = false;
  bool school = false;
  bool obese = false;
  bool failure = false;
  bool done = false;
  bool cant = false;
  bool trained = false;
  bool greedy = false;
  bool lazy = false;
  bool yelled = false;
  bool hit = false;
  bool forehead = false;
  bool successful = false;
  TextEditingController currentTime = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      name.text =
          'FactCheckingYourThoughts${formatTitelDate(DateTime.now()).trim()}';
      currentTime.text = formateDate(DateTime.now());
      if (edit) fetchData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  double calculateScore() {
    int total = 29;
    int current = 0;
    if (Get.find<AppServices>().answerkey.alwaysingle == alwaySingle) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.badperson == bad) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.cantDo == cant) current = current + 1;
    if (Get.find<AppServices>().answerkey.inDebt == debt) current = current + 1;
    if (Get.find<AppServices>().answerkey.failure == failure) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.fired == fired) current = current + 1;
    if (Get.find<AppServices>().answerkey.forehead == forehead) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.greedy == greedy) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.hatesMe == hate) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.hitMe == hit) current = current + 1;
    if (Get.find<AppServices>().answerkey.horrible == horrible) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.idiot == idiot) current = current + 1;
    if (Get.find<AppServices>().answerkey.lazy == lazy) current = current + 1;
    if (Get.find<AppServices>().answerkey.loser == loser) current = current + 1;
    if (Get.find<AppServices>().answerkey.neverDonethat == done) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.noFriends == friends) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.noJob == nojob) current = current + 1;
    if (Get.find<AppServices>().answerkey.noEverLove == love) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.obese == obese) current = current + 1;
    if (Get.find<AppServices>().answerkey.overweight == overweight) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.single == single) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.noSports == sports) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.sportsHighSchool == school) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.neverTrained == trained) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.ugly == ugly) current = current + 1;
    if (Get.find<AppServices>().answerkey.notSuccessful == successful) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.weak == weak) current = current + 1;
    if (Get.find<AppServices>().answerkey.yelledAt == yelled) {
      current = current + 1;
    }
    if (Get.find<AppServices>().answerkey.noFriendForever == forever) {
      current = current + 1;
    }
    double percent = (current / total) * 100;
    return percent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(leading: backButton(), implyLeading: true),
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
                      text: 'Fact Check Your Thoughts (Test)',
                      weight: FontWeight.bold,
                      alignment: Alignment.center,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.to(
                      () => ReadingScreen(
                        title: 'ER103- Are Your Thoughts Facts?',
                        link:
                            'https://docs.google.com/document/d/1mGyuMG_od8-VuCPXLx8npGrFYc37G5gy/',
                        linked: () => Get.back(),
                        function: () {
                          if (Get.find<ErController>().history.value.value ==
                              82) {
                                 final end = DateTime.now();
                            debugPrint('disposing');
                            Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
                            debugPrint('disposed');
                          }
                          Get.log('closed');
                        },
                      ),
                    ),
                    // () => Get.to(
                    //   () => const ER103Reading(),
                    // ),
                    icon: assetImage(AppIcons.read),
                  ),
                ],
              ),
              verticalSpace(height: 10),
              JournalTop(
                controller: name,
                label: 'Name',
                add: () => clearFacts(),
                save: () async =>
                    edit ? await updateTest(true) : await addTest(true),
                drive: () => Get.off(() => const PreviousTest()),
              ),
              verticalSpace(height: 5),
              const TextWidget(
                text:
                    'This test is designed to help you differentiate between a thought that is a fact and one that is an opinion. It may seem silly or obvious, but in the realm of your mind, the lines can and do blur in the moment. Oftentimes, we \'t fact-check our thoughts and give an opinion the same weight as a fact when making decisions. Mark each question as a factual statement or an opinion.',
                fontStyle: FontStyle.italic,
                weight: FontWeight.bold,
              ),
              verticalSpace(height: 15),
              Align(
                alignment: Alignment.centerRight,
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

              ///
              const TextWidget(
                text: 'Fact?',
                weight: FontWeight.bold,
                size: 16,
              ),
              Row(
                children: [
                  const TextWidget(text: '1', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: idiot,
                    onChanged: (val) {
                      setState(() {
                        idiot = val;
                      });
                    },
                    title: 'I\'m an idiot.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '2', weight: FontWeight.bold),
                  CustomCheckBox(
                    value: ugly,
                    width: Get.width * 0.8,
                    onChanged: (val) {
                      setState(() {
                        ugly = val;
                      });
                    },
                    title: 'I am ugly.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '3', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: fired,
                    onChanged: (val) {
                      setState(() {
                        fired = val;
                      });
                    },
                    title: 'I was fired from my job.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '4', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: hate,
                    onChanged: (val) {
                      setState(() {
                        hate = val;
                      });
                    },
                    title: 'Everybody hates me.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '5', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: friends,
                    onChanged: (val) {
                      setState(() {
                        friends = val;
                      });
                    },
                    title: 'I don\'t have any friends.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '6', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: horrible,
                    onChanged: (val) {
                      setState(() {
                        horrible = val;
                      });
                    },
                    title: 'This will be horrible.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '7', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: bad,
                    onChanged: (val) {
                      setState(() {
                        bad = val;
                      });
                    },
                    title: 'I\'m a bad person.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '8', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: weak,
                    onChanged: (val) {
                      setState(() {
                        weak = val;
                      });
                    },
                    title: 'I\'m weak.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '9', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: overweight,
                    onChanged: (val) {
                      setState(() {
                        overweight = val;
                      });
                    },
                    title: 'I\'m overweight.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '10', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: love,
                    onChanged: (val) {
                      setState(() {
                        love = val;
                      });
                    },
                    title: 'No one could ever love me.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '11', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: forever,
                    onChanged: (val) {
                      setState(() {
                        forever = val;
                      });
                    },
                    title: 'I will have no friends forever.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '12', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: single,
                    onChanged: (val) {
                      setState(() {
                        single = val;
                      });
                    },
                    title: 'I will always be single.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '13', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: alwaySingle,
                    onChanged: (val) {
                      setState(() {
                        alwaySingle = val;
                      });
                    },
                    title: 'I am single.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '14', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: nojob,
                    onChanged: (val) {
                      setState(() {
                        nojob = val;
                      });
                    },
                    title: 'I have no job.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '15', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: loser,
                    onChanged: (val) {
                      setState(() {
                        loser = val;
                      });
                    },
                    title: 'I\'m a loser.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '16', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: successful,
                    onChanged: (val) {
                      setState(() {
                        successful = val;
                      });
                    },
                    title: 'I\'m not successful.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '17', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: debt,
                    onChanged: (val) {
                      setState(() {
                        debt = val;
                      });
                    },
                    title: 'I\'m in debt.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '18', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: sports,
                    onChanged: (val) {
                      setState(() {
                        sports = val;
                      });
                    },
                    title: 'I\'m no good at sports.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '19', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: school,
                    onChanged: (val) {
                      setState(() {
                        school = val;
                      });
                    },
                    title: 'I didn\'t play sports in high school.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '20', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: obese,
                    onChanged: (val) {
                      setState(() {
                        obese = val;
                      });
                    },
                    title: 'I\'m obese.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '21', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: failure,
                    onChanged: (val) {
                      setState(() {
                        failure = val;
                      });
                    },
                    title: 'I\'m a failure.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '22', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: done,
                    onChanged: (val) {
                      setState(() {
                        done = val;
                      });
                    },
                    title: 'I should have never done that.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '23', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: cant,
                    onChanged: (val) {
                      setState(() {
                        cant = val;
                      });
                    },
                    title: 'I can\'t do that.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '24', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: trained,
                    onChanged: (val) {
                      setState(() {
                        trained = val;
                      });
                    },
                    title: 'I\'ve never been trained to do that.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '25', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: greedy,
                    onChanged: (val) {
                      setState(() {
                        greedy = val;
                      });
                    },
                    title: 'I\'m greedy.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '26', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: lazy,
                    onChanged: (val) {
                      setState(() {
                        lazy = val;
                      });
                    },
                    title: 'I\'m lazy.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '27', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: yelled,
                    onChanged: (val) {
                      setState(() {
                        yelled = val;
                      });
                    },
                    title: 'She yelled at me.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '28', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: hit,
                    onChanged: (val) {
                      setState(() {
                        hit = val;
                      });
                    },
                    title: 'She hit me.',
                  ),
                ],
              ),
              Row(
                children: [
                  const TextWidget(text: '29', weight: FontWeight.bold),
                  CustomCheckBox(
                    width: Get.width * 0.8,
                    value: forehead,
                    onChanged: (val) {
                      setState(() {
                        forehead = val;
                      });
                    },
                    title: 'My forehead is too big.',
                  ),
                ],
              ),

              ///
              verticalSpace(height: Get.height * 0.01),
              BottomButtons(
                button1: 'Done',
                button2: 'Save',
                onPressed2: () async => await addTest(true),
                onPressed1: () async => scoredialog(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void scoredialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const TextWidget(
            text: 'Test Score',
            weight: FontWeight.bold,
            size: 16,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextWidget(
                text:
                    'This test was designed to help you differentiate between a thought that is a fact and one that is an opinion, and your current score is:',
              ),
              verticalSpace(height: 3),
              TextWidget(
                  text: '${calculateScore().round().toString()}%',
                  weight: FontWeight.bold),
            ],
          ),
          actions: [
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Get.back();
                      edit ? await updateTest() : await addTest();
                    },
                    style: elevatedButton(),
                    child: const TextWidget(
                      text: 'Save',
                      color: AppColors.white,
                      alignment: Alignment.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: elevatedButton(),
                      child: const TextWidget(
                        text: 'Cancel',
                        color: AppColors.white,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void clearFacts() {
    name.clear();
    setState(() {
      idiot = false;
      ugly = false;
      fired = false;
      hate = false;
      friends = false;
      horrible = false;
      bad = false;
      weak = false;
      overweight = false;
      love = false;
      forever = false;
      single = false;
      alwaySingle = false;
      nojob = false;
      loser = false;
      debt = false;
      sports = false;
      school = false;
      obese = false;
      failure = false;
      done = false;
      cant = false;
      trained = false;
      greedy = false;
      lazy = false;
      yelled = false;
      hit = false;
      forehead = false;
      successful = false;
    });
  }

  final bool edit = Get.arguments[0];
  final Rx<FCTestModel> _test = FCTestModel(
    userid: Get.find<AuthServices>().userid,
    id: generateId(),
  ).obs;

  DateTime initial = DateTime.now();
  void setData(DateTime end) {
    _test.value.title = name.text;
    _test.value.date = currentTime.text;
    _test.value.percentage = calculateScore();
    _test.value.thoughts = ThoughtModel(
      alwaysingle: alwaySingle,
      badperson: bad,
      cantDo: cant,
      inDebt: debt,
      failure: failure,
      fired: fired,
      forehead: forehead,
      greedy: greedy,
      hatesMe: hate,
      hitMe: hit,
      horrible: horrible,
      idiot: idiot,
      lazy: lazy,
      loser: loser,
      neverDonethat: done,
      noFriends: friends,
      noJob: nojob,
      noEverLove: love,
      obese: obese,
      overweight: overweight,
      single: single,
      noSports: sports,
      sportsHighSchool: school,
      neverTrained: trained,
      ugly: ugly,
      notSuccessful: successful,
      weak: weak,
      yelledAt: yelled,
      noFriendForever: forever,
    );
    final diff = end.difference(initial).inSeconds;
    if (edit) {
      _test.value.duration = _test.value.duration! + diff;
    } else {
      _test.value.duration = diff;
    }
  }

  Future addAccomplishment(DateTime end) async {
    final list = Get.find<AuthServices>()
        .accomplishments
        .where((value) => value.id == er);
    if (list.isNotEmpty) {
      list.first.total = list.first.total! + 1;
      list.first.max = list.first.max! + 1;
      list.first.routines!.add(ARoutines(
        name: name.text,
        count: 1,
        duration: end.difference(initial).inSeconds,
        id: _test.value.id,
      ));
      accomplsihmentRef(Get.find<AuthServices>().userid)
          .doc(list.first.id)
          .update(list.first.toMap());
    }
  }

  Future addTest([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      loadingDialog(context);
       final end = DateTime.now();
      setData(end);
      if (edit) _test.value.id = generateId();
      await erRef.doc(_test.value.id).set(_test.value.toMap());
      await addAccomplishment(end);
      if (!fromsave) {
        if (Get.find<ErController>().history.value.value == 83) {
          Get.find<ErController>().updateHistory(end.difference(initial).inSeconds);
        }
        Get.back();
      }
      Get.back();
      customToast(message: 'Test saved successfully');
    }
  }

  Future updateTest([bool fromsave = false]) async {
    Get.focusScope!.unfocus();
    _key.currentState!.save();
    if (_key.currentState!.validate()) {
      loadingDialog(context);
       final end = DateTime.now();
      setData(end);
      await erRef.doc(_test.value.id).update(_test.value.toMap());
      if (!fromsave) Get.back();
      Get.back();
      customToast(message: 'Test updated successfully');
    }
  }

  fetchData() {
    _test.value = Get.arguments[1] as FCTestModel;
    name.text = _test.value.title!;
    currentTime.text = _test.value.date!;
    final ThoughtModel _thought = _test.value.thoughts!;
    alwaySingle = _thought.alwaysingle!;
    bad = _thought.badperson!;
    cant = _thought.cantDo!;
    debt = _thought.inDebt!;
    failure = _thought.failure!;
    fired = _thought.fired!;
    forehead = _thought.forehead!;
    greedy = _thought.greedy!;
    hate = _thought.hatesMe!;
    hit = _thought.hitMe!;
    horrible = _thought.horrible!;
    idiot = _thought.idiot!;
    lazy = _thought.lazy!;
    loser = _thought.loser!;
    done = _thought.neverDonethat!;
    friends = _thought.noFriends!;
    nojob = _thought.noJob!;
    love = _thought.noEverLove!;
    obese = _thought.obese!;
    overweight = _thought.overweight!;
    single = _thought.single!;
    sports = _thought.noSports!;
    school = _thought.sportsHighSchool!;
    trained = _thought.neverTrained!;
    ugly = _thought.ugly!;
    successful = _thought.notSuccessful!;
    weak = _thought.weak!;
    yelled = _thought.yelledAt!;
    forever = _thought.noFriendForever!;
  }
}

class PreviousTest extends StatelessWidget {
  const PreviousTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(implyLeading: true, title: '', actions: []),
      body: StreamBuilder(
        initialData: const [],
        stream: erRef
            .where('userid', isEqualTo: Get.find<AuthServices>().userid)
            .where('type', isEqualTo: 4)
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
              final FCTestModel model =
                  FCTestModel.fromMap(snapshot.data.docs[index]);
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                  onTap: () => Get.to(() => const FactChecking(),
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
