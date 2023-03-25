part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {
  const NavigationEvent();
}

class EventA extends NavigationEvent {}

class EventB extends NavigationEvent {}
