import 'package:bus_time_table/config.dart';
import 'package:bus_time_table/router/routes.dart';
import 'package:bus_time_table/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeBloc(),
      child: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: <Widget>[
          CupertinoButton(
            onPressed: () => Navigator.of(context).pushNamed(APRoute.settings),
            child: Icon(
              Icons.settings,
              size: 30,
              color: Theme.of(context).highlightColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(),
      ),
    );
  }
}
