import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'movie.dart';

class HttpHelper {
  final String apiKey = '2361ca3aec42d11fbd7d2a27a5f46851';
  Map<String, String> basicQueryParameters;
  final String scheme = 'https';
  final String host = 'api.themoviedb.org';
  Uri upcomingUri;

  HttpHelper() {
    basicQueryParameters = {
      'api_key': apiKey,
      'language': 'en-US',
    };

    upcomingUri = Uri(
      scheme: scheme,
      host: host,
      pathSegments: ['3', 'movie', 'upcoming'],
      queryParameters: basicQueryParameters,
    );
  }

  Uri buildSearchUri(String query) {
    Map<String, String> searchQueryParameters = {
      'query': query,
    };
    searchQueryParameters.addAll(basicQueryParameters);

    return Uri(
      scheme: scheme,
      host: host,
      pathSegments: ['3', 'search', 'movie'],
      queryParameters: searchQueryParameters,
    );
  }

  Future<List<Movie>> findMovies(String title) async {
    return queryMovieApi(buildSearchUri(title));
  }

  Future<List<Movie>> getUpcoming() async {
    return queryMovieApi(upcomingUri);
  }

  Future<List<Movie>> queryMovieApi(Uri uri) async {
    http.Response result = await http.get(uri.toString());

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      List moviesData = jsonResponse['results'];
      List<Movie> movies =
          moviesData.map((item) => Movie.fromJson(item)).toList();
      return movies;
    }
    return null;
  }
}
