//

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone/pip_view/my_player/my_player.dart';
import 'package:youtube_clone/pip_view/selected_video_cubit/selected_video_cubit.dart';

import '../helpers/styling/styling.dart';
import '../models/video.dart';
import 'video_action_button.dart';

class PortraitMaxSizePlayer extends StatefulWidget {
  const PortraitMaxSizePlayer({
    Key? key,
    required this.video,
    required this.onMinimize,
    required this.onMaximize,
    required this.videoController,
  }) : super(key: key);
  final Video video;
  final VideoPlayerController? videoController;
  final VoidCallback onMinimize;
  final VoidCallback onMaximize;

  @override
  State<PortraitMaxSizePlayer> createState() => _PortraitMaxSizePlayerState();
}

class _PortraitMaxSizePlayerState extends State<PortraitMaxSizePlayer> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        _videoImage(context, widget.video),
        Expanded(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(height: 8),
              ),
              SliverToBoxAdapter(
                child: _videoDetails(widget.video),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
              SliverToBoxAdapter(
                child: _videoActions(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 8),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    thickness: 1.5,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 8),
              ),
              SliverToBoxAdapter(
                child: _channelSection(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 8),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    thickness: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _channelSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _channelAvatar(),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'BBC Earth',
                  style: Topology.subTitle,
                ),
                Text(
                  '12.9 Subscripers',
                  style: Topology.caption,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Pallet.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Subscribe',
                style: Topology.body,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _channelAvatar() {
    return const CircleAvatar(
      radius: 20,
      foregroundImage: AssetImage(
        Assets.bbcEarth,
      ),
    );
  }

  Widget _videoActions() {
    return Row(
      children: [
        VideoActionButton(
          onTap: () {},
          icon: Assets.like,
          label: '20K',
        ),
        VideoActionButton(
          onTap: () {
            print('Dislike tapped');
          },
          icon: Assets.dislike,
          label: '879',
        ),
        VideoActionButton(
          onTap: () {},
          icon: Assets.liveChat,
          label: '20K',
        ),
        VideoActionButton(
          onTap: () {},
          icon: Assets.share,
          label: '20K',
        ),
        VideoActionButton(
          onTap: () {},
          icon: Assets.download,
          label: '20K',
        ),
        VideoActionButton(
          onTap: () {},
          icon: Assets.save,
          label: '20K',
        ),
      ],
    );
  }

  Widget _videoDetails(Video video) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _videoTitle(video)),
              IconButton(
                onPressed: () {},
                icon: Transform.rotate(
                  angle: math.pi / 2,
                  child: const Icon(Icons.chevron_right),
                ),
              ),
            ],
          ),
          _videoDateViewers(video),
        ],
      ),
    );
  }

  Widget _videoDateViewers(Video video) {
    const double gap = 8;
    return Row(
      children: [
        Text(
          video.timeAgo,
          style: Topology.caption,
        ),
        const SizedBox(width: gap),
        const Text(
          '.',
          style: Topology.caption,
        ),
        const SizedBox(width: gap),
        Text(
          '${video.voteCount.toString()} views',
          style: Topology.caption,
        ),
        const SizedBox(width: gap),
      ],
    );
  }

  Widget _videoTitle(Video video) {
    return Text(
      video.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Pallet.primaryTextColor,
      ),
    );
  }

  Widget _videoImage(BuildContext context, Video video) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: Pallet.bodyColor,
      width: size.width,
      height: (size.width * 9 / 16),
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          (widget.videoController != null &&
                  widget.videoController!.value.isInitialized)
              ? MyPlayer(controller: widget.videoController!)
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
          // Image.network(
          //   video.backdropPath,
          //   fit: BoxFit.cover,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => widget.onMinimize.call(),
                    icon: Image.asset(
                      Assets.minimize,
                      height: 20,
                      width: 20,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () => widget.onMaximize.call(),
                    icon: const Icon(Icons.fullscreen),
                  ),
                ],
              ),
              // Expanded(child: Container()),
              IconButton(
                onPressed: () => context.read<SelectedVideoCubit>().unSelect(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
