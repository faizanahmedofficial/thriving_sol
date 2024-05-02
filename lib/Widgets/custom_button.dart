// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:schedular_project/Theme/buttons_theme.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

import '../Constants/constants.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({ Key? key,required  this.text, this.ontap }) : super(key: key);
  final String text;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ontap ?? (){},
      child: TextWidget(text: text),
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key, this.play}) : super(key: key);
  final VoidCallback? play;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: play ?? () {},
      icon: const Icon(Icons.play_arrow),
      iconSize: 70,
      padding: EdgeInsets.zero,
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    this.background,
    this.onPressed,
    this.border,
    this.bheight,
    this.bwidth,
    this.radius,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final Color? background, border;
  final double? bwidth, bheight, radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: bwidth ?? width,
      height: bheight ?? 50,
      child: ElevatedButton(
        onPressed: onPressed ?? () {},
        style: elevatedButton(
          primary: background ?? const Color(0xff9F9F9F),
          borderColor: background ?? const Color(0xff797979),
          radius: radius ?? 5,
        ),
        child: TextWidget(
          text: text,
          color: Colors.white,
          weight: FontWeight.bold,
          size: 16,
          alignment: Alignment.center,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class CustomIconTextButton extends StatelessWidget {
  const CustomIconTextButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.icon,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed ?? () {},
      label: TextWidget(text: text, size: 12),
      icon: icon ?? const Icon(Icons.add, color: Colors.black),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    Key? key,
    required this.title,
    this.ontap,
    this.weight,
    this.size = 14,
    this.height,
  }) : super(key: key);
  final String title;
  final VoidCallback? ontap;
  final FontWeight? weight;
  final double size;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap ?? () {},
      child: Container(
        width: width,
        height: height ?? 80,
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 15,
          bottom: 15,
        ),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(7),
        ),
        child: TextWidget(
          text: title,
          size: size,
          alignment: Alignment.center,
          textAlign: TextAlign.center,
          weight: weight ?? FontWeight.normal,
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.title,
    required this.description,
    this.onTap,
  }) : super(key: key);
  final String title, description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: Column(
          children: [
            Container(
              width: width,
              height: 50,
              margin: const EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 5,
                bottom: 5,
              ),
              decoration: BoxDecoration(border: Border.all()),
              child: TextWidget(
                text: title,
                alignment: Alignment.center,
                weight: FontWeight.bold,
                size: 16,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5),
              child: TextWidget(
                text: description,
                alignment: Alignment.center,
                textAlign: TextAlign.center,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomRadioButton extends StatefulWidget {
  CustomRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onChanged,
    this.fontSize = 14,
    this.width = 150,
    this.alignment = Alignment.topLeft,
    this.textAlignment = Alignment.centerLeft,
  }) : super(key: key);
  int value;
  int groupValue;
  var onChanged;
  String title;
  double fontSize, width;
  Alignment alignment;
  Alignment textAlignment;

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: SizedBox(
        width: widget.width,
        child: ListTile(
          horizontalTitleGap: 0,
          contentPadding: const EdgeInsets.all(0),
          leading: Radio<int>(
            value: widget.value,
            groupValue: widget.groupValue,
            onChanged: widget.onChanged,
          ),
          title: TextWidget(
            text: widget.title,
            size: widget.fontSize,
            alignment: widget.textAlignment,
          ),
        ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.text,
    this.background,
    this.onPressed,
    this.border,
    this.bheight,
    this.bwidth,
    this.radius,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final Color? background, border;
  final double? bwidth, bheight, radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: bwidth ?? width,
      height: bheight ?? 50,
      child: OutlinedButton(
        onPressed: onPressed ?? () {},
        style: outlineButton(
          primary: background ?? const Color(0xff9F9F9F),
          borderColor: background ?? const Color(0xff797979),
          radius: radius ?? 5,
        ),
        child: TextWidget(
          text: text,
          
          // weight: FontWeight.bold,
          // size: 16,
          alignment: Alignment.center,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}