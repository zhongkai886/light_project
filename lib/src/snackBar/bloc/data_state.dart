part of 'data_bloc.dart';

@immutable
abstract class DataState {}

class Initial extends DataState {}

class Loading extends DataState {}

class Success extends DataState {}


// class SnackBarInitial extends DataState {}
