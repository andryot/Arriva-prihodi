import '../bloc/global/global_bloc.dart';
import '../bloc/theme/theme_cubit.dart';
import '../services/local_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/splash/splash_bloc.dart';
import '../style/constants.dart';
import '../style/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(
        localStorageService: LocalStorageService.instance,
        globalBloc: GlobalBloc.instance,
      ),
      child: const _SplashScreen(),
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.initialized && state.pushRoute != null) {
          BlocProvider.of<ThemeCubit>(context).initThemeMode(
              GlobalBloc.instance.isDarkMode
                  ? ThemeMode.dark
                  : ThemeMode.light);
          Navigator.popAndPushNamed(context, state.pushRoute!);
          return;
        }
      },
      builder: (context, state) {
        final double logoSize = getLogoSize(context) + state.deltaLogoSize;
        return CupertinoPageScaffold(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      APImage.logo,
                      width: logoSize,
                      height: logoSize,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
