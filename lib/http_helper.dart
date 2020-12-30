import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'movie.dart';

class HttpHelper {
  final String apiKey = '2361ca3aec42d11fbd7d2a27a5f46851';
  Map<String, String> queryParameters;
  final String host = 'api.themoviedb.org';
  Uri upcomingUri;

  HttpHelper() {
    queryParameters = {
      'api_key': apiKey,
      'language': 'en-US',
    };

    upcomingUri = Uri(
      scheme: 'https',
      host: host,
      pathSegments: ['3', 'movie', 'upcoming'],
      queryParameters: queryParameters,
    );
  }

  Future<List<Movie>> getUpcoming() async {
    http.Response result = await http.get(upcomingUri.toString());

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
