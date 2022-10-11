// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:youtube_clone/models/bottom_bar_item.dart';
import 'package:youtube_clone/models/video.dart';
import 'package:youtube_clone/pip_view/pip_view.dart';
import 'package:youtube_clone/screens/home_screen/home_screen.dart';

import '../pip_view/selected_video_cubit/selected_video_cubit.dart';
import '../widgets/bottom_bar.dart';

class ScreensListItem {
  final BottomBarItem item;
  final Widget screen;

  const ScreensListItem({
    required this.item,
    required this.screen,
  });
}

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  BottomBarItem _selectedPage = BottomBarItem.home;

  void _pageHasChanged(BottomBarItem item) {
    setState(() {
      _selectedPage = item;
    });
  }

  final List<ScreensListItem> _screens = const [
    ScreensListItem(
      item: BottomBarItem.home,
      screen: HomeScreen(),
    ),
    ScreensListItem(
      item: BottomBarItem.shorts,
      screen: Scaffold(body: Center(child: Text('Shorts'))),
    ),
    ScreensListItem(
      item: BottomBarItem.subscriptions,
      screen: Scaffold(body: Center(child: Text('Subscriptions'))),
    ),
    ScreensListItem(
      item: BottomBarItem.library,
      screen: Scaffold(body: Center(child: Text('Library'))),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: ((context) => SelectedVideoCubit()),
    //   child: BlocBuilder<SelectedVideoCubit, SelectedVideoState>(
    //     builder: (context, state) {
    //       return Scaffold(
    //         extendBody: true,
    //         bottomNavigationBar: AnimatedContainer(
    //           duration: const Duration(milliseconds: 250),
    //           height: state.isFullMode ? 0 : 60,
    //           child: state.isFullMode
    //               ? Container()
    //               : BottomBar(
    //                   selectedItem: _selectedPage,
    //                   isFullMode: state.isFullMode,
    //                   onChange: _pageHasChanged,
    //                 ),
    //         ),
    //         body: _content(context, state.video),
    //       );
    //     },
    //   ),
    // );

    return Scaffold(
      // extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: BottomBar(
        selectedItem: _selectedPage,
        isFullMode: false,
        onChange: _pageHasChanged,
      ),
      body: _content(context),
    );
  }

  Stack _content(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
        alignment: Alignment.bottomCenter,
        children: _screens
            .map((e) => Offstage(
                  offstage: _selectedPage != e.item,
                  child: e.screen,
                ))
            .toList()
        // ..add(Offstage(
        //   offstage: video == null,
        //   child: PipView(
        //     maximumHeight: size.height,
        //     minimalHeight: (size.width / 3) * 9 / 16,
        //   ),
        // )),
        );
  }
}
