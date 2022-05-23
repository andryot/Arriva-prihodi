import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/global/global_bloc.dart';
import 'bloc/theme/theme_cubit.dart';
import 'router/router.dart';
import 'router/routes.dart';
import 'services/backend_service.dart';
import 'services/http_service.dart';
import 'services/local_storage_service.dart';
import 'style/theme.dart';
import 'util/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final LocalStorageService localStorageService =
      LocalStorageService(await SharedPreferences.getInstance());
  final Logger logger = Logger();
  final HttpService httpService = HttpService();
  final GlobalBloc globalBloc =
      GlobalBloc(logger: logger, localStorageService: localStorageService);
  BackendService(httpService: httpService, globalBloc: globalBloc);

  runApp(BlocProvider(
    create: (context) => ThemeCubit(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: apThemeLight,
          darkTheme: apThemeDark,
          themeMode: state.themeMode,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("sl"),
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
