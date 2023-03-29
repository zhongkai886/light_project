part of 'data_bloc.dart';

// @immutable
abstract class DataEvent {
  showLog();
}

class FetchData extends DataEvent {
  @override
  showLog() {
    print('FetchData');
  }
}
