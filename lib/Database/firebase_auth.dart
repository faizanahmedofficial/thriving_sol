// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Controller/user_controller.dart';
import 'package:schedular_project/Global/firebase_collections.dart';
import 'package:schedular_project/Global/global.dart';
import 'package:schedular_project/Screens/main_screen.dart';
import 'package:schedular_project/Widgets/custom_snackbar.dart';
import 'package:schedular_project/Widgets/loading_dialog.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:schedular_project/Model/app_user.dart';
import 'package:schedular_project/Screens/Authentications/reset_confirm.dart';

import '../Constants/constants.dart';

Future<bool> resetPassword(
  BuildContext context,
  bool isLoading, {
  required String email,
}) async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    // final MyAppController _app = Get.find();

    if (isLoading) {
      loadingDialog(context, text: 'Generating Link. Please wait');
    }

    /// reset password link
    await auth.sendPasswordResetEmail(email: email).then((value) {
      print('send');
      isLoading = false;
      Get.to(() => ResetConfirm(), arguments: [email]);
      isLoading = false;
      return true;
    });
    isLoading = false;
    return true;
  } catch (e) {
    isLoading = false;
    print('Reset Password Exception: $e');
    Exception(e);
    customSnackbar(
      title: 'Something went wrong',
      message: 'Please check your internet connection and try again later.',
    );
    return false;
  }
}

Future<bool> userLogin(
  BuildContext context,
  bool loading, {
  required String email,
  required String password,
}) async {
  try {
    final UserController app = Get.find();

    /// loading dialog
    if (loading) loadingDialog(context, text: 'Please wait');

    /// device token
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);

    /// user login
    var authUser =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    if (authUser.user != null) {
      app.isUserLoggedIn.value = true;
      app.userid.value = authUser.user!.uid;

      /// user data
      usersRef.doc(app.userid.value).get().then(
        (DocumentSnapshot snapshot) async {
          /// user data
          app.user.value = AppUser.fromMap(snapshot.data());
          app.userid.value = app.user.value.id!;
          await app.fetchSettings(app.user.value.id!);
          await app.fetchUserReadings(app.user.value.id!);
          await app.fetchTodays(app.user.value.id!);
          await app.fetchAccomplishments(app.user.value.id!);

          /// device token
          if (snapshot['deviceToken'] != token) {
            /// onrefresh
            FirebaseMessaging.instance.onTokenRefresh.listen(
              (event) {
                usersRef.doc(app.userid.value).set({
                  'deviceToken': token,
                  'updated': DateTime.now(),
                }, SetOptions(merge: true));
              },
            );
            app.user.value.deviceToken = token!;
          } else if (snapshot['deviceToken'] == '') {
            /// if empty
            usersRef.doc(app.userid.value).set({
              'deviceToken': token,
              'updated': DateTime.now(),
            }, SetOptions(merge: true));
            app.user.value.deviceToken = token!;
          } else {
            app.user.value.deviceToken = snapshot['deviceToken'];
          }

          await app.setPreferences();
          Get.log('--- Preferences Saved ---');
          Get.back();
          loading = false;
          Get.offAll(() => const MainScreen());
          return true;
        },
      );
      Get.back();
      loading = false;
      return true;
    } else {
      Get.back();
      customSnackbar(
        title: 'Something went wrong',
        message: 'Please check your internet connection and try again later',
      );
      return false;
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      loading = false;
      Get.back();
      customSnackbar(
        title: "Incorrect Email",
        message:
            "We are sorry to inform you that there is no user registered under this email.\nPlease try to login using another email.",
      );

      return false;
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      loading = false;
      Get.back();
      customSnackbar(
        title: "Incorrect Password",
        message:
            "The password you have entered is incorrect.\nPleases try again with another password.\nIf you have forget your password then try resetting it.",
      );

      return false;
    }
    Get.back();
    loading = false;
    return false;
  } catch (e) {
    Get.back();
    loading = false;
    print('Login Exception: $e');
    Exception(e);
    customSnackbar(
      title: 'Something went wrong',
      message: 'Please check your internet connection and try again later',
    );
    return false;
  }
}

Future<bool> userSignup(
  BuildContext context,
  bool loading, {
  required String email,
  required String password,
  required String name,
}) async {
  try {
    final UserController app = Get.find();
    if (loading) loadingDialog(context, text: 'Please wait');
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
    final credentials = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = credentials.user!;
    if (user != null) {
      print("User Register");

      app.user.value.id = user.uid;
      app.user.value.name = name;
      app.user.value.email = email;
      app.user.value.password = password;
      app.user.value.deviceToken = token;
      app.userid.value = user.uid;
      app.isUserLoggedIn.value = true;
      usersRef
          .doc(app.userid.value)
          .set(app.user.value.toMap())
          .then((value) async {
        print('added');
        // userReadings(_app.userid.value).set(_app.userreadings.value.toMap());
      });
      await userReadings(user.uid).get().then((value) {
        if (value.data() == null) {
          userReadings(user.uid).set({
            'intro': {'value': 0, 'element': 0, 'id': intro},
            'breathing': {'value': 1, 'element': 7, 'id': breathing},
            'visualization': {'value': 2, 'element': 19, 'id': visualization},
            'mindfulness': {'value': 3, 'element': 35, 'id': mindfulness},
            'emotional regulation': {'value': 4, 'element': 67, 'id': er},
            'connection': {'value': 5, 'element': 94, 'id': connection},
            'gratitude': {'value': 6, 'element': 60, 'id': gratitude},
            'goals': {'value': 7, 'element': 102, 'id': goals},
            'productivity': {'value': 8, 'element': 0, 'id': 'productivity'},
            'behavioral design': {'value': 9, 'element': 116, 'id': bd},
            'movement': {'value': 10, 'element': 148, 'id': movement},
            'eating': {'value': 11, 'element': 143, 'id': 'eating'},
            'cold': {'value': 12, 'element': 134, 'id': cold},
            'reading': {'value': 13, 'element': 65, 'id': reading},
            'sexual': {'value': 14, 'element': 139, 'id': sexual},
          });
        }
      });
      await app.fetchSettings(app.user.value.id!);
      await app.fetchUserReadings(app.user.value.id!);
      await app.fetchTodays(app.user.value.id!);
      await app.fetchAccomplishments(app.user.value.id!);

      /// set prefernces
      await app.setPreferences();
      loading = false;
      Get.back();
      Get.offAll(() => const MainScreen());
      return true;
    } else {
      Get.back();
      loading = false;
      customSnackbar(
        title: "Something went wrong",
        message: "Please check your internet connection and try again later.",
      );
      return false;
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      print("A user already exists for this email.");
      loading = false;
      Get.back();
      customSnackbar(
        title: "User Already Exists!",
        message:
            "Looks like you already has a account.\nTry sigining in to your account instead of creating a new account.",
      );

      return false;
    }
    loading = false;
    return false;
  } catch (e) {
    loading = false;
    print('Sign up error: $e');
    Exception(e);
    Get.back();
    customSnackbar(
      title: "Something went wrong",
      message: "Please check your internet connection and try again later.",
    );
    return false;
  }
}
