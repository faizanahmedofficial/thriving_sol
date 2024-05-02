import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Model/app_modal.dart';

import '../Constants/constants.dart';
import '../Model/app_user.dart';
import '../Widgets/app_bar.dart';
import '../Widgets/text_widget.dart';
import '../Widgets/widgets.dart';

class CustomReadingLibrary extends StatelessWidget {
  const CustomReadingLibrary(
      {Key? key,
      required this.title,
      required this.list,
      this.color,
      this.userReadings})
      : super(key: key);
  final String title;
  final List<AppModel> list;
  final Color? color;
  final UserReadings? userReadings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
        child: Column(
          children: [
            headline('$title Library').marginOnly(bottom: 20),
            CustomContainer(
              background: color ?? const Color(0xffD6E9FF),
              child: ExpansionTile(
                initiallyExpanded: true,
                tilePadding: EdgeInsets.zero,
                trailing: const SizedBox.shrink(),
                childrenPadding:
                    const EdgeInsets.only(left: 15, right: 10, bottom: 30),
                title: Row(
                  children: [
                    const Icon(Icons.keyboard_arrow_down),
                    SizedBox(width: width * 0.78, child: elementTitle(title)),
                  ],
                ),
                children: List.generate(
                  list.length,
                  (index) => userReadings == null
                      ? InkWell(
                          onTap: list[index].ontap ?? () {},
                          child: elementTitle2(list[index].title)
                              .marginOnly(bottom: 7),
                        )
                      : InkWell(
                          onTap: list[index].value! <= userReadings!.element!
                              ? list[index].ontap ?? () {}
                              : () {},
                          child: elementTitle2(list[index].title)
                              .marginOnly(bottom: 7),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
