//

import 'package:youtube_clone/extensions.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'video_model.dart';

class Video {
  final int id;
  final String title;
  final String subtitle;
  final String overview;
  final DateTime releaseDate;
  final String posterPathHighResURLString;
  final String posterPathLowResURLString;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final String backdropPath;
  final Duration duration;
  final Duration elepasedTime;
  final String path;
  Video({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.overview,
    required this.releaseDate,
    required this.posterPathHighResURLString,
    required this.posterPathLowResURLString,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    required this.backdropPath,
    required this.duration,
    required this.elepasedTime,
    required this.path,
  });

  factory Video.fromModel(VideoModel model) {
    return Video(
      id: model.id ?? 0,
      title: model.title ?? '',
      subtitle: model.subtitle ?? '',
      overview: model.overview ?? '',
      releaseDate: DateTime.parse(model.releaseDate ?? ''),
      posterPathHighResURLString: model.posterPathHighResURLString ?? '',
      posterPathLowResURLString: model.posterPathLowResURLString ?? '',
      popularity: model.popularity ?? 0,
      voteAverage: model.voteAverage ?? 0,
      voteCount: model.voteCount ?? 0,
      backdropPath: model.backdropPath ?? '',
      duration: model.duration == null
          ? Duration.zero
          : model.duration!.parseDuration(),
      elepasedTime: model.elepasedTime == null
          ? Duration.zero
          : model.elepasedTime!.parseDuration(),
      path: model.path ?? '',
    );
  }

  @override
  String toString() {
    return 'Video(title: $title)';
  }

  double get watched => elepasedTime.inSeconds / duration.inSeconds;
  String get timeAgo => timeago.format(releaseDate);

  static Video example = Video(
    id: 338953,
    title:
        "Fantastic Beasts, Professor Albus Dumbledore knows the powerful, dark wizard Gellert",
    subtitle: "The Secrets of Dumbledore",
    overview:
        "Professor Albus Dumbledore knows the powerful, dark wizard Gellert Grindelwald is moving to seize control of the wizarding world. Unable to stop him alone, he entrusts magizoologist Newt Scamander to lead an intrepid team of wizards and witches. They soon encounter an array of old and new beasts as they clash with Grindelwald's growing legion of followers.",
    releaseDate: DateTime.parse("2022-04-06"),
    posterPathHighResURLString:
        "https://image.tmdb.org/t/p/w500/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg",
    posterPathLowResURLString:
        "https://image.tmdb.org/t/p/w200/jrgifaYeUtTnaH7NF5Drkgjg2MB.jpg",
    popularity: 9941.754,
    voteAverage: 6.8,
    voteCount: 1497,
    backdropPath:
        "https://image.tmdb.org/t/p/w500/7ucaMpXAmlIM24qZZ8uI9hCY0hm.jpg",
    duration: const Duration(minutes: 32, seconds: 24),
    elepasedTime: const Duration(minutes: 10, seconds: 11),
    path:
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  );
}
