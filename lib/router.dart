import 'package:flutter/material.dart';

class Router {
  static final _navigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static Future pushNamed(String routeName, {Object? arguments}) =>
      _navigatorKey.currentState!.pushNamed(
        routeName,
        arguments: arguments,
      );

  static void pop<T extends Object?>([T? result]) =>
      _navigatorKey.currentState!.pop(result);
}
