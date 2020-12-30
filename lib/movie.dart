import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(required: true)
  final int id;
  @JsonKey(required: true)
  String title;
  String overview;

  @JsonKey(name: 'vote_average')
  double voteAverage;
  @JsonKey(name: 'release_date')
  String releaseDate;
  @JsonKey(name: 'poster_path')
  String posterPath;

  Movie(this.id,  this.title, this.voteAverage, this.releaseDate, this.overview, this.posterPath);

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
