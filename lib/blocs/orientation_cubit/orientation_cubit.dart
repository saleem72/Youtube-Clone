import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

class OrientationCubit extends Cubit<DeviceOrientation> {
  OrientationCubit() : super(DeviceOrientation.portraitUp);

  void updateOrientation(DeviceOrientation orientation) {
    if (state != orientation) {
      emit(orientation);
    }
  }
}
