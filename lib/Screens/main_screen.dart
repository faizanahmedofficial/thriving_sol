import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Screens/Authentications/login.dart';
import 'package:schedular_project/Screens/Home/home.dart';
import 'package:schedular_project/Services/auth_services.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Get.find<AuthServices>().isLogin ? const HomeScreen() : LoginScreen(),
    );
  }
}
