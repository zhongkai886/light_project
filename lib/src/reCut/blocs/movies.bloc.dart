import 'package:light_project/src/reCut/models/item_model.dart';
import 'package:light_project/src/reCut/resources/repository.dart';
import 'package:observable/observable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<ItemModel>();

  Stream<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    ItemModel? itemModel = await _repository.fetchAllMovies();
    if (itemModel != null) {
      _moviesFetcher.sink.add(itemModel);
    }

    dispose() {
      _moviesFetcher.close();
    }
  }
}

final bloc = MoviesBloc();
