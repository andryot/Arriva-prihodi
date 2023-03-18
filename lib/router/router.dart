import 'package:flutter/cupertino.dart';

import '../screens/home.dart';
import '../screens/settings.dart';
import '../screens/splash.dart';
import '../screens/timetable.dart';
import '../services/local_storage_service.dart';
import '../util/logger.dart';
import 'routes.dart';

abstract class APRouter {
  /// Transforms [settings] into corresponding route.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Logger.instance.info(
      'APRouter.onGenerateRoute',
      'pushing route ${settings.name}',
    );

    switch (settings.name) {
      case APRoute.initial:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());
      case APRoute.home:
        return CupertinoPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case APRoute.timetable:
        return CupertinoPageRoute(
          builder: (context) => TimetableScreen(
            args: settings.arguments as TimetableScreenArgs,
          ),
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
