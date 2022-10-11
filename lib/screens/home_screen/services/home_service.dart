//

import '../../../models/video_model.dart';

abstract class HomeService {
  Future<List<VideoModel>?> fetchMovies();
}
