import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Screens/main_screen.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

// ignore: must_be_immutable
class ResetConfirm extends StatelessWidget {
  ResetConfirm({Key? key}) : super(key: key);
  final _parameters = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(actions: []),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            verticalSpace(height: 50),
            const TextWidget(text: 'Check Inbox'),
            verticalSpace(height: 20),
            const TextWidget(
                text:
                    'We have sent a reset password link to the email address'),
            verticalSpace(height: 20),
            TextWidget(text: _parameters[0]!),
            verticalSpace(height: 30),
            const TextWidget(
                text:
                    'If you do not receive the email within 5 minutes , then please check your spam folder.'),
            verticalSpace(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.log('Going back to home');
                Get.offAll(() => const MainScreen());
              },
              child: const TextWidget(text: 'Close'),
            ),
          ],
        ),
      ),
    );
  }
}
