import 'package:flutter/material.dart';
import 'package:movies/http_helper.dart';
import 'package:movies/movie_detail.dart';

import 'movie.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}
const String defaultImageUrl =
    'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

class _MovieListState extends State<MovieList> {
  List<Movie> movies;
  int movieCount;
  HttpHelper helper;
  final Icon searchIcon = Icon(Icons.search);
  final Icon cancelIcon = Icon(Icons.cancel);
  Icon visibleIcon;
  final String iconBaseUrl = 'https://image.tmdb.org/t/p/w92/';

  @override
  void initState() {
    helper = HttpHelper();
    loadUpcomingMovies();
    visibleIcon = searchIcon;
    super.initState();
  }

  Future loadUpcomingMovies() async {
    List<Movie> upComingMovies = List();
    upComingMovies = await helper.getUpcoming();
    setState(() {
      movies = upComingMovies;
      movieCount = upComingMovies.length;
    });
  }

  StatelessWidget posterIcon(String src) =>
      CircleAvatar(backgroundImage: NetworkImage(src));

  Widget searchBar = Text('Movies');

  Future submitSearch(String text) async {
    final List<Movie> foundMovies = await helper.findMovies(text);
    setState(() {
      movieCount = foundMovies.length;
      movies = foundMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
          actions: <Widget>[
            IconButton(icon: visibleIcon, onPressed: () {
              if (visibleIcon.icon == Icons.search) {
                setState(() {
                  visibleIcon = cancelIcon;
                  searchBar = TextField(
                    textInputAction: TextInputAction.search,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    autofocus: true,
                    showCursor: true,
                    onSubmitted: submitSearch,
                  );
                });
              } else {
                visibleIcon = searchIcon;
                searchBar = Text('Movies');
                loadUpcomingMovies();
              }
            }),
          ],
      ),
      body: ListView.builder(
        itemCount: (this.movieCount == null) ? 0 : this.movieCount,
        itemBuilder: (BuildContext context, int position) {
          final Movie currentItem = movies[position];
          final String imageSrc = currentItem.posterPath != null
              ? '$iconBaseUrl${currentItem.posterPath}'
              : defaultImageUrl;
          return Card(
            color: Colors.white,
            elevation: 2,
            child: ListTile(
              leading: posterIcon(imageSrc),
              title: Text('${currentItem.title}'),
              subtitle: Text(
                  'Released: ${currentItem.releaseDate} - Vote: ${currentItem.voteAverage.toString()}'),
              onTap: () {
                MaterialPageRoute movieDetailRoute = MaterialPageRoute(
                  builder: (_) => MovieDetail(currentItem)
                );
                Navigator.push(context, movieDetailRoute);
              },
            ),
          );
        },
      ),
    );
  }
}
