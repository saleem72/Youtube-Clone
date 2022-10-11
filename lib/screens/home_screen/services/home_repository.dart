// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:dartz/dartz.dart';

import 'package:youtube_clone/models/video_model.dart';
import 'package:youtube_clone/screens/home_screen/services/home_service.dart';

import '../../../helpers/exceptions/failure.dart';

class HomeRepository {
  final HomeService service;

  HomeRepository({
    required this.service,
  });

  Future<Either<List<VideoModel>, Failure>> fetchMovies() async {
    try {
      final movies = await service.fetchMovies();
      return Left(movies ?? []);
    } catch (error) {
      return Right(Failure(message: error.toString()));
    }
  }
}
