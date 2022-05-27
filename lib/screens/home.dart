import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/global/global_bloc.dart';
import '../bloc/home/home_bloc.dart';
import '../router/routes.dart';
import '../style/theme.dart';
import '../widgets/ap_circle_button.dart';
import '../widgets/ap_date_field.dart';
import '../widgets/ap_favorite_list_tile.dart';
import '../widgets/ap_input_field.dart';
import 'timetable.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          HomeBloc(globalBloc: GlobalBloc.instance),
      child: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyColors myColors = Theme.of(context).extension<MyColors>()!;

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
            //surfaceTintColor: Colors.transparent,
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            actions: <Widget>[
              CupertinoButton(
                padding: const EdgeInsets.only(right: 16),
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
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 5.0),
                child: Column(
                  children: [
                    // MAIN FIELDS
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 30.0,
                            bottom: 30.0,
                            right: 30.0,
                            left: 15,
                          ),
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
                                              isError: state.isFromError,
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
                                              isError: state.isDestinationError,
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 15.0,
                                            ),
                                            child: APCircleButton(
                                              onPressed: () => homeBloc.swap(),
                                              icon: Icons.swap_vert,
                                              iconColor: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(height: 20),
                                        Icon(
                                          Icons.location_on,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        Flexible(
                                          child: DottedLine(
                                            direction: Axis.vertical,
                                            dashGradient: [
                                              Theme.of(context).primaryColor,
                                              myColors.secondLocationColor!,
                                            ],
                                            lineThickness: 2.5,
                                            dashGapLength: 5,
                                            dashLength: 8,
                                          ),
                                        ),
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
                                                .subtract(
                                                    const Duration(days: 365)),
                                            initialDate: state.selectedDate,
                                            lastDate: state.selectedDate
                                                .add(const Duration(days: 365)),
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
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                            ),
                            onPressed: () {
                              homeBloc.search(context);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 18.0),
                              child: Text(
                                "Išči",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    if (state.favoriteRides != null &&
                        state.favoriteRides!.isNotEmpty) ...[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 20, right: 20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 25),
                              Text(
                                "Priljubljene relacije: ",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              ReorderableListView(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                onReorder: (int oldIndex, int newIndex) {
                                  homeBloc.reorderFavoriteRides(
                                      oldIndex, newIndex);
                                },
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                children: <Widget>[
                                  for (int index = 0;
                                      index < state.favoriteRides!.length;
                                      index++)
                                    APFavoriteListTile(
                                      key: Key('$index'),
                                      ride: state.favoriteRides![index],
                                      index: index,
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          APRoute.timetable,
                                          arguments: TimetableScreenArgs(
                                            from: state
                                                .favoriteRides![index].from,
                                            destination: state
                                                .favoriteRides![index]
                                                .destination,
                                            date: state.selectedDate,
                                          ),
                                        );
                                      },
                                      onLongPress: () {
                                        showModalBottomSheet<void>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              CupertinoActionSheet(
                                            title: const Text(
                                              "Urejanje relacije",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            actions: <
                                                CupertinoActionSheetAction>[
                                              CupertinoActionSheetAction(
                                                isDefaultAction: true,
                                                onPressed: () =>
                                                    Navigator.popAndPushNamed(
                                                  context,
                                                  APRoute.timetable,
                                                  arguments:
                                                      TimetableScreenArgs(
                                                    from: state
                                                        .favoriteRides![index]
                                                        .from,
                                                    destination: state
                                                        .favoriteRides![index]
                                                        .destination,
                                                    date: state.selectedDate,
                                                  ),
                                                ),
                                                child:
                                                    const Text('Prikaži urnik'),
                                              ),
                                              CupertinoActionSheetAction(
                                                isDestructiveAction: true,
                                                onPressed: () {
                                                  homeBloc.removeFavorite(state
                                                      .favoriteRides![index]);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                    'Izbriši priljubljeno relacijo'),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Future<bool> _onBackPressed(BuildContext context) async {
  bool shouldPop = false;
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        'Želite zapreti aplikacijo?',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "Prekliči",
            style: TextStyle(fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () {
            shouldPop = true;
            Navigator.of(context).pop();
          },
          child: const Text(
            "Zapri",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ),
      ],
    ),
  );
  return shouldPop;
}
