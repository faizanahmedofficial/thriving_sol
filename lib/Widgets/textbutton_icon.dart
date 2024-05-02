// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

// ignore: must_be_immutable
class IconTextButton extends StatefulWidget {
  IconTextButton({
    Key? key,
    required this.text,
     this.icon,
    required this.onPressed,
    this.icons,
  }) : super(key: key);
  String text;
  IconData? icon;
  var onPressed;
  Widget? icons;

  @override
  _IconTextButtonState createState() => _IconTextButtonState();
}

class _IconTextButtonState extends State<IconTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: widget.onPressed,
      icon: widget.icons ?? Icon(widget.icon!, color: AppColors.black),
      label: TextWidget(text: widget.text),
    );
  }
}
