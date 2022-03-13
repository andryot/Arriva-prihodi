import 'package:flutter/cupertino.dart';

import '../HomePage.dart';
import '../routes.dart';
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
        return CupertinoPageRoute(builder: (context) => HomePage());
      case APRoute.home:
        return PageRouteBuilder(
          pageBuilder: (context, _, __) => HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      case APRoute.second:
        return PageRouteBuilder(
          pageBuilder: (context, _, __) => SecondRoute(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
    }

    return null;
  }
}
