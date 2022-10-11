import 'dart:convert';

import 'package:youtube_clone/extensions.dart';
//

class MoviesResponse {
  MoviesResponse({
    required this.playNow,
  });

  final List<VideoModel> playNow;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'playNow': playNow.map((x) => x.toMap()).toList(),
    };
  }

  factory MoviesResponse.fromMap(Map<String, dynamic> map) {
    return MoviesResponse(
      playNow: List<VideoModel>.from(
        (map['play_now'] as List<dynamic>).map<VideoModel>(
          (x) => VideoModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MoviesResponse.fromJson(String source) =>
      MoviesResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

class VideoModel {
  final int? id;
  final String? title;
  final String? subtitle;
  final String? overview;
  final String? releaseDate;
  final String? posterPathHighResURLString;
  final String? posterPathLowResURLString;
  final double? popularity;
  final double? voteAverage;
  final int? voteCount;
  final String? backdropPath;
  final String? duration;
  final String? elepasedTime;
  final String? path;
  VideoModel({
    this.id,
    this.title,
    this.subtitle,
    this.overview,
    this.releaseDate,
    this.posterPathHighResURLString,
    this.posterPathLowResURLString,
    this.popularity,
    this.voteAverage,
    this.voteCount,
    this.backdropPath,
    this.duration,
    this.elepasedTime,
    this.path,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'overview': overview,
      'releaseDate': releaseDate,
      'posterPathHighResURLString': posterPathHighResURLString,
      'posterPathLowResURLString': posterPathLowResURLString,
      'popularity': popularity,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
      'backdropPath': backdropPath,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      subtitle: map['subtitle'] != null ? map['subtitle'] as String : null,
      overview: map['overview'] != null ? map['overview'] as String : null,
      releaseDate:
          map['releaseDate'] != null ? map['releaseDate'] as String : null,
      posterPathHighResURLString: map['posterPathHighResURLString'] != null
          ? map['posterPathHighResURLString'] as String
          : null,
      posterPathLowResURLString: map['posterPathLowResURLString'] != null
          ? map['posterPathLowResURLString'] as String
          : null,
      popularity:
          map['popularity'] != null ? map['popularity'] as double : null,
      voteAverage:
          map['voteAverage'] != null ? map['voteAverage'] as double : null,
      voteCount: map['voteCount'] != null ? map['voteCount'] as int : null,
      backdropPath:
          map['backdropPath'] != null ? map['backdropPath'] as String : null,
      duration: map['duration'] != null ? map['duration'] as String : null,
      elepasedTime:
          map['elepasedTime'] != null ? map['elepasedTime'] as String : null,
      path: map['path'] != null ? map['path'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
