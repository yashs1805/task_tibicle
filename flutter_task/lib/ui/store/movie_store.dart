import 'package:dio/dio.dart';
import 'package:flutter_task/core/di/api/dio_util_error.dart';
import 'package:flutter_task/model/genres_data.dart';
import 'package:flutter_task/model/movie_data.dart';
import 'package:mobx/mobx.dart';

part 'movie_store.g.dart';

class MovieStore = _MovieStoreBase with _$MovieStore;

abstract class _MovieStoreBase with Store {

  @observable
  String? errorMessage;

  int movieListPageToken = 0;

  @observable
  ObservableList<MovieData> movieListResponse =
  ObservableList<MovieData>();


  @observable
  ObservableList<GenresData> genresListResponse =
  ObservableList<GenresData>();

  List<String> finalGenresList = [];


  Future getGenresList() async {
    final client = Dio();
    try {
      final response = await client.get('https://api.themoviedb.org/3/genre/movie/list?api_key=0e7274f05c36db12cbe71d9ab0393d47');
      print(response.data['genres']);
      List<GenresData> results = [];
      if (response.data['genres'] != null) {
        results = <GenresData>[];
        response.data['genres'].forEach((v) {
          results.add(GenresData.fromJson(v));
        });
      }
      genresListResponse.addAll(results);
    }  on DioError catch (e) {
      errorMessage = DioErrorUtil.handleError(e);
    }
    return genresListResponse;
  }


  Future getMoviesList() async {
    final client = Dio();
    try {
      final response = await client.get('https://api.themoviedb.org/3/movie/now_playing?page=1&api_key=0e7274f05c36db12cbe71d9ab0393d47');
      print(response.data['results']);
      List<MovieData> results = [];
      if (response.data['results'] != null) {
        results = <MovieData>[];
        response.data['results'].forEach((v) {
          results.add(MovieData.fromJson(v));
        });
      }
      movieListResponse.addAll(results);
    } on DioError catch (e) {
      errorMessage = DioErrorUtil.handleError(e);
    }
    return movieListResponse;
  }

}


