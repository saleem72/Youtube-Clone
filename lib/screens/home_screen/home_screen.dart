//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/helpers/exceptions/failure.dart';
import 'package:youtube_clone/models/video_model.dart';
import 'package:youtube_clone/extensions.dart';

import '../../helpers/styling/styling.dart';
import '../../models/video.dart';
import '../../pip_view/selected_video_cubit/selected_video_cubit.dart';
import '../../widgets/main_widgets.dart';
import 'home_bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // extendBodyBehindAppBar: true,
      extendBody: true,
      body: BlocProvider(
        create: (context) => HomeBloc()..add(FetchMoviesEvent()),
        child: const _HomeScreenContents(),
      ),
    );
  }
}

class _HomeScreenContents extends StatefulWidget {
  const _HomeScreenContents({Key? key}) : super(key: key);

  @override
  State<_HomeScreenContents> createState() => __HomeScreenContentsState();
}

class __HomeScreenContentsState extends State<_HomeScreenContents> {
  void _selectVideo(Video video) {
    debugPrint(video.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            NavBar(
              onCast: () {
                debugPrint('Cast tapped');
              },
              onSearch: _handleSearch,
              onNotifications: () {
                debugPrint('Notifications tapped');
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _content(state),
            ),
          ],
        );
      },
    );
  }

  Widget _loadingSpinner() {
    return Stack(
      children: [
        _emptyList(),
        Transform.translate(
          offset: const Offset(0, -60),
          child: const Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _content(HomeState state) {
    if (state is HomeInitial) {
      return _emptyList();
    }
    if (state is HomeLoadingState) {
      return _loadingSpinner();
    }
    if (state is HomeSuccessState) {
      return _movies(state);
    }
    if (state is HomeFailureState) {
      return _error(state);
    }
    return Container();
  }

  Widget _emptyList() {
    return Center(
      child: Transform.translate(
        offset: const Offset(0, -60),
        child: Container(
          width: 250,
          height: 250,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  Assets.emptyList,
                ),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Widget _movies(HomeSuccessState state) {
    if (state.videos.isNotEmpty) {
      return _moviesList(state.videos);
    } else {
      return _emptyList();
    }
  }

  Widget _moviesList(List<Video> videos) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: videos.length,
        itemBuilder: ((context, index) {
          final video = videos[index];
          return VideoCard(
            onPressed: () =>
                context.read<SelectedVideoCubit>().selectVideo(video),
            video: video,
          );
        }));
  }

  Widget _error(HomeFailureState state) {
    return _errorView(state.failure);
  }

  Widget _errorView(Failure error) {
    return Center(
      child: Column(
        children: [
          Text(
            'Some thing wrong happend!',
            style: Topology.title.copyWith(
              color: Pallet.primaryColor,
            ),
          ),
          Text(
            error.message,
            style: Topology.body,
          ),
        ],
      ),
    );
  }

  void _handleSearch() {}
}

class VideoCard extends StatelessWidget {
  const VideoCard({
    Key? key,
    required this.video,
    required this.onPressed,
  }) : super(key: key);
  final Video video;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed.call(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          children: [
            _videoImage(context),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _channelAvatar(),
                      const SizedBox(width: 8),
                      _videoTitle(),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _videoDetails(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _videoDetails() {
    const double gap = 8;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'BBC Earth',
          style: Topology.caption,
        ),
        const SizedBox(width: gap),
        const Text(
          '.',
          style: Topology.caption,
        ),
        const SizedBox(width: gap),
        Text(
          '${video.voteCount} views',
          style: Topology.caption,
        ),
        const SizedBox(width: gap),
        const Text(
          '.',
          style: Topology.caption,
        ),
        const SizedBox(width: gap),
        const Text(
          '5 Months ago',
          style: Topology.caption,
        ),
      ],
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

  Widget _videoTitle() {
    return Flexible(
      child: Text(
        video.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Pallet.primaryTextColor,
        ),
      ),
    );
  }

  Widget _videoImage(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      width: size.width,
      height: size.width * 9 / 16,
      child: Stack(
        children: [
          Image.network(
            video.backdropPath,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Pallet.headerColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                video.duration.readable,
                style: Topology.caption.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: LinearProgressIndicator(
              value: video.watched,
              color: Pallet.primaryColor.withOpacity(0.7),
            ),
          )
        ],
      ),
    );
  }
}
