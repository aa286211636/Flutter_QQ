import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'chewie_custom/src/chewie_player.dart';
import 'chewie_ex/custom_controls.dart';
import 'chewie_ex/custom_player_with_controls.dart';

final GlobalKey<_ChewieVideoCustomState> videoWidgetKey =
    new GlobalKey<_ChewieVideoCustomState>();

class ChewieVideoCustom extends StatefulWidget {
  String playUrl;

  ChewieVideoCustom(this.playUrl);

  @override
  _ChewieVideoCustomState createState() => _ChewieVideoCustomState();
}

class _ChewieVideoCustomState extends State<ChewieVideoCustom> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  void pauseVideo() {
    _chewieController?.pause();
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    _chewieController = null;
    _videoPlayerController = null;
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.playUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoInitialize: true,
      autoPlay: false,
      showControls: true,
      customControls: CustomControls(),
      placeholder: new Container(
        color: Colors.black,
      ),
    );
  }

  @override
  void dispose() {
    _chewieController?.pause();
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
      child: CustomPlayerWithControls(),
    );
  }
}
