import 'package:flutter/material.dart';
import 'package:schedular_project/Constants/constants.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

Widget switchWiget(
    {required var onChanged,
    required bool value,
    required String title,
    double? swidth}) {
  return SizedBox(
    width: swidth ?? width * 0.4,
    child: ListTile(
      leading: Switch(value: value, onChanged: onChanged),
      title: TextWidget(text: title, alignment: Alignment.centerLeft),
    ),
  );
}
