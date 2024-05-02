import 'package:flutter/material.dart';
import 'package:schedular_project/Constants/colors.dart';

InputDecoration inputDecoration({
  String? helper,
  String? hint,
  String? error,
  String? label,
  Color? labelColor = Colors.grey,
  Color? helperColor = Colors.grey,
  Color? errorColor = Colors.red,
  Color? hintColor = Colors.grey,
  Widget? suffix,
  Widget? prefix,
  bool? filled = false,
  Color? filledColor,
  Color? focusColor = AppColors.black,
  InputBorder? border,
  Color? borderColor = AppColors.black,
  InputBorder? errorBorder,
  InputBorder? focusBorder,
  bool? dense = true,
  double hintSize = 12,
  double radius = 4,
}) {
  return InputDecoration(
    isDense: dense,
    filled: filled,
    fillColor: filledColor,
    helperText: helper,
    errorText: error,
    labelText: label,
    hintText: hint,
    helperStyle: TextStyle(color: helperColor, fontFamily: 'Arial'),
    errorStyle: TextStyle(color: errorColor, fontFamily: 'Arial'),
    labelStyle: TextStyle(color: labelColor, fontFamily: 'Arial'),
    hintStyle:
        TextStyle(color: hintColor, fontFamily: 'Arial', fontSize: hintSize),
    suffixIcon: suffix,
    prefixIcon: prefix,
    border: border ??
        OutlineInputBorder(
          borderSide: BorderSide(color: borderColor!),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
    enabledBorder: border ??
        OutlineInputBorder(
          borderSide: BorderSide(color: borderColor!),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
    focusedBorder: focusBorder ??
        OutlineInputBorder(
          borderSide: BorderSide(color: focusColor!),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
    errorBorder: errorBorder ??
        OutlineInputBorder(
          borderSide: BorderSide(color: errorColor!),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
    focusedErrorBorder: errorBorder ??
        OutlineInputBorder(
          borderSide: BorderSide(color: errorColor!),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
    disabledBorder: border ??
        OutlineInputBorder(
          borderSide: BorderSide(color: borderColor!),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
  );
}

decoration({String? label, String? hint}) {
  return inputDecoration(
    border: InputBorder.none,
    focusBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    hint: hint,
    label: label,
  );
}
