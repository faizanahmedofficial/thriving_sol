// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Theme/buttons_theme.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

// ignore: must_be_immutable
class BottomButtons extends StatefulWidget {
  BottomButtons({
    Key? key,
    this.button1 = 'Save',
    this.button2 = 'Save as',
    this.button3 = 'Cancel',
    this.onPressed1,
    this.onPressed2,
    this.onPressed3,
    this.b1,
    this.b2, this.b3,
  }) : super(key: key);
  final String button1, button2, button3;
  var onPressed1;
  var onPressed2;
  var onPressed3;
  double? b1, b2, b3;
  @override
  _BottomButtonsState createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        verticalSpace(height: 20),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: widget.b1 ?? Get.width * 0.39,
                child: OutlinedButton(
                  onPressed: widget.onPressed1 ?? () {},
                  style: outlineButton(radius: 5),
                  child: TextWidget(
                    text: widget.button1,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(
                width: widget.b2 ?? Get.width * 0.25,
                child: OutlinedButton(
                  onPressed: widget.onPressed2 ?? () {},
                  style: outlineButton(radius: 5),
                  child: TextWidget(
                    text: widget.button2,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(
                width:widget.b3?? Get.width * 0.25,
                child: OutlinedButton(
                  onPressed: widget.onPressed3 ??
                      () {
                        Get.log('---Cancelled---');
                        Get.back();
                      },
                  style: outlineButton(radius: 5),
                  child: TextWidget(
                    text: widget.button3,
                    alignment: Alignment.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
