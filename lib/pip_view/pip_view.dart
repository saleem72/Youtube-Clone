//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone/pip_view/landscape_full_size_player.dart';
import 'package:youtube_clone/pip_view/portrait_player.dart';

import '../models/video.dart';
import 'selected_video_cubit/selected_video_cubit.dart';

const String imageTag = 'pip_view_video_image';

class PipView extends StatefulWidget {
  const PipView({
    Key? key,
    required this.maximumHeight,
    this.minimalHeight = 80,
  }) : super(key: key);
  final double minimalHeight;
  final double maximumHeight;
  @override
  State<PipView> createState() => _PipViewState();
}

class _PipViewState extends State<PipView> with TickerProviderStateMixin {
  Video? video;
  bool isFullScreen = false;

  late NativeDeviceOrientationCommunicator communicator;
  late Stream<NativeDeviceOrientation> stream;
  VideoPlayerController? _videoPlayerController;

  void _changeVideo(SelectedVideoState state) {
    setState(() {
      video = state.video;
      _initVideoPlayer();
    });
  }

  @override
  void initState() {
    super.initState();
    _allowAllOrientations();
    _initStream();
    // _initVideoPlayer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('pip view dependancy');
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> _initVideoPlayer() async {
    if (video?.path != null) {
      print(video!.path);
      // const newPath =
      // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
      _videoPlayerController = VideoPlayerController.network(video!.path)
        ..addListener(() {
          setState(() {});
        });
// VideoPlayerController.initialize() exoplayer2.ExoPlaybackException: Source error, null, null)
      // await _videoPlayerController?.initialize();
      // await _videoPlayerController?.play();
      _videoPlayerController?.initialize().then((value) {
        _videoPlayerController?.play();
        setState(() {});
      });
      // _videoPlayerController?.play();

    }
  }

  Future<void> _initStream() async {
    communicator = NativeDeviceOrientationCommunicator();
    await communicator.resume();

    stream = communicator.onOrientationChanged(
      useSensor: true,
      defaultOrientation: NativeDeviceOrientation.portraitUp,
    )..listen((event) async {
        if (isFullScreen) {
          await _allowAllOrientations();
        }
        if (event != NativeDeviceOrientation.landscapeLeft &&
            event != NativeDeviceOrientation.landscapeRight) {
          setState(() {
            isFullScreen = false;
          });
        }
      });
  }

  Future<void> _allowAllOrientations() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  Future<void> _setPortraitMode() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  Future<void> _setLandscapeMode() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void _applyLandScapeMode() async {
    await _setLandscapeMode();
    setState(() {
      isFullScreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return BlocListener<SelectedVideoCubit, SelectedVideoState>(
      listener: (context, state) => _changeVideo(state),
      child: video != null ? _buildPlayer(orientation) : Container(),
    );
  }

  Widget _buildPlayer(Orientation orientation) {
    return orientation == Orientation.portrait
        ? PortriatPlayer(
            video: video!,
            videoController: _videoPlayerController,
            maximumHeight: widget.maximumHeight,
            minimalHeight: widget.minimalHeight,
            onMaximize: () => _applyLandScapeMode(),
          )
        : LandscapeFullSizePlayer(
            video: video!,
            videoController: _videoPlayerController,
          );
  }
}
