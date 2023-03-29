import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(const BookState()) {
    on<BookSelected>((event, emit) {
      emit(state.copyWith(selectedBook: () => event.book));
    });
    on<BookDeselected>((event, emit) {
      emit(state.copyWith(selectedBook: () => null));
    });
  }
}
