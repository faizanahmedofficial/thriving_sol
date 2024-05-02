import 'package:flutter/material.dart';
import 'package:schedular_project/Constants/colors.dart';

textButton() {
  return TextButton.styleFrom();
}

outlineButton({
  Color? primary = AppColors.black,
  Color? surface = AppColors.white,
  Color? borderColor = AppColors.black,
  double? radius = 10.0,
}) {
  return OutlinedButton.styleFrom(
    foregroundColor: primary,
    disabledForegroundColor: surface!.withOpacity(0.38),
    side: BorderSide(
      color: borderColor!,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
  );
}

elevatedButton({
  Color? primary = AppColors.black,
  Color? surface = AppColors.white,
  Color? borderColor = AppColors.black,
  Color onPrimary = AppColors.white,
  double? radius = 10.0,
}) {
  return ElevatedButton.styleFrom(
    foregroundColor: onPrimary,
    backgroundColor: primary,
    disabledForegroundColor: surface!.withOpacity(0.38),
    disabledBackgroundColor: surface.withOpacity(0.12),
    side: BorderSide(color: borderColor!),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
  );
}
