import 'package:flutter/material.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

ExpansionTile contentWidget(
      {required String title, required List<Widget> children}) {
    return ExpansionTile(
      title: TextWidget(text: title, size: 16, weight: FontWeight.w500),
      children: children,
    );
  }

  ExpansionTile subcontentWidget(
      {required String title, required List<Widget> children}) {
    return ExpansionTile(
      title: TextWidget(text: title, size: 14.5, weight: FontWeight.w400),
      children: children,
    );
  }