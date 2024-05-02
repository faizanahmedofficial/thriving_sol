import 'package:flutter/material.dart';
import 'package:schedular_project/Constants/colors.dart';

Future<TimeOfDay> customTimePicker(
  BuildContext context, {
  required TimeOfDay initialTime,
}) async {
  final TimeOfDay? time = await showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.black, // header background color
            onPrimary: AppColors.white, // header text color
            onSurface: AppColors.black, // body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.black, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  return time!;
}
