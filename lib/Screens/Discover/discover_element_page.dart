import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Model/app_modal.dart';
import 'package:schedular_project/Widgets/app_bar.dart';

import '../../Widgets/custom_button.dart';
import '../../Widgets/spacer_widgets.dart';
import '../../Widgets/text_widget.dart';

class DiscoverElementScreen extends StatelessWidget {
  DiscoverElementScreen({Key? key}) : super(key: key);
  final String title = Get.arguments[0];
  final List<AppModel> list = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextWidget(
                  text: 'Discover- $title',
                  size: 15,
                  weight: FontWeight.bold,
                  alignment: Alignment.center,
                ),
              ),
            ),
            verticalSpace(height: 30),
            Column(
              children: List.generate(
                list.length,
                (index) => AppButton(
                  title: list[index].title,
                  description: list[index].description,
                  onTap: list[index].ontap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
