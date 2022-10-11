// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<Video> videos;
  const HomeSuccessState({
    required this.videos,
  });

  @override
  List<Object> get props => [videos];
}

class HomeFailureState extends HomeState {
  final Failure failure;

  const HomeFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
