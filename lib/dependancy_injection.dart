//

import 'package:get_it/get_it.dart';
import 'package:youtube_clone/blocs/orientation_cubit/orientation_cubit.dart';

final locator = GetIt.instance;

void initDependancies() {
  locator.registerSingleton(OrientationCubit());
}
