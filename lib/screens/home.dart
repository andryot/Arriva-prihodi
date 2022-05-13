import 'package:bus_time_table/widgets/ap_date_field.dart';
import 'package:bus_time_table/widgets/ap_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home/home_bloc.dart';
import '../router/routes.dart';
import '../style/theme.dart';
import '../widgets/ap_circle_button.dart';
import '../widgets/ap_dashed_line.dart';

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
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
        return WillPopScope(
          onWillPop: () => _onBackPressed(context),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                centerTitle: true,
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
                      color: myColors.labelColor,
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 20.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      // MAIN FIELDS
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Theme.of(context).backgroundColor,
                        ),
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
                                            APInputField(
                                              suggestionsBoxController: homeBloc
                                                  .fromSuggestionsBoxController,
                                              focusNode: homeBloc.fromFocusNode,
                                              textEditingController:
                                                  homeBloc.fromController,
                                              labelText: "Vstopna postaja",
                                            ),
                                            const SizedBox(height: 20),
                                            APInputField(
                                              suggestionsBoxController: homeBloc
                                                  .destinationSuggestionsBoxController,
                                              focusNode:
                                                  homeBloc.destinationFocusNode,
                                              textEditingController: homeBloc
                                                  .destinationController,
                                              labelText: "Izstopna postaja",
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: APCircleButton(
                                            icon: Icons.swap_vert,
                                            iconColor: myColors.labelColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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

                              // DATE
                              Row(
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(width: 15),
                                  Flexible(
                                    child: APDateField(
                                        initialDate: DateTime.now(),
                                        textEditingController:
                                            homeBloc.dateController,
                                        onTap: () async {
                                          final DateTime? selectedDate =
                                              await showDatePicker(
                                            helpText: "Izberi datum odhoda",
                                            context: context,
                                            builder: (BuildContext? context,
                                                Widget? child) {
                                              return Theme(
                                                data: Theme.of(context!),
                                                child: child!,
                                              );
                                            },
                                            firstDate: state.selectedDate
                                                .subtract(Duration(days: 365)),
                                            initialDate: state.selectedDate,
                                            lastDate: state.selectedDate
                                                .add(Duration(days: 365)),
                                          );

                                          if (selectedDate != null) {
                                            homeBloc.dateSelected(selectedDate);
                                          }
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // SEARCH BUTTON
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18.0),
                                child: Text(
                                  "Išči",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
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
