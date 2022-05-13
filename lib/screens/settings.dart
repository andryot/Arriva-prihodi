import '../bloc/global/global_bloc.dart';
import '../bloc/theme/theme_cubit.dart';
import '../services/local_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/settings/settings_bloc.dart';

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
      child: _SettingsScreen(
        localStorageService: _localStorageService,
      ),
    );
  }
}

class _SettingsScreen extends StatelessWidget {
  final LocalStorageService _localStorageService;

  const _SettingsScreen({
    Key? key,
    required LocalStorageService localStorageService,
  })  : _localStorageService = localStorageService,
        super(key: key);
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
            )),
        body: Center(
          child: Column(children: <Widget>[
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
                      }),
                ],
              ),
            ),
            CupertinoButton(
                child: Text(
                  "Več informacij",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 17),
                ),
                onPressed: () => showAboutDialog(
                    context: context,
                    useRootNavigator: false,
                    applicationVersion: "\n2.0",
                    applicationName: "Arriva prihodi",
                    applicationLegalese:
                        "Podatki se pridobivajo iz spletne strani arriva.si\n\nRazvijalec: Andraž Anderle\nIcon made by Freepi from www.flaticon.com\nHvala Žan, Ana, Urban in Nik!")),
          ]),
        ),
      );
    });
  }
}
