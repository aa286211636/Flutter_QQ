import 'package:flutter/material.dart';
import 'package:metashare_flutter/video/chewie_ex/custom_controls.dart';
import 'package:video_player/video_player.dart';

import 'chewie_custom/src/chewie_player.dart';

class ChewieVideoWidget extends StatefulWidget {
  final String playUrl;

  ChewieVideoWidget(this.playUrl);
  @override
  _ChewieVideoWidgetState createState() => _ChewieVideoWidgetState();
}

class _ChewieVideoWidgetState extends State<ChewieVideoWidget> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.playUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      aspectRatio: 3 / 2.0,
     //customControls: CustomControls(),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
