import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:schedular_project/Model/app_modal.dart';
import 'package:schedular_project/Screens/custom_bottom.dart';
import 'package:schedular_project/Screens/seek_bar.dart';
import 'package:schedular_project/Widgets/app_bar.dart';
import 'package:schedular_project/Widgets/text_widget.dart';

class ListenAudios extends StatefulWidget {
  const ListenAudios({
    Key? key,
    required this.category,
    required this.entity,
    this.onfinished,
    this.connectedReading,
  }) : super(key: key);
  final String category;
  final AppModel entity;
  final VoidCallback? onfinished, connectedReading;

  @override
  State<ListenAudios> createState() => _ListenAudiosState();
}

class _ListenAudiosState extends State<ListenAudios> {
  final AudioPlayer player = AudioPlayer();

  setUrl() async {
    if (widget.entity.description.contains('https:')) {
      await player.setUrl(widget.entity.description);
    } else {
      await player.setAsset(widget.entity.description);
    }
  }

  @override
  void initState() {
    setUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        child: Column(
          children: [
            ListeningTitle(
              title: widget.category,
              ontap: widget.connectedReading,
            ).marginOnly(bottom: 10),
            title2(widget.entity.title).marginOnly(bottom: 30),
            AudioProgressBar(player: player, title: widget.category)
                .marginOnly(bottom: 30),
            CustomBottom(
              start: widget.category,
              player: player,
              playing: player.playing,
              onfinished: widget.onfinished,
              onVolumeChanged: (val) {
                setState(() {
                  player.setVolume(val);
                });
              },
              onstart: () async {
                if (player.playing) {
                  player.pause();
                } else {
                  player.play();
                }
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
