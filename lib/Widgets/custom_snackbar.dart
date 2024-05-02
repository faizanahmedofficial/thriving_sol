import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/colors.dart';

customSnackbar({
  required String title,
  required String message,
  SnackPosition position = SnackPosition.TOP,
  Color backgroundColor = AppColors.white,
  Color textColor = AppColors.black,
}) {
  return Get.snackbar(
    title,
    message,
    snackPosition: position,
    colorText: textColor,
    backgroundColor: backgroundColor,
  );
}
