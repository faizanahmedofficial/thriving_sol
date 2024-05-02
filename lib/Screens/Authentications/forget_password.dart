import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Theme/buttons_theme.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../Database/firebase_auth.dart';

// ignore: must_be_immutable
class ForgetScreen extends StatelessWidget {
  ForgetScreen({Key? key}) : super(key: key);
  final forgetKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(actions: []),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: forgetKey,
          child: Column(
            children: [
              verticalSpace(height: 20),
              const TextWidget(text: 'Forget Password'),
              verticalSpace(height: 50),
              const TextWidget(text: 'Enter your registered email address'),
              TextFormField(
                controller: email,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: inputDecoration(),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Email is required';
                  } else if (!GetUtils.isEmail(val)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              verticalSpace(height: 50),
              ElevatedButton(
                onPressed: () {
                  if (forgetKey.currentState!.validate()) {
                    Get.log('--- Resetting Password ---');
                    resetPassword(context, true, email: email.text);
                    forgetKey.currentState!.save();
                  }
                },
                style: elevatedButton(),
                child: const TextWidget(
                  text: 'Reset Password',
                  alignment: Alignment.center,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
