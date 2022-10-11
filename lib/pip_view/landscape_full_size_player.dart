//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone/models/video.dart';

import 'my_player/my_player.dart';

class LandscapeFullSizePlayer extends StatefulWidget {
  const LandscapeFullSizePlayer({
    Key? key,
    required this.video,
    this.videoController,
  }) : super(key: key);
  final Video video;
  final VideoPlayerController? videoController;
  @override
  State<LandscapeFullSizePlayer> createState() =>
      _LandscapeFullSizePlayerState();
}

class _LandscapeFullSizePlayerState extends State<LandscapeFullSizePlayer> {
  @override
  void initState() {
    super.initState();
    _showStatusBar();
  }

  @override
  void dispose() {
    _hideStatusBar();
    super.dispose();
  }

  Future<void> _hideStatusBar() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ],
    );
  }

  void _showStatusBar() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        (widget.videoController != null &&
                widget.videoController!.value.isInitialized)
            ? MyPlayer(controller: widget.videoController!)
            : Stack(
                fit: StackFit.expand,
                children: [
                  Expanded(
                    child: Image.network(
                      widget.video.backdropPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              )
      ],
    );
  }
}
