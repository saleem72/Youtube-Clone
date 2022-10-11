//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_clone/blocs/orientation_cubit/orientation_cubit.dart';
import 'package:youtube_clone/dependancy_injection.dart' as di;
import 'package:youtube_clone/helpers/styling/pallet.dart';

import 'pip_view/selected_video_cubit/selected_video_cubit.dart';
import 'push_notifications/notifications_widget.dart';
import 'screens/main_screen/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  di.initDependancies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Pallet.darkTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SelectedVideoCubit()),
          BlocProvider(create: (context) => OrientationCubit()),
        ],
        child: const MainScreen(),
      ),
    );
  }
}


// classpath 'com.google.gms:google-services:4.3.13'
// apply plugin: "com.google.gms.google-services"
