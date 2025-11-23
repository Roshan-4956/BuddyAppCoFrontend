import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    developer.log(
        'GoRouterObserver: didPush: ${route.settings.name} (args: ${route.settings.arguments})');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    developer.log('GoRouterObserver: didPop: ${route.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    developer.log('GoRouterObserver: didRemove: ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    developer.log(
        'GoRouterObserver: didReplace: ${newRoute?.settings.name} (prev: ${oldRoute?.settings.name})');
  }
}
