// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:schedular_project/Widgets/checkboxes.dart';

// ignore: must_be_immutable
class CheckBoxRows extends StatefulWidget {
  CheckBoxRows({
    Key? key,
    required this.titles,
    required this.values,
    this.fontSize = 14,
    this.size = 150,
    this.titleAlignment = Alignment.centerLeft,
    this.editable = true,
  }) : super(key: key);
  List<String> titles;
  List<bool> values;
  double size, fontSize;
  Alignment titleAlignment;
  bool editable;
  @override
  _CheckBoxRowsState createState() => _CheckBoxRowsState();
}

class _CheckBoxRowsState extends State<CheckBoxRows> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.titles.length,
        itemBuilder: (context, index) {
          return CustomCheckBox(
            value: widget.values[index],
            onChanged: widget.editable
                ? (value) {
                    setState(() {
                      widget.values[index] = value;
                    });
                  }
                : null,
            title: widget.titles[index],
            width: widget.size,
            textAlignment: widget.titleAlignment,
          );
        },
      ),
    );
  }
}
