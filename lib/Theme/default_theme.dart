// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:schedular_project/Constants/colors.dart';

var defaultTheme = ThemeData(
  fontFamily: 'Arial',
  brightness: Brightness.light,
  primaryColor: Colors.black,
  accentColor: Colors.black,
  visualDensity: VisualDensity.comfortable,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    textTheme: TextTheme(button: TextStyle(color: Colors.white)),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    elevation: 2.0,
  ),
  primaryIconTheme: const IconThemeData(color: Colors.black),
  primaryTextTheme: const TextTheme(caption: TextStyle(color: Colors.black)),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
  // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
  iconTheme: const IconThemeData(color: AppColors.black),
   
);

var darkTheme = ThemeData(
  fontFamily: 'Arial',
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  accentColor: Colors.black,
  visualDensity: VisualDensity.comfortable,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    textTheme: TextTheme(button: TextStyle(color: Colors.black)),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    foregroundColor: Colors.black,
    elevation: 2.0,
  ),
  primaryIconTheme: const IconThemeData(color: Colors.black),
  primaryTextTheme: const TextTheme(caption: TextStyle(color: Colors.black)),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
  // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
);
