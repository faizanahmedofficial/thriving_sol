// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Constants/colors.dart';

Widget progressIndicator() {
  return const Center(
    child: CircularProgressIndicator(
      backgroundColor: AppColors.black,
      valueColor: AlwaysStoppedAnimation(AppColors.white),
    ),
  );
}

class CircularLoadingWidget extends StatefulWidget {
  final double height;
  final ValueChanged<void>? onComplete;
  final String onCompleteText;

  const CircularLoadingWidget(
      {Key? key,
      required this.height,
      this.onComplete,
      required this.onCompleteText})
      : super(key: key);

  @override
  _CircularLoadingWidgetState createState() => _CircularLoadingWidgetState();
}

class _CircularLoadingWidgetState extends State<CircularLoadingWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation = Tween<double>(begin: widget.height, end: 0).animate(curve)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    Timer(const Duration(seconds: 10), () {
      if (mounted) {
        animationController.forward();
      }
      // ignore: unnecessary_statements
      widget.onComplete;
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return animationController.isCompleted
        ? SizedBox(
            height: widget.height,
            child: Center(
              child: Text(widget.onCompleteText,
                  style: Get.textTheme.caption!.merge(const TextStyle(fontSize: 14))),
            ),
          )
        : Opacity(
            opacity: animation.value / 100 > 1.0 ? 1.0 : animation.value / 100,
            child: SizedBox(
              height: animation.value,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
  }
}
