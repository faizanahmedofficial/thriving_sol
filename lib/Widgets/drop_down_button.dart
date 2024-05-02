import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDropDownStruct extends StatelessWidget {
  CustomDropDownStruct({
    Key? key,
    required this.child,
    this.height = 40,
    this.width,
    this.padding = const EdgeInsets.only(left: 10.0),
  }) : super(key: key);
  double height;
  double? width;
  EdgeInsetsGeometry padding;
  DropdownButton child;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.0, style: BorderStyle.solid),
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
        ),
        child: child,
      ),
    );
  }
}
