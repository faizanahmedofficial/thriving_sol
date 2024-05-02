import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/colors.dart';
import 'package:schedular_project/Widgets/progress_indicator.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

loadingDialog(BuildContext context, {String text = 'Please wait'}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                backgroundColor: AppColors.black,
                valueColor: AlwaysStoppedAnimation(AppColors.white),
              ),
              horizontalSpace(width: 5),
              TextWidget(text: text),
            ],
          ),
        );
      });
}

screenLoading(BuildContext context) {
  showDialog(
    barrierColor: Colors.grey.withOpacity(0.5),
    barrierDismissible: false,
    context: context,
    builder: (context) => progressIndicator(),
  );
}

loadingContent() {
  Get.dialog(
    progressIndicator(),
    barrierDismissible: false,
  );
}
