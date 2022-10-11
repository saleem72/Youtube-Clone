//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_clone/helpers/styling/assets.dart';
import 'package:youtube_clone/models/video_model.dart';
import 'package:youtube_clone/screens/home_screen/services/home_service.dart';

class MockHomeService extends HomeService {
  @override
  Future<List<VideoModel>?> fetchMovies() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      String data = await rootBundle.loadString(Assets.moviesResponse);
      // final jsonResult = json.decode(data);

      final response = MoviesResponse.fromJson(data);
      final videos = response.playNow;

      return videos;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
