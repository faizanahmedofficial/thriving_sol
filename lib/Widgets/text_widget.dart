import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/colors.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.text,
    this.size = 14,
    this.font = 'Arial',
    this.weight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.fontStyle = FontStyle.normal,
    this.alignment = Alignment.topLeft,
    this.color = AppColors.black,
    this.maxline,
    this.overflow,
  }) : super(key: key);
  final String font;
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final TextAlign textAlign;
  final Alignment alignment;
  final FontStyle fontStyle;
  final int? maxline;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxline,
        overflow: overflow,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: font,
          fontWeight: weight,
          fontStyle: fontStyle,
        ),
      ),
    );
  }
}

///
Padding expansionText({double padding = 8.0, required String text}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextWidget(text: text),
  );
}

TextWidget headline(String text) {
  return TextWidget(
    text: text,
    size: 18,
    weight: FontWeight.bold,
    alignment: Alignment.center,
    textAlign: TextAlign.center,
  );
}

TextWidget headline1(String text) {
  return TextWidget(
    text: text,
    size: 18,
    weight: FontWeight.bold,
  );
}

Widget elementTitle(String name, {Widget? icon}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      (icon ?? const Icon(Icons.description_outlined)).marginOnly(right: 15),
      TextWidget(text: name, weight: FontWeight.bold, maxline: 1),
    ],
  );
}

Widget elementTitle2(String name, {Widget? icon}) {
  return Row(
    // mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      (icon ?? const Icon(Icons.description_outlined)).marginOnly(right: 15),
      Expanded(
          child: TextWidget(text: name, weight: FontWeight.bold, maxline: 1)),
    ],
  );
}

Widget titles(
  String text, {
  Alignment alignment = Alignment.centerLeft,
  TextAlign textAlign = TextAlign.left,
}) {
  return TextWidget(
    text: text,
    size: 16,
    weight: FontWeight.bold,
    alignment: alignment,
    textAlign: textAlign,
  );
}

TextWidget title2(
  String text, {
  Alignment alignment = Alignment.center,
}) {
  return TextWidget(
    text: text,
    weight: FontWeight.bold,
    alignment: alignment,
  );
}

TextWidget subtitle(String text) {
  return TextWidget(
    text: text,
    alignment: Alignment.center,
    fontStyle: FontStyle.italic,
    textAlign: TextAlign.center,
    size: 13,
    color: Colors.black54,
  );
}
