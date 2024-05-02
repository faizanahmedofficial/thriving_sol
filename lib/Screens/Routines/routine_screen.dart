// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Common/commons.dart';
import 'package:schedular_project/Model/app_modal.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../../Constants/constants.dart';

class AppRoutines extends StatefulWidget {
  const AppRoutines({Key? key}) : super(key: key);

  @override
  _AppRoutinesState createState() => _AppRoutinesState();
}

class _AppRoutinesState extends State<AppRoutines> {
  bool? youRoutines = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(actions: appactions, titleAlignment: Alignment.topLeft),
      body: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpace(height: 10),
            const TextWidget(
              text: 'Create your Thriving Shortcut',
              alignment: Alignment.center,
              weight: FontWeight.bold,
              size: 22,
            ),
            verticalSpace(height: height * 0.15),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                routineOptions.length,
                (index) => RoutineButton(model: routineOptions[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoutineButton extends StatelessWidget {
  const RoutineButton({Key? key, required this.model}) : super(key: key);
  final AppModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: model.ontap ?? () {},
      child: Container(
        width: width,
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
        margin: EdgeInsets.only(left: 25, right: 25, bottom: height * 0.12),
        decoration: BoxDecoration(border: Border.all()),
        child: Column(
          children: [
            TextWidget(
              text: model.title,
              weight: FontWeight.bold,
              size: 18,
              textAlign: TextAlign.center,
              alignment: Alignment.center,
            ).marginOnly(bottom: 7),
            TextWidget(
              text: model.description,
              size: 15,
              textAlign: TextAlign.center,
              alignment: Alignment.center,
            ).marginOnly(left: 5, right: 5),
          ],
        ),
      ),
    );
  }
}
