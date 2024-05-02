import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Screens/Authentications/forget_password.dart';
import 'package:schedular_project/Screens/Authentications/signup.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../Constants/constants.dart';
import '../../Database/firebase_auth.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var loginKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: 'Thriving.org', actions: []),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              verticalSpace(height: 70),
              InkWell(
                onTap: () => Get.to(() => const SignupScreen()),
                child: const TextWidget(
                  text: 'No Account? Register here for FREE',
                  alignment: Alignment.center,
                ),
              ),
              verticalSpace(height: 50),
              const TextWidget(
                text: 'Login',
                size: 17,
                alignment: Alignment.center,
                weight: FontWeight.bold,
              ),
              verticalSpace(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                
                children: [
                  const TextWidget(
                    text: 'Email',
                    alignment: Alignment.bottomCenter,
                    size: 16,
                  ),
                  horizontalSpace(width: width * 0.14),
                  SizedBox(
                    width: width * 0.6,
                    child: TextFormField(
                      maxLines: 1,
                      controller: username,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(
                          color: AppColors.black, fontFamily: 'Arial'),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Email is required';
                        } else if (!GetUtils.isEmail(val)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                        dense: true,
                        // error: 'Username is required',
                        errorColor: AppColors.red,
                        focusColor: AppColors.black,
                        borderColor: Colors.grey,
                        border: const OutlineInputBorder(),
                        focusBorder: const OutlineInputBorder(),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ).marginOnly(bottom: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const TextWidget(
                    text: 'Password',
                    alignment: Alignment.bottomCenter,
                    size: 16,
                  ),
                  horizontalSpace(width: width * 0.075),
                  SizedBox(
                    width: width * 0.6,
                    child: TextFormField(
                      maxLines: 1,
                      controller: password,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(
                          color: AppColors.black, fontFamily: 'Arial'),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                        dense: true,
                        // error: 'Username is required',
                        errorColor: AppColors.red,
                        focusColor: AppColors.black,
                        borderColor: Colors.grey,
                        border: const OutlineInputBorder(),
                        focusBorder: const OutlineInputBorder(),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(height: 60),
              InkWell(
                onTap: () => Get.to(() => ForgetScreen()),
                child: const TextWidget(
                  text: 'Forget username or password?',
                  alignment: Alignment.center,
                ),
              ),
              verticalSpace(height: 80),
              Container(
                height: 65,
                width: 65,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    if (loginKey.currentState!.validate()) {
                      Get.log('====Login and Redirecting to Home Page====');
                      userLogin(
                        context,
                        true,
                        email: username.text,
                        password: password.text,
                      );
                      loginKey.currentState!.save();
                    }
                  },
                  tooltip: 'Login',
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
