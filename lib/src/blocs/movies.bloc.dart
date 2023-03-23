import 'package:light_project/src/models/item_model.dart';
import 'package:light_project/src/resources/repository.dart';
import 'package:observable/observable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:rxdart/rxdart.dart' ;
// import '../models/item_model.dart';
// import '../resources/repository.dart';

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
