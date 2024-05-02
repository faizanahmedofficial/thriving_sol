// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/colors.dart';

import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../Database/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final signupKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password2 = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(actions: []),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Form(
          key: signupKey,
          child: Column(
            children: [
              verticalSpace(height: 70),
              TextWidget(
                text: 'Signup Here!'.toUpperCase(),
                alignment: Alignment.center,
                weight: FontWeight.bold,
                size: 17,
              ),
              verticalSpace(height: 30),
              TextFormField(
                controller: name,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: inputDecoration(hint: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              verticalSpace(height: 7),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: inputDecoration(hint: 'Email Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  } else if (!GetUtils.isEmail(value)) {
                    return 'Please enter the valid email address';
                  }
                  return null;
                },
              ),
              verticalSpace(height: 7),
              TextFormField(
                controller: password,
                obscureText: !showPassword,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: inputDecoration(
                  hint: 'Password',
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                        print(showPassword);
                      });
                    },
                    tooltip: !showPassword ? 'Show Password' : 'Hide Password',
                    icon: Icon(
                      showPassword
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined,
                      color: showPassword ? AppColors.black : Colors.grey,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              verticalSpace(height: 7),
              TextFormField(
                controller: password2,
                obscureText: !showPassword,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: inputDecoration(
                  hint: 'Confirm Password',
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                        print(showPassword);
                      });
                    },
                    tooltip: !showPassword ? 'Show Password' : 'Hide Password',
                    icon: Icon(
                      showPassword
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined,
                      color: showPassword ? AppColors.black : Colors.grey,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  } else if (value != password.text) {
                    return 'Password does not match.';
                  }
                  return null;
                },
              ),
              verticalSpace(height: 20),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: const TextWidget(
                    text: 'Already have an account? Login Here!',
                    weight: FontWeight.bold,
                  ),
                ),
              ),
              verticalSpace(height: 50),
              Container(
                height: 65,
                width: 65,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    if (signupKey.currentState!.validate()) {
                      Get.log(
                          '====Signing up and Redirecting to Home Page====');
                      userSignup(
                        context,
                        true,
                        email: email.text,
                        password: password.text,
                        name: name.text,
                      );
                      signupKey.currentState!.save();
                    }
                  },
                  tooltip: 'Signup',
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.white,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
