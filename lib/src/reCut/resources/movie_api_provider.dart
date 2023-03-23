import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'dart:async';

import 'package:light_project/src/reCut/models/item_model.dart';
// import 'package:http/http.dart' show Client;

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '35d48a1b31f05f5702b63ed127bb25ec';

  final queryParameters = {
    'key': '35d48a1b31f05f5702b63ed127bb25ec',
  };
  Future<ItemModel>? fetchMovieList() async {
    try {
      // final dio = Dio();
      // dio.options.baseUrl =
      //     'http://api.themoviedb.org/3/movie/popular?api_key=35d48a1b31f05f5702b63ed127bb25ec';
      // final res = await dio.get('');
      final res2 = await client
          // http://api.themoviedb.org/3/movie/popular?api_key=35d48a1b31f05f5702b63ed127bb25ec
          .get(
        Uri.http(
          'api.themoviedb.org',
          '/3/movie/popular',
          {'api_key': '35d48a1b31f05f5702b63ed127bb25ec'},
        ),
      );
      

      return ItemModel.fromJson(jsonDecode(res2.body));
    } catch (e) {
      return Future.error(e);
    }
  }
}
