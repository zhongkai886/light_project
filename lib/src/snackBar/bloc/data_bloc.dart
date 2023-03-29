import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(Initial()) {
    on<FetchData>((event, emit) async {
      emit(Loading());
      await Future.delayed(const Duration(milliseconds: 2000));
      emit(Success());
    });
  }
}
