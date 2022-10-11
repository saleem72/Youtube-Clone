//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:youtube_clone/blocs/orientation_cubit/orientation_cubit.dart';
import 'package:youtube_clone/dependancy_injection.dart' as di;

import '../../pip_view/pip_view.dart';
import '../../pip_view/selected_video_cubit/selected_video_cubit.dart';
import '../botttom_bar_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // late NativeDeviceOrientationCommunicator communicator;
  // late Stream<NativeDeviceOrientation> stream;

  // @override
  // void initState() {
  //   super.initState();
  //   _initStream();
  // }

  // Future<void> _initStream() async {
  //   communicator = NativeDeviceOrientationCommunicator();
  //   await communicator.resume();
  //   final OrientationCubit cubit = di.locator();
  //   stream = communicator.onOrientationChanged(
  //     useSensor: true,
  //     defaultOrientation: NativeDeviceOrientation.portraitUp,
  //   )..listen((event) async {
  //       switch (event) {
  //         case NativeDeviceOrientation.landscapeLeft:
  //           cubit.updateOrientation(DeviceOrientation.landscapeLeft);
  //           break;
  //         case NativeDeviceOrientation.landscapeRight:
  //           cubit.updateOrientation(DeviceOrientation.landscapeRight);
  //           break;
  //         case NativeDeviceOrientation.portraitUp:
  //           cubit.updateOrientation(DeviceOrientation.portraitUp);
  //           break;
  //         case NativeDeviceOrientation.portraitDown:
  //           cubit.updateOrientation(DeviceOrientation.portraitDown);
  //           break;
  //         default:
  //           cubit.updateOrientation(DeviceOrientation.portraitUp);
  //           break;
  //       }
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedVideoCubit, SelectedVideoState>(
      builder: (context, state) {
        final Size size = MediaQuery.of(context).size;
        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const BottomBarScreen(),
              Offstage(
                offstage: state.video == null,
                child: PipView(
                  maximumHeight: size.height,
                  minimalHeight: (size.width / 3) * 9 / 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
