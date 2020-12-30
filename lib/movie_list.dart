import 'package:flutter/material.dart';
import 'package:movies/http_helper.dart';

import 'movie.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<Movie> movies;
  int movieCount;
  HttpHelper helper;

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  Future initialize() async {
    List<Movie> upComingMovies = List();
    upComingMovies = await helper.getUpcoming();
    setState(() {
      movies = upComingMovies;
      movieCount = upComingMovies.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie List'),
      ),
      body: ListView.builder(
        itemCount: (this.movieCount == null) ? 0 : this.movieCount,
        itemBuilder: (BuildContext context, int position) {
          final Movie currentItem = movies[position];
          return Card(
              color: Colors.white,
              elevation: 2,
              child: ListTile(
                title: Text('${currentItem.title}'),
                subtitle: Text('Released: ${currentItem.releaseDate} - Vote: ${currentItem.voteAverage.toString()}'),
              ),
          );
        },
      ),
    );
  }
}
