// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'title']);
  return Movie(
    json['id'] as int,
    json['title'] as String,
    (json['vote_average'] as num)?.toDouble(),
    json['release_date'] as String,
    json['overview'] as String,
    json['poster_path'] as String,
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'vote_average': instance.voteAverage,
      'release_date': instance.releaseDate,
      'poster_path': instance.posterPath,
    };
