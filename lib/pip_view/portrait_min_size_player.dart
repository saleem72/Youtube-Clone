//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone/helpers/styling/pallet.dart';
import 'package:youtube_clone/models/video.dart';
import 'package:youtube_clone/pip_view/selected_video_cubit/selected_video_cubit.dart';

import 'my_player/my_player.dart';

class PortraitMinSizePlayer extends StatelessWidget {
  const PortraitMinSizePlayer({
    Key? key,
    required this.video,
    this.videoController,
  }) : super(key: key);
  final Video video;
  final VideoPlayerController? videoController;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallet.bodyColor,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: (videoController != null &&
                      videoController!.value.isInitialized)
                  ? MyPlayer(controller: videoController!)
                  : Stack(
                      children: [
                        Image.network(
                          video.backdropPath,
                          fit: BoxFit.cover,
                        ),
                        const Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(video.title),
                        const SizedBox(height: 8),
                        const Text('BBC Earth'),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: VerticalDivider(
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.play_arrow),
                      ),
                      IconButton(
                        onPressed: () =>
                            context.read<SelectedVideoCubit>().unSelect(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
