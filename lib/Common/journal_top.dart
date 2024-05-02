// ignore_for_file: prefer_typing_uninitialized_variables, avoid_unnecessary_containers, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Theme/input_decoration.dart';
import 'package:schedular_project/Widgets/custom_images.dart';

import '../app_icons.dart';

// ignore: must_be_immutable
class JournalTop extends StatefulWidget {
  JournalTop({
    Key? key,
    required this.controller,
    this.label = 'Name',
    this.add,
    this.save,
    this.drive,
    this.validator = true,
    this.show = true,
  }) : super(key: key);
  final TextEditingController controller;
  final String label;
  VoidCallback? add, save, drive, reading;
  bool validator, show;

  @override
  _JournalTopState createState() => _JournalTopState();
}

class _JournalTopState extends State<JournalTop> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: Get.width * 0.5,
          child: TextFormField(
            controller: widget.controller,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.name,
            style: const TextStyle(fontFamily: 'Arial'),
            decoration: inputDecoration(hint: widget.label),
            validator: widget.validator
                ? (val) {
                    if (val!.isEmpty) {
                      return 'Journal name is required';
                    }
                    return null;
                  }
                : null,
          ),
        ),
        if (widget.show)
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                tooltip: 'New Routine',
                onPressed: widget.add ?? () {},
                icon: const Icon(Icons.add, color: AppColors.black),
                padding: EdgeInsets.zero,
              ),
              IconButton(
                tooltip: 'Save Routine',
                onPressed: widget.save ?? () {},
                icon: const Icon(Icons.save_outlined, color: AppColors.black),
                padding: EdgeInsets.zero,
              ),
              IconButton(
                tooltip: 'Load Routine',
                onPressed: widget.drive ?? () {},
                icon: const Icon(Icons.drive_folder_upload_outlined,
                    color: AppColors.black),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
      ],
    );
  }
}

class ReadingButton extends StatelessWidget {
  const ReadingButton({Key? key, this.onPressed}) : super(key: key);
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Reading',
      onPressed: onPressed ?? () {},
      icon: assetImage(AppIcons.read, width: 20),
      padding: EdgeInsets.zero,
    );
  }
}
