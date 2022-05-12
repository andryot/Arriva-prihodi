import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home/home_bloc.dart';
import '../predictions.dart';
import '../router/routes.dart';
import '../style/theme.dart';
import '../util/parser.dart';
import '../widgets/ap_circle_button.dart';
import '../widgets/ap_dashed_line.dart';
import '../widgets/ap_text_field.dart';

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
    final MyColors myColors = Theme.of(context).extension<MyColors>()!;
    final TextEditingController dateController = TextEditingController();
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(
              "Arriva prihodi",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            actions: <Widget>[
              CupertinoButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(APRoute.settings),
                child: Icon(
                  Icons.settings,
                  size: 30,
                  color: Theme.of(context).highlightColor,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 20.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(40),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, bottom: 40.0, right: 20.0, left: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 38.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InputFormDeparture(),
                                    const SizedBox(height: 20),
                                    InputFormDeparture(),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: APCircleButton(
                                    icon: Icons.swap_vert,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(height: 20),
                                Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).primaryColor,
                                ),
                                APDashedLine(),
                                Icon(
                                  Icons.location_on,
                                  color: myColors.secondLocationColor,
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.date_range,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 38.0),
                            child: APTextField(
                              controller: dateController,
                              readOnly: true,
                              onTap: () async {
                                final DateTime? departureDate =
                                    await showDatePicker(
                                  helpText: "Izberi datum odhoda",
                                  context: context,
                                  builder:
                                      (BuildContext? context, Widget? child) {
                                    return Theme(
                                      data: Theme.of(context!),
                                      child: child!,
                                    );
                                  },
                                  firstDate: DateTime(2020),
                                  initialDate: DateTime.now(),
                                  lastDate: DateTime(2030),
                                );
                                if (departureDate != null) {
                                  dateController.text =
                                      APParser.dateToString(departureDate);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> _onBackPressed(BuildContext context) async {
  return await showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: new Text(
                'Želite zapreti aplikacijo?',
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                CupertinoButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    "Prekliči",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                CupertinoButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    "Zapri",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
              ],
            ),
          ) ==
          Object
      ? true
      : false;
}
