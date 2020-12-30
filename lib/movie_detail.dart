import 'package:flutter/material.dart';

import 'movie.dart';
import 'movie_list.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  String posterPath;
  static String imgBaseUrl = 'https://image.tmdb.org/t/p/w500/';

  MovieDetail(this.movie) {
    posterPath = movie.posterPath != null
        ? '$imgBaseUrl${movie.posterPath}'
        : defaultImageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final double imgHeight = MediaQuery.of(context).size.height / 1.5;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Center(child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              height: imgHeight,
              child: Image.network(posterPath),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(movie.overview),
            )
          ],
        )),
      )
    );
  }
}
