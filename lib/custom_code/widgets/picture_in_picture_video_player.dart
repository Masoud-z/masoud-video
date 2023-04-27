// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:floating/floating.dart';

import 'package:video_player/video_player.dart';

class PictureInPictureVideoPlayer extends StatefulWidget {
  const PictureInPictureVideoPlayer({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _PictureInPictureVideoPlayerState createState() =>
      _PictureInPictureVideoPlayerState();
}

class _PictureInPictureVideoPlayerState
    extends State<PictureInPictureVideoPlayer> {
  late Floating floating;
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    floating = Floating();
    _controller = VideoPlayerController.network(
        'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
  }

  Widget justVideo() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: VideoPlayer(_controller),
    );
  }

  @override
  void dispose() {
    floating.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PiPSwitcher(
      childWhenEnabled: justVideo(),
      childWhenDisabled: Scaffold(
        appBar: AppBar(title: const Text('just a PiP test')),
        body: Center(
          child: justVideo(),
        ),
        floatingActionButton: PiPSwitcher(
          childWhenEnabled: justVideo(),
          childWhenDisabled: FloatingActionButton(
            onPressed: () async {
              await floating.enable();
            },
          ),
        ),
      ),
    );
  }
}
