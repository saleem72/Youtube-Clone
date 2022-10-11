//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../helpers/styling/styling.dart';
import '../models/video.dart';
import 'portrait_max_size_player.dart';
import 'portrait_min_size_player.dart';
import 'selected_video_cubit/selected_video_cubit.dart';

class PortriatPlayer extends StatefulWidget {
  const PortriatPlayer({
    Key? key,
    required this.video,
    required this.maximumHeight,
    required this.minimalHeight,
    required this.onMaximize,
    this.videoController,
  }) : super(key: key);

  final Video video;
  final double minimalHeight;
  final double maximumHeight;
  final VoidCallback onMaximize;
  final VideoPlayerController? videoController;
  @override
  State<PortriatPlayer> createState() => _PortriatPlayerState();
}

class _PortriatPlayerState extends State<PortriatPlayer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late CurvedAnimation _curved;
  late Animation<double> _sizeAnimation;

  bool isFullScreen = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..addListener(() {
        if (_sizeAnimation.value > widget.minimalHeight + 300) {
          _updateScreenStatus(true);
        } else {
          _updateScreenStatus(false);
        }
      });

    _curved =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    _sizeAnimation =
        Tween(begin: widget.maximumHeight, end: widget.minimalHeight)
            .animate(_curved);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _maximizePlayer() {
    if (!isFullScreen) {
      setState(() {
        // isFullScreen = true;
        _animationController.reverse();
      });
    }
  }

  void _minimizePlayer() {
    if (isFullScreen) {
      setState(() {
        _animationController.forward();
      });
    }
  }

  void _updateScreenStatus(bool value) {
    setState(() {
      isFullScreen = value;
    });
  }

  void _changeVideo(Video? state) {
    if (state != null && !isFullScreen) {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _maximizePlayer,
      child: BlocListener<SelectedVideoCubit, SelectedVideoState>(
        listener: ((context, state) => _changeVideo(state.video)),
        child: AnimatedBuilder(
          animation: _curved,
          builder: (context, child) {
            return Container(
              height: _sizeAnimation.value,
              width: double.maxFinite,
              margin: EdgeInsets.only(bottom: _curved.value * 90),
              color: Pallet.bodyColor,
              child: child,
            );
          },
          child: _content(context, widget.video),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, Video video) {
    if (isFullScreen) {
      return _fullPlayer(context, video);
    } else {
      return _miniplayer(context, video);
    }
  }

  Widget _fullPlayer(BuildContext context, Video video) =>
      PortraitMaxSizePlayer(
        video: video,
        videoController: widget.videoController,
        onMinimize: () {
          _minimizePlayer();
        },
        onMaximize: () {
          widget.onMaximize.call();
        },
      );

  Widget _miniplayer(BuildContext context, Video video) =>
      PortraitMinSizePlayer(
        video: video,
        videoController: widget.videoController,
      );
}
