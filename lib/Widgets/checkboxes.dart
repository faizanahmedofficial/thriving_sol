// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

// ignore: must_be_immutable
class CustomCheckBox extends StatefulWidget {
  CustomCheckBox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.fontSize = 14,
    this.width = 150,
    this.alignment = Alignment.topLeft,
    this.textAlignment = Alignment.centerLeft,
    this.titleWeight = FontWeight.normal,
    this.titleColor = AppColors.black,
  }) : super(key: key);
  bool? value;
  var onChanged;
  double? width, fontSize;
  String? title;
  Alignment alignment;
  Alignment textAlignment;
  FontWeight titleWeight;
Color titleColor;
  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: SizedBox(
        width: widget.width,
        child: ListTile(
          horizontalTitleGap: 0,
          contentPadding: EdgeInsets.zero,
          minVerticalPadding: 0,
          leading: Tooltip(
            message: widget.title!,
            child: Checkbox(
              value: widget.value,
              onChanged: widget.onChanged,
            ),
          ),
          title: TextWidget(
            text: widget.title!,
            alignment: widget.textAlignment,
            weight: widget.titleWeight,
            color: widget.titleColor,
          ),
        ),
      ),
    );
  }
}
