import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Screens/main_screen.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../Common/commons.dart';

AppBar customAppbar({
  String? title = 'Thriving.org',
  Widget? leading,
  List<Widget>? actions,
  double iconSize = 24.0,
  double? elevation = 0.0,
  bool? centerTitle = false,
  bool implyLeading = false,
  double titleFontSize = 16,
  FontWeight titleWeight = FontWeight.bold,
  Alignment titleAlignment = Alignment.centerLeft,
  Color actionsIconColor = AppColors.black,
  Color? backgroundColor = AppColors.white,
}) {
  return AppBar(
    actions: actions ?? appactions,
    leading: implyLeading ? leading : null,
    elevation: elevation,
    centerTitle: centerTitle,
    backgroundColor: backgroundColor,
    automaticallyImplyLeading: implyLeading,
    actionsIconTheme: IconThemeData(color: actionsIconColor, size: iconSize),
    iconTheme: IconThemeData(color: actionsIconColor, size: iconSize),
    title: GestureDetector(
      onTap: title == 'Thriving.org'
          ? () => Get.offAll(() => const MainScreen())
          : () {},
      child: TextWidget(
        text: title ?? '',
        size: titleFontSize,
        weight: titleWeight,
        alignment: titleAlignment,
      ),
    ),
  );
}
