import 'package:flutter/material.dart';

class AppNavigator {
  static AppNavigator? _instance;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  AppNavigator._();

  static AppNavigator get instance {
    _instance ??= AppNavigator._();
    return _instance!;
  }

  // for test
  static set instance(AppNavigator navigator) {
    _instance = navigator;
  }

  Future<void> push(Widget screen) {
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Future<void> pushAndRemoveUntil(Widget screen) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
          (Route<dynamic> route) => false,
    );
  }

  void pop() {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop();
    }
  }

  Future<void> popAndPush(Widget screen) {
    pop();
    return push(screen);
  }
}