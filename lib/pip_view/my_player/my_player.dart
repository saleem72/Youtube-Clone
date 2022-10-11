//

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyPlayer extends StatefulWidget {
  const MyPlayer({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final VideoPlayerController controller;

  @override
  State<MyPlayer> createState() => _MyPlayerState();
}

class _MyPlayerState extends State<MyPlayer> {
  VideoPlayerValue? _latestValue;
  bool _showControls = false;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_videoListner);
  }

  @override
  void dispose() {
    // widget.controller.dispose();
    widget.controller.removeListener(_videoListner);
    super.dispose();
  }

  void _videoListner() {
    setState(() {
      _latestValue = widget.controller.value;
    });
  }

  void _initController() async {
    // await widget.controller.initialize();
    // widget.controller.play();
  }

  bool get isBuffering =>
      _latestValue != null && (_latestValue?.isBuffering ?? false);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ClipRect(
      child: Container(
        width: size.width,
        height: size.width * 9 / 16,
        color: Colors.red,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                debugPrint('Main Gesture: $_showControls');
                setState(() {
                  _showControls = !_showControls;
                });
              },
              child: VideoPlayer(widget.controller),
            ),
            _showControls
                ? _PlayerControls(
                    controller: widget.controller,
                    onHideControls: () {
                      setState(() {
                        _showControls = !_showControls;
                      });
                    },
                  )
                : const SizedBox.shrink(),
            isBuffering
                ? Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _PlayerControls extends StatefulWidget {
  const _PlayerControls({
    Key? key,
    required this.controller,
    required this.onHideControls,
  }) : super(key: key);
  final VideoPlayerController controller;
  final VoidCallback onHideControls;
  @override
  State<_PlayerControls> createState() => __PlayerControlsState();
}

class __PlayerControlsState extends State<_PlayerControls>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late CurvedAnimation _curve;
  late Animation<Offset> _upperPositionAnimation;
  late Animation<Offset> _lowerPositionAnimation;
  late Timer timer;

  double _sliderValue = 0;
  String _positionText = '00:00';
  String _durationText = '00:00';
  bool _sliderMoving = false;

  void videoListener() {
    if (!_sliderMoving) {
      setState(() {
        double temp = widget.controller.value.position.inSeconds /
            widget.controller.value.duration.inSeconds;
        (temp > 0 && temp <= 1) ? _sliderValue = temp : 0;
        _positionText = widget.controller.value.position.readable;
        _durationText = widget.controller.value.duration.readable;
      });
    }
  }

  Duration _durationForValue(double value) {
    final seconds = widget.controller.value.duration.inSeconds * value;
    final target = Duration(seconds: seconds.round());
    return target;
  }

  Future<dynamic> _seek(double value) async {
    final target = _durationForValue(value);
    await widget.controller.seekTo(target);
    return dynamic;
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(videoListener);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..addStatusListener((status) {
        debugPrint('status: ${status.toString()}');
        if (status == AnimationStatus.dismissed) {
          debugPrint('reverse has done');
          widget.onHideControls.call();
        }
      });

    _curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _upperPositionAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(_curve);

    _lowerPositionAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(_animationController);
    _animationController.forward();

    timer = _resetTimer();
  }

  void _timerDone() {
    _animationController.reverse();
  }

  Timer _resetTimer() {
    return Timer(const Duration(seconds: 5), _timerDone);
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.controller.removeListener(videoListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        timer = _resetTimer();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SlideTransition(
              position: _upperPositionAnimation,
              child: _topBar(),
            ),
            FadeTransition(
              opacity: _curve,
              child: _middelBar(),
            ),
            SlideTransition(
              position: _lowerPositionAnimation,
              child: _bottomBar(),
            ),
          ],
        ),
      ),
    );
  }

  Container _bottomBar() {
    return Container(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
      height: 56,
      child: Row(
        children: [
          Text(
            _positionText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Slider(
              value: _sliderValue,
              onChangeStart: (value) {
                _sliderMoving = true;
              },
              onChangeEnd: (value) async {
                await _seek(value);
                _sliderMoving = false;
              },
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                  _positionText = _durationForValue(value).readable;
                });
              },
            ),
          ),
          const SizedBox(width: 16),
          Text(
            _durationText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _middelBar() {
    return SizedBox(
      height: 44,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              widget.controller.value.isPlaying
                  ? widget.controller.pause()
                  : widget.controller.play();
            },
            icon: Icon(
              widget.controller.value.isPlaying
                  ? Icons.pause_circle
                  : Icons.play_arrow,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Container _topBar() {
    return Container(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}

extension on Duration {
  String get readable {
    return inHours > 0
        ? '${inHours.twoDigits}:${inMinutes.remainder(60).twoDigits}:${inSeconds.remainder(60).twoDigits}'
        : '${inMinutes.remainder(60).twoDigits}:${inSeconds.remainder(60).twoDigits}';
  }
}

extension on int {
  String get twoDigits => toString().padLeft(2, "0");
}
