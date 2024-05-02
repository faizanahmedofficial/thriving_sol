import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/spacer_widgets.dart';

import '../Constants/constants.dart';

class PlayScript extends StatefulWidget {
  const PlayScript({Key? key}) : super(key: key);

  @override
  State<PlayScript> createState() => _PlayScriptState();
}

class _PlayScriptState extends State<PlayScript> {
  final PlayScriptController controller = Get.put(PlayScriptController());
  final RxInt volum = 0.obs;

  @override
  Widget build(BuildContext context) {
    debugPrint(controller.link.value);
    return Scaffold(
      appBar: customAppbar(
        implyLeading: true,
        leading: const BackButton(),
        titleAlignment: Alignment.centerLeft,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpace(height: 50),
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(150),
              ),
              child: const CircleAvatar(
                radius: 120,
                backgroundImage: AssetImage('assets/images/playstore.png'),
              ),
            ),
            verticalSpace(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.volume_up_rounded),
                StreamBuilder<double>(
                  stream: controller.audioPlayer.volumeStream,
                  builder: (context, snapshot) => SizedBox(
                    width: width * 0.7,
                    child: Slider(
                      min: 0.0,
                      max: 1.0,
                      divisions: 10,
                      value: controller.audioPlayer.volume,
                      onChanged: (val) {
                        setState(() {
                          controller.audioPlayer.setVolume(val);
                        });
                      },
                      inactiveColor: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              iconSize: 40,
              onPressed: () {
                controller.audioPlayer.playing
                    ? controller.pauseaudio()
                    : controller.playaudio();
                setState(() {});
              },
              icon: Icon(
                controller.audioPlayer.playing
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayScriptController extends GetxController {
  final RxString link = ''.obs;
  AudioPlayer audioPlayer = AudioPlayer();
  RxInt result = 0.obs;

  @override
  void onInit() async {
    // link.value = 'https://firebasestorage.googleapis.com/v0/b/flutteraudiobook.appspot.com/o/1948%2FChapters%2Ffile_example_MP3_5MG.mp3?alt=media&token=549bb966-a66b-4dec-bdf7-e27e398ebb83';
    link.value = Get.arguments[0];
    audioPlayer.setUrl(link.value);
    super.onInit();
  }

  Future playaudio() async {
    try {
      await audioPlayer.play();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future pauseaudio() async => await audioPlayer.pause();

  Future stopaudio() async => await audioPlayer.stop();

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
