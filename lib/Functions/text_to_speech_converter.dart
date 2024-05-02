// ignore_for_file: prefer_typing_uninitialized_variables, void_checks, avoid_print, unnecessary_null_comparison

import 'dart:async';
import 'dart:io';
import 'package:flutter_azure_tts/flutter_azure_tts.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:schedular_project/Controller/user_controller.dart';
import 'package:schedular_project/Widgets/custom_toast.dart';
import 'package:schedular_project/Widgets/play_generated_script.dart';

import '../Widgets/dialogs.dart';

Future<bool> convertToAudio(
  String text, {
  required String filename,
  required String firebasepath,
  bool loader = false,
  bool option = false,
}) async {
  try {
    final voicesResponse = await AzureTts.getAvailableVoices() as VoicesSuccess;
    // print(voicesResponse);
    ///Pick a Neural voice
    final voice = voicesResponse.voices
        .where((element) =>
            element.voiceType == "Neural" && element.locale.startsWith("en-"))
        .toList(growable: false)[0];

    ///List all available voices
    // print("${voicesResponse.voices}");
    TtsParams params = TtsParams(
      voice: voice,
      audioFormat: AudioOutputFormat.audio16khz32kBitrateMonoMp3,
      rate: 1.0, // optional prosody rate (default is 1.0)
      text: text,
    );
    final ttsResponse = await AzureTts.getTts(params) as AudioSuccess;
    // print(ttsResponse);
    ///Get the audio bytes.
    print("${ttsResponse.audio}");
    late var dir;
    if (Platform.isIOS) {
      dir = await getDownloadsDirectory();
    } else {
      dir = await getTemporaryDirectory();
    }
    final soundFile = File("${dir.path}/$filename.mp3");
    await soundFile.writeAsBytes(ttsResponse.audio).then((value) async {
      print(value.path);
      await FirebaseStorage.instance
          .ref()
          .child('$firebasepath/$filename.mp3')
          .putFile(value)
          .then((p0) async {
        if (p0 != null) {
          _app.link.value = await p0.ref.getDownloadURL();
          _app.file.value = value.path;
          print('Url: ${_app.link.value}');
          if (loader) Get.back();
          if (option) {
            scriptdialog(
              Get.context!,
              value.path,
              filename,
              loading: false.obs,
              download: () async {
                final params = SaveFileDialogParams(sourceFilePath: value.path);
                await FlutterFileDialog.saveFile(params: params);
              },
              play: () {
                Get.to(() => const PlayScript(), arguments: [_app.link.value]);
              },
            );
          }
          return true;
        }
      });
      // final params = SaveFileDialogParams(sourceFilePath: value.path);
      // await FlutterFileDialog.saveFile(params: params);
    });
    return true;
  } catch (e) {
    if (loader) Get.back();
    print(e);
    customToast(message: 'Please try again later');
    return false;
  }
}

final UserController _app = Get.find();
