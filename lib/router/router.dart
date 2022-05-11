import '../screens/settings.dart';
import '../services/local_storage_service.dart';
import 'package:flutter/cupertino.dart';

import '../routes.dart';
import '../screens/home.dart';
import '../screens/splash.dart';
import '../util/logger.dart';
import 'routes.dart';

abstract class APRouter {
  /// Transforms [settings] into corresponding route.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Logger.instance.info(
      'VecturaRouter.onGenerateRoute',
      'pushing route ${settings.name}',
    );

    switch (settings.name) {
      case APRoute.initial:
        return CupertinoPageRoute(builder: (context) => SplashScreen());
      case APRoute.home:
        return CupertinoPageRoute(
          builder: (context) => HomeScreen(),
        );
      case APRoute.second:
        return CupertinoPageRoute(
          builder: (context) => SecondRoute(),
        );
      case APRoute.settings:
        return CupertinoPageRoute(
          builder: (context) => SettingsScreen(
            localStorageService: LocalStorageService.instance,
          ),
        );
    }

    return null;
  }
}
