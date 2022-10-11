// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/video.dart';

class SelectedVideoCubit extends Cubit<SelectedVideoState> {
  SelectedVideoCubit() : super(const SelectedVideoState());

  void selectVideo(Video video) {
    print('SelectedVideoCubit $video');
    emit(SelectedVideoState(
      video: video,
      isFullMode: false,
    ));
  }

  void unSelect() {
    emit(const SelectedVideoState());
  }

  void setFullMode(bool mode) {
    final newState = SelectedVideoState(video: state.video, isFullMode: mode);
    emit(newState);
  }
}

class SelectedVideoState extends Equatable {
  final Video? video;
  final bool isFullMode;
  const SelectedVideoState({
    this.video,
    this.isFullMode = false,
  });

  @override
  List<Object?> get props => [video, isFullMode];
}
