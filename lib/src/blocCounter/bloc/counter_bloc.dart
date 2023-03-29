import 'package:bloc/bloc.dart';

part 'counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<IncrementPressed>(
      (event, emit) {
        emit(state + 1);
      },
    );

    on<DecrementPressed>(
      (event, emit) {
        emit(state - 1);
      },
    );
  }
}
