import 'bloc/global/global_bloc.dart';
import 'bloc/theme/theme_cubit.dart';
import 'config.dart';
import 'services/local_storage_service.dart';
import 'style/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'router/router.dart';
import 'router/routes.dart';
import 'util/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  LocalStorageService(await SharedPreferences.getInstance());

  final Logger logger = Logger();
  GlobalBloc(logger: logger);

  runApp(BlocProvider(
    create: (context) => ThemeCubit(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: apThemeLight,
          darkTheme: apThemeDark,
          themeMode: state.themeMode,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale("sl"),
            //const Locale("en"),
          ],
          title: 'Arriva prihodi',
          debugShowCheckedModeBanner: false,
          initialRoute: APRoute.initial,
          onGenerateRoute: APRouter.onGenerateRoute,
        );
      },
    );
  }
}
