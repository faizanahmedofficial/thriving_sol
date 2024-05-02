// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Controller/play_routine_controller.dart';
import 'package:schedular_project/Theme/buttons_theme.dart';
import 'package:schedular_project/Widgets/progress_indicator.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../Services/auth_services.dart';

///
scriptdialog(BuildContext context, String path, String filename,
    {VoidCallback? download, VoidCallback? play, RxBool? loading}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextWidget(
              text: 'Success!',
              weight: FontWeight.bold,
              size: 16,
              alignment: Alignment.centerLeft,
            ),
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            TextWidget(
              text:
                  'Your visualization script has been generated successfully and you can download it to listen to it later.',
            ),
          ],
        ),
        actions: [
          Obx(
            () => loading!.value
                ? progressIndicator()
                : SizedBox(
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: download ?? () {},
                          style: elevatedButton(
                            primary: AppColors.black,
                            radius: 20,
                          ),
                          child: const TextWidget(
                            text: 'Download Now!',
                            color: Colors.white,
                            alignment: Alignment.center,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: play ?? () {},
                          style: elevatedButton(
                            primary: AppColors.black,
                            radius: 20,
                          ),
                          child: const TextWidget(
                            text: 'Play Audio',
                            color: Colors.white,
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      );
    },
  );
}

///
infoDialog(DateTime start) {
  if (Get.find<AuthServices>().settings.autoContinue == 0) {
    Get.dialog(
      AlertDialog(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const TextWidget(
          text: 'Your time is up!',
          weight: FontWeight.bold,
          size: 16,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            TextWidget(text: 'What would you like to do?'),
          ],
        ),
        actions: [
          SizedBox(
            width: width,
            height: 45,
            child: OutlinedButton(
              onPressed: () {
                Get.back();
                final end = DateTime.now();
                Get.find<PlayRoutineController>().completeElement(
                  end.difference(start).inSeconds,
                );
              },
              style: outlineButton(),
              child: const TextWidget(
                text:
                    'Go to the next exercise in your routine now without saving?',
                alignment: Alignment.center,
              ),
            ),
          ).marginOnly(bottom: 10),
          SizedBox(
            width: width,
            height: 45,
            child: OutlinedButton(
              onPressed: () {
                // Get.back();
                Timer(
                  const Duration(minutes: 1),
                  () {
                    print('1 minute completed');
                    infoDialog(start);
                  },
                );
                Get.back();
              },
              style: outlineButton(),
              child: const TextWidget(
                text: 'Add 1 minute',
                alignment: Alignment.center,
              ),
            ),
          ).marginOnly(bottom: 10),
          SizedBox(
            width: width,
            height: 45,
            child: OutlinedButton(
              onPressed: () {
                Get.back();
                final end = DateTime.now();
                Get.find<PlayRoutineController>().completeElement(
                  end.difference(start).inSeconds,
                  current: true,
                );
              },
              style: outlineButton(),
              child: const TextWidget(
                text: 'Continue and disable timer for now',
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  } else {
    final end = DateTime.now();
    // Get.find<PlayRoutineController>().updateStats();
    Get.find<PlayRoutineController>().completeElement(
      end.difference(start).inSeconds,
      current: true,
    );
  }
 
}
