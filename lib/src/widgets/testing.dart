import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilminneed/src/ui_helper/colors.dart';

class AutoFullscreenOrientationPage extends StatefulWidget {
  final String video_url;

  const AutoFullscreenOrientationPage({Key key, this.video_url})
      : super(key: key);

  @override
  _AutoFullscreenOrientationPageState createState() =>
      _AutoFullscreenOrientationPageState();
}

class _AutoFullscreenOrientationPageState
    extends State<AutoFullscreenOrientationPage> {
  BetterPlayerController _betterPlayerController;
  String url;

  @override
  void initState() {
    url = widget.video_url.toString();
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
            autoDispose: true,
            fullScreenByDefault: false,
            controlsConfiguration: BetterPlayerControlsConfiguration(
              enableSubtitles: false,
              enableAudioTracks: false,
              enableQualities: false,
              //skipBackIcon: Icons.refresh,
              //skipForwardIcon: Icons.refresh_sharp
            ),
            aspectRatio: 16 / 9,
            fit: BoxFit.contain,
            autoDetectFullscreenDeviceOrientation: true);
    BetterPlayerDataSource dataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, url);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, color: konLightColor1)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Align(
              child: AspectRatio(
                aspectRatio: 2 / 1,
                child: BetterPlayer(controller: _betterPlayerController),
              ),
            ),
          )
        ],
      ),
    );
  }
}
