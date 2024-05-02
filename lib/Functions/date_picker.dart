import 'package:flutter/material.dart';
import 'package:schedular_project/Constants/colors.dart';

Future<DateTime> customDatePicker(
  BuildContext context, {
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) async {
  var date = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
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

  // print(DateFormat('MM/dd/yy').format(date!));
  return date!;
}
