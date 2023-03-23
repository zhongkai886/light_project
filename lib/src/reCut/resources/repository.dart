import 'dart:async';
import 'package:light_project/src/reCut/models/item_model.dart';

import 'movie_api_provider.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<ItemModel>? fetchAllMovies() => moviesApiProvider.fetchMovieList();
}
