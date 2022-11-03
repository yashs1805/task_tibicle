// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MovieStore on _MovieStoreBase, Store {
  late final _$errorMessageAtom =
      Atom(name: '_MovieStoreBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$movieListResponseAtom =
      Atom(name: '_MovieStoreBase.movieListResponse', context: context);

  @override
  ObservableList<MovieData> get movieListResponse {
    _$movieListResponseAtom.reportRead();
    return super.movieListResponse;
  }

  @override
  set movieListResponse(ObservableList<MovieData> value) {
    _$movieListResponseAtom.reportWrite(value, super.movieListResponse, () {
      super.movieListResponse = value;
    });
  }

  late final _$genresListResponseAtom =
      Atom(name: '_MovieStoreBase.genresListResponse', context: context);

  @override
  ObservableList<GenresData> get genresListResponse {
    _$genresListResponseAtom.reportRead();
    return super.genresListResponse;
  }

  @override
  set genresListResponse(ObservableList<GenresData> value) {
    _$genresListResponseAtom.reportWrite(value, super.genresListResponse, () {
      super.genresListResponse = value;
    });
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
movieListResponse: ${movieListResponse},
genresListResponse: ${genresListResponse}
    ''';
  }
}
