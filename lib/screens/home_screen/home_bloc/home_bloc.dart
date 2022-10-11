import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/helpers/exceptions/failure.dart';
import 'package:youtube_clone/models/video_model.dart';
import 'package:youtube_clone/screens/home_screen/services/home_repository.dart';
import 'package:youtube_clone/screens/home_screen/services/mock_home_service.dart';

import '../../../models/video.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository = HomeRepository(service: MockHomeService());

  HomeBloc() : super(HomeInitial()) {
    on<FetchMoviesEvent>((event, emit) => _fetchMovies());
  }

  void _fetchMovies() async {
    emit(HomeLoadingState());
    final result = await repository.fetchMovies();
    result.fold(
      (list) => emit(HomeSuccessState(
          videos: list.map((e) => Video.fromModel(e)).toList())),
      (failure) => emit(HomeFailureState(failure: failure)),
    );
  }
}
