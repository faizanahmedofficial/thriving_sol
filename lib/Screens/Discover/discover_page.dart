import 'package:flutter/material.dart';
import 'package:schedular_project/Common/commons.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';
import '../../Constants/constants.dart';
import '../../Widgets/custom_button.dart';


class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(titleAlignment: Alignment.topLeft, actions: appactions),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(height: 10),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: TextWidget(
                  text: 'Discover',
                  size: 15,
                  weight: FontWeight.bold,
                  alignment: Alignment.center,
                ),
              ),
            ),
            verticalSpace(height: 30),
            Column(
              children: List.generate(
                discoverList.length,
                (index) => AppButton(
                  title: discoverList[index].title,
                  description: discoverList[index].description,
                  onTap: discoverList[index].ontap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
