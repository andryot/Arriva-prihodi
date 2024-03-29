import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../bloc/global/global_bloc.dart';
import '../bloc/timetable/timetable_bloc.dart';
import '../services/backend_service.dart';
import '../style/theme.dart';
import '../util/failure.dart';
import '../widgets/ap_list_tile.dart';
import '../widgets/ap_sliver_app_bar.dart';
import '../widgets/ap_stops.dart';
import '../widgets/loading_indicator.dart';

class TimetableScreenArgs {
  final String from;
  final String destination;
  final DateTime date;

  const TimetableScreenArgs({
    required this.from,
    required this.destination,
    required this.date,
  });
}

class TimetableScreen extends StatelessWidget {
  final TimetableScreenArgs args;
  const TimetableScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimetableBloc(
        args: args,
        globalBloc: GlobalBloc.instance,
        backendService: BackendService.instance,
      ),
      child: const _TimetableScreen(),
    );
  }
}

class _TimetableScreen extends StatelessWidget {
  const _TimetableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TimetableBloc, TimetableState>(
        listener: (context, state) async {
          if (state.failure != null && state.failure is! LoadStationsFailure) {
            if (state.failure is InitialFailure ||
                state.failure is ArrivaApiFailure) {
              Navigator.of(context).pop();
            } else if (state.failure is NoRidesFailure) {
              return showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context2) => AlertDialog(
                  title: const Text("Napaka!"),
                  content:
                      const Text("Med relacijama na izbrani dan ni povezav"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () => Navigator.of(context2).pop(),
                    ),
                  ],
                ),
              ).then((value) => Navigator.of(context).pop());
            }

            final String message = state.failure == const ArrivaApiFailure()
                ? "Spletna stran arriva.si trenutno ne deluje. Poskusite kasneje."
                : "Preverite internetno povezavo.";

            showDialog(
              context: context,
              builder: (context2) => AlertDialog(
                title: const Text("Napaka!"),
                content: Text(
                  "Oops, prišlo je do napake. $message",
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () => Navigator.of(context2).pop(),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          final TimetableBloc bloc = BlocProvider.of(context);

          if (state.isLoading == true) {
            return const Center(
              child: LoadingIndicator(
                dotRadius: 8,
                radius: 24,
              ),
            );
          }

          return WillPopScope(
            onWillPop: () async {
              if (bloc.panelController.isPanelOpen) {
                bloc.panelController.close();
                return false;
              }
              return true;
            },
            child: SlidingUpPanel(
              panelBuilder: (scrollController) =>
                  _panel(scrollController, context, state),
              controller: bloc.panelController,
              backdropEnabled: true,
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).scaffoldBackgroundColor,
              minHeight: 0,
              maxHeight: 4 *
                  (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top) /
                  5,
              body: CustomScrollView(
                controller: bloc.scrollController,
                slivers: <Widget>[
                  SliverPersistentHeader(
                    floating: true,
                    pinned: true,
                    delegate: APSliverAppBar(
                      maxExtent: max(
                          12 * MediaQuery.of(context).size.height / 50, 200),
                      minExtent:
                          max(MediaQuery.of(context).size.height / 12, 70) +
                              MediaQuery.of(context).padding.top,
                      isFavorite: state.isFavorite,
                      from: state.from,
                      destination: state.destination,
                      date: state.date,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  if (state.timeTableLoading == true) ...[
                    const SliverToBoxAdapter(
                      child: Center(
                        child: LoadingIndicator(
                          dotRadius: 3.41,
                          radius: 8,
                        ),
                      ),
                    ),
                  ] else if (state.timeTableInitialized == true) ...[
                    SliverToBoxAdapter(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45.0, vertical: 10),
                      child: Row(
                        children: const [
                          SizedBox(width: 25),
                          Icon(
                            Icons.access_time,
                            color: Colors.transparent,
                          ),
                          SizedBox(width: 5),
                          Text("Odhod: "),
                          Spacer(),
                          Text("Prihod:"),
                          SizedBox(width: 25),
                        ],
                      ),
                    )),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => APListTile(
                          blocProvider: BlocProvider.of<TimetableBloc>(context),
                          key: index == 0 ? state.globalKey : null,
                          ride: state.rideList![index],
                          index: index,
                          onTap: () => BlocProvider.of<TimetableBloc>(context)
                              .showDetailsPanel(index),
                          nextRide: state.nextRide,
                        ),
                        childCount: state.rideList!.length,
                      ),
                    ),
                  ],
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _panel(
    ScrollController sc,
    BuildContext context,
    TimetableState state,
  ) {
    if (state.selectedRide == null || state.selectedRide!.startTime == null) {
      return const SizedBox();
    }
    final MyColors myColors = Theme.of(context).extension<MyColors>()!;
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[300]
                        : Colors.black26,
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Expanded(
              child: ListView(
                controller: sc,
                children: <Widget>[
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 25.0),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Expanded(
                                    child: Text(
                                      state.selectedRide!.from,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: myColors.secondLocationColor,
                                  ),
                                  Expanded(
                                    child: Text(
                                      state.selectedRide!.destination,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(state.selectedRide!.startTime!),
                              Text(state.selectedRide!.endTime!),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${state.selectedRide!.duration!} min'),
                              Text(state.selectedRide!.distance!),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(state.selectedRide!.price!),
                              Text(
                                state.selectedRide!.busCompany!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              if (state.selectedRide!.lane! != "/") ...[
                                const SizedBox(height: 10.0),
                                Text(state.selectedRide!.lane!),
                              ]
                            ],
                          ),
                        ),
                        const SizedBox(width: 25.0),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  if (state.failure != null &&
                      state.failure is LoadStationsFailure) ...[
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Pridobivanje postaj ni uspelo",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.)),
                            onPressed: () =>
                                BlocProvider.of<TimetableBloc>(context)
                                    .retryLoadingStations(),
                            child: const Text(
                              "Poskusite znova.",
                            ),
                          ),
                        ],
                      ),
                    )
                  ] else if (state.selectedRide!.routeStops == null) ...[
                    const Center(
                      child: LoadingIndicator(radius: 8, dotRadius: 3.41),
                    ),
                  ] else ...[
                    ApStops(
                      routeStops: state.selectedRide!.routeStops!,
                      from: state.from,
                      destination: state.destination,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ));
  }
}
