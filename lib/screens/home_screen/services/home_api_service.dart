//

import 'package:flutter/material.dart';
import 'package:youtube_clone/models/video_model.dart';
import 'package:youtube_clone/screens/home_screen/services/home_service.dart';

class HomeApiService extends HomeService {
  @override
  Future<List<VideoModel>?> fetchMovies() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return [];
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
