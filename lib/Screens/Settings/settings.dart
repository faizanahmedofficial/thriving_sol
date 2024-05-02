// ignore_for_file: avoid_print, prefer_final_fields, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Controller/user_controller.dart';
import 'package:schedular_project/Functions/functions.dart';
import 'package:schedular_project/Global/firebase_collections.dart';

import 'package:schedular_project/Screens/Discover/discover_page.dart';
import 'package:schedular_project/Screens/Routines/routine_screen.dart';
import 'package:schedular_project/Screens/accomplishment_screen.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/checkboxes.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../Global/global.dart';
import '../../Services/auth_services.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final UserController _app = Get.find();
  bool? auto = false;
  bool? autopen = false;
  int setting = 0;
  RxBool password = false.obs;
  RxBool email = false.obs;
  final String _password = Get.find<AuthServices>().user.password!;
  final String _email = Get.find<AuthServices>().user.email!;

  Future updatePassword() async {
    String _enterd = Get.find<UserController>().user.value.password!;
    print(_enterd);
    try {
      if (_enterd != _password) {
        loadingDialog(context);
        await auth
            .signInWithEmailAndPassword(email: _email, password: _password)
            .then((credential) {
          credential.user!.updatePassword(_enterd).then((value) async {
            await usersRef
                .doc(Get.find<AuthServices>().userid)
                .update({'password': _enterd});
            await Get.find<UserController>()
                .fetchUser(Get.find<AuthServices>().userid);
            Get.back();
            customToast(message: 'Password updated successfully');
          });
        });
      } else {
        customToast(message: 'Password already updated');
      }
      password.value = !password.value;
    } catch (e) {
      Get.back();
      customToast(message: e.toString());
    }
  }

  Future updateEmailAddress() async {
    String _enterd = Get.find<UserController>().user.value.email!;
    print(_enterd);
    try {
      if (_enterd != _email) {
        loadingDialog(context);
        await auth
            .signInWithEmailAndPassword(email: _email, password: _password)
            .then((credential) {
          credential.user!.updateEmail(_enterd).then((value) async {
            await usersRef
                .doc(Get.find<AuthServices>().userid)
                .update({'email': _email});
            await Get.find<UserController>()
                .fetchUser(Get.find<AuthServices>().userid);
            Get.back();
            customToast(message: 'Email address updated successfully');
          });
        });
      } else {
        customToast(message: 'Email address already updated');
      }
      email.value = !email.value;
    } catch (e) {
      Get.back();
      customToast(message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: customAppbar(
            title: 'Thriving.org',
            titleWeight: FontWeight.normal,
            titleAlignment: Alignment.topLeft,
            actions: [
              IconButton(
                tooltip: 'Routines',
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.calendar_today),
                onPressed: () {
                  Get.log('Go to routines for the time being');
                  Get.to(() => const AppRoutines());
                },
              ),
              IconButton(
                tooltip: 'Discover Page',
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.local_florist),
                onPressed: () {
                  Get.log('Going to discover page');
                  Get.to(() => const DiscoverPage());
                },
              ),
              IconButton(
                tooltip: 'Accomplishments',
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.star),
                onPressed: () {
                  Get.log('Going to accomplishments page');
                  Get.to(() => const AccomplishmentScreen());
                },
              ),
              IconButton(
                tooltip: 'Logout',
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.logout_outlined),
                onPressed: () {
                  Get.log('Loggin out');
                  _app.userLogout();
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                verticalSpace(height: 20),
                const TextWidget(
                  text: 'Settings',
                  weight: FontWeight.bold,
                  alignment: Alignment.center,
                  size: 16,
                ),
                verticalSpace(height: 30),
                CustomCheckBox(
                  value: Get.find<AuthServices>().settings.start,
                  onChanged: (value) {
                    setState(() {
                      auto = value;
                      Get.find<UserController>().settings.value.start = value;
                      settingRef.doc(Get.find<AuthServices>().userid).update({
                        'start': value,
                      });
                    });
                  },
                  title: 'Alarms automatically set for start time?',
                  width: Get.width,
                  alignment: Alignment.center,
                ),
                CustomCheckBox(
                  value: Get.find<AuthServices>().settings.open,
                  onChanged: (value) {
                    setState(() {
                      autopen = value;
                      Get.find<UserController>().settings.value.open = value;
                      settingRef.doc(Get.find<AuthServices>().userid).update({
                        'open': value,
                      });
                    });
                  },
                  title: 'Auto-open events at their designated time?',
                  width: Get.width,
                  alignment: Alignment.center,
                ),
                verticalSpace(height: 30),
                Align(
                  // alignment: Alignment.topLeft,
                  child: DropdownButtonHideUnderline(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.only(left: 10.0),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 1.0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                      ),
                      child: DropdownButton<int>(
                        items: settingList
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.value,
                                child: SizedBox(
                                  width: width * 0.7,
                                  child: TextWidget(
                                    text: e.title,
                                    alignment: Alignment.centerLeft,
                                    maxline: 1,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        value: Get.find<AuthServices>().settings.autoContinue,
                        onChanged: (value) {
                          setState(() {
                            setting = value!;
                            Get.find<UserController>()
                                .settings
                                .value
                                .autoContinue = value;
                            settingRef
                                .doc(Get.find<AuthServices>().userid)
                                .update({
                              'continue': value,
                            });
                          });
                        },
                      ),
                    ),
                  ),
                ).marginOnly(bottom: 50),
                titles('Account', alignment: Alignment.center)
                    .marginOnly(bottom: 20),
                TextWidget(
                  text:
                      'Member since   ${formateDate(Get.find<AuthServices>().user.created!)}',
                  alignment: Alignment.center,
                  size: 17,
                ).marginOnly(bottom: 50),
                SizedBox(
                  width: width * 0.6,
                  child: Column(
                    children: [
                      TextWidget(
                        text: Get.find<AuthServices>().user.name!.capitalize!,
                        fontStyle: FontStyle.italic,
                      ),
                      TextFormField(
                        autofocus: password.value,
                        readOnly: !password.value,
                        initialValue: Get.find<AuthServices>().user.password,
                        onChanged: (val) => Get.find<UserController>()
                            .user
                            .value
                            .password = val,
                        decoration: inputDecoration(
                          hint: 'Password',
                          suffix: !password.value
                              ? null
                              : IconButton(
                                  onPressed: () async => await updatePassword(),
                                  icon: const Icon(Icons.check),
                                ),
                        ),
                      ),
                      InkWell(
                        onTap: () => password.value = !password.value,
                        child: const TextWidget(
                          text: 'Change password...',
                          fontStyle: FontStyle.italic,
                          size: 16,
                        ),
                      ).marginOnly(top: 1, bottom: 15),
                      TextFormField(
                        autofocus: email.value,
                        readOnly: !email.value,
                        initialValue: Get.find<AuthServices>().user.email,
                        onChanged: (val) =>
                            Get.find<UserController>().user.value.email = val,
                        keyboardType: TextInputType.emailAddress,
                        decoration: inputDecoration(
                          hint: 'Email',
                          suffix: !email.value
                              ? null
                              : IconButton(
                                  onPressed: () async {
                                    if (!Get.find<UserController>()
                                        .user
                                        .value
                                        .email!
                                        .isEmail) {
                                      customToast(
                                          message:
                                              'Please enter a valid email address');
                                    } else {
                                      await updateEmailAddress();
                                    }
                                  },
                                  icon: const Icon(Icons.check),
                                ),
                        ),
                      ),
                      InkWell(
                        onTap: () => email.value = !email.value,
                        child: const TextWidget(
                          text: 'Change recovery email...',
                          fontStyle: FontStyle.italic,
                          size: 16,
                        ),
                      )
                    ],
                  ),
                ).marginOnly(bottom: 40),
                titles('Your Access', alignment: Alignment.center)
                    .marginOnly(bottom: 20),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: _currentExercises.length,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                  itemBuilder: (context, index) => TextWidget(
                    text: docids[index].title,
                    color:
                        _currentExercises[index] ? Colors.black : Colors.grey,
                    size: 17,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  RxList<bool> _currentExercises = <bool>[].obs;

  checkCurrentExercises() async {
    for (int i = 0; i < docids.length; i++) {
      await currentExercises(Get.find<AuthServices>().userid)
          .doc(docids[i].description)
          .get()
          .then((value) {
        print('fetching');
        if (value.data() == null) {
          _currentExercises.add(false);
        } else {
          _currentExercises.add(true);
        }
      });
    }
    setState(() {});
    print(_currentExercises);
  }

  @override
  void initState() {
    setState(() {
      checkCurrentExercises();
    });
    super.initState();
  }
}
