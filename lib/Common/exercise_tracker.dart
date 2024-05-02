// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

// ignore: must_be_immutable
class ExerciseTracker extends StatefulWidget {
  ExerciseTracker({
    Key? key,
    required this.exName,
    required this.exLevel,
    required this.level,
    required this.onPressed,
  }) : super(key: key);
  final String exName, level, exLevel;
  var onPressed;

  @override
  _ExerciseTrackerState createState() => _ExerciseTrackerState();
}

class _ExerciseTrackerState extends State<ExerciseTracker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      alignment: Alignment.topLeft,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.0, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: widget.exName,
                  alignment: Alignment.topLeft,
                  textAlign: TextAlign.left,
                ),
                verticalSpace(height: 5),
                TextWidget(
                  text: widget.level,
                  weight: FontWeight.bold,
                  size: 15.5,
                  alignment: Alignment.topLeft,
                  textAlign: TextAlign.left,
                ),
                verticalSpace(height: 5),
                TextWidget(
                  text: widget.exLevel,
                  weight: FontWeight.bold,
                  size: 16,
                  alignment: Alignment.topLeft,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: widget.onPressed,
            icon: const Icon(
              Icons.play_arrow,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
