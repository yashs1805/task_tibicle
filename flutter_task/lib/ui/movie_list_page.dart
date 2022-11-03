import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_task/model/movie_data.dart';
import 'package:flutter_task/ui/store/movie_store.dart';

final MovieStore _movieStore = MovieStore();

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  @override
  void initState() {
    getGenresList();
    getMoviesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: Observer(builder: (context) {
        if (_movieStore.movieListResponse.isEmpty || _movieStore.genresListResponse.isEmpty) {
          if(_movieStore.errorMessage == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text(_movieStore.errorMessage ?? ""),);
          }

        } else {
          return ListView.builder(
              itemCount: _movieStore.movieListResponse.length, // Edit this
              itemBuilder: (context, index) =>
                  MovieCard(_movieStore.movieListResponse[index]));
        }
      }),
    );
  }

  getGenresList() async {
    await _movieStore.getGenresList();
  }

  getMoviesList() async {
    await _movieStore.getMoviesList();
  }
}

class MovieCard extends StatelessWidget {
  final MovieData movie;

  MovieCard(this.movie);

  List<String> namesList = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              /*CachedNetworkImage(imageUrl: 'https://image.tmdb.org/t/p/original/${movie.backdropPath ?? ''}',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),*/
              Image.network(
                  'https://image.tmdb.org/t/p/original/${movie.backdropPath ?? ''}',
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(

                      ),
                    );
                  }),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(movie.title ?? '',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(movie.overview ?? ''),
                  SizedBox(height: 5),
                  Text('Vote average : ${movie.voteAverage}'),
                  SizedBox(height: 5),
                  Text('Vote count : ${movie.voteCount}'),
                  SizedBox(height: 5),
                  Text('Generes name : ${getNames()}'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  getNames() {
    List<String> names = [];
    for (var i in movie.genreIds!) {
      names.add(_movieStore.genresListResponse
          .where((element) => element.id! == i).first
          .name!);
    }
    String genre = "";
    for(int i=0; i<names.length; i++) {
      if(i == 0) {
        genre = names[i];
      } else {
        genre = genre + ", ${names[i]}";
      }
    }
    return genre;
  }
}
