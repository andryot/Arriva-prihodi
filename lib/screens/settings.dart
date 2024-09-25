import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../bloc/global/global_bloc.dart';
import '../bloc/settings/settings_bloc.dart';
import '../bloc/theme/theme_cubit.dart';
import '../services/local_storage_service.dart';
import '../style/constants.dart';
import '../style/images.dart';

class SettingsScreen extends StatelessWidget {
  final LocalStorageService _localStorageService;

  const SettingsScreen({
    Key? key,
    required LocalStorageService localStorageService,
  })  : _localStorageService = localStorageService,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(
        localStorageService: _localStorageService,
        globalBloc: GlobalBloc.instance,
      ),
      child: const _SettingsScreen(),
    );
  }
}

class _SettingsScreen extends StatelessWidget {
  const _SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: CupertinoButton(
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          title: Text(
            "Nastavitve",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Dark mode",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 17),
                    ),
                    Switch(
                      activeColor: Theme.of(context).primaryColor,
                      value: state.isDarkMode,
                      onChanged: (bool value) {
                        BlocProvider.of<ThemeCubit>(context).switchTheme();
                        BlocProvider.of<SettingsBloc>(context)
                            .add(SwitchThemeEvent());
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Avtomatski scroll",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 17),
                    ),
                    Switch(
                      activeColor: Theme.of(context).primaryColor,
                      value: state.isAutomaticScroll,
                      onChanged: (bool value) =>
                          BlocProvider.of<SettingsBloc>(context)
                              .switchAutomaticScroll(value),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Shrani zadnje iskanje",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 17),
                    ),
                    Switch(
                      activeColor: Theme.of(context).primaryColor,
                      value: state.isSaveLastSearch,
                      onChanged: (bool value) =>
                          BlocProvider.of<SettingsBloc>(context)
                              .switchSaveLastSearch(value),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Link do github projekta',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.orange
                          : Colors.green,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => launchUrlString(githubUrl),
                  ),
                ),
              ),
              CupertinoButton(
                child: Text(
                  "Več informacij",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 17,
                  ),
                ),
                onPressed: () => showAboutDialog(
                  context: context,
                  useRootNavigator: false,
                  applicationVersion: "\n$appVersion",
                  applicationName: "Arriva prihodi",
                  applicationIcon: Image.asset(
                    APImage.logo,
                    width: 30,
                    height: 30,
                  ),
                  applicationLegalese: '''
Podatki se pridobivajo s spletne strani arriva.si
Razvijalec: Andraž Anderle
Icon made by Freepi from www.flaticon.com
Hvala Žan, Ana, Urban in Nik!
Powered by Flutter
''',
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
