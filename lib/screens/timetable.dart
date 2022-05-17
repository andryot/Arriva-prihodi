import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../bloc/global/global_bloc.dart';
import '../bloc/timetable/timetable_bloc.dart';
import '../services/backend_service.dart';
import '../widgets/ap_list_tile.dart';
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
        listener: (context, state) {},
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
          if (state.failure != null || state.initialized == false) {
            return const Center(child: Text("Napaka!"));
          }

          return SlidingUpPanel(
            body: CustomScrollView(
              //physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  leading: CupertinoButton(
                    onPressed: Navigator.of(context).pop,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  expandedHeight: 200,
                  flexibleSpace: const FlexibleSpaceBar(),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => APListTile(
                      ride: state.rideList![index],
                      index: index,
                    ),
                    childCount: state.rideList!.length,
                  ),
                ),
              ],
            ),
            panel: _panel(bloc.sc, context, state),
            controller: bloc.panelController,
            backdropEnabled: true,
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).backgroundColor,
            minHeight: 0,
            maxHeight: 4 *
                (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top) /
                5,
          );
        },
      ),
    );
  }

  Widget _panel(
      ScrollController sc, BuildContext context, TimetableState state) {
    if (state.selectedRide == null) {
      return const SizedBox();
    }

    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          //controller: sc,
          children: <Widget>[
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            const SizedBox(
              height: 18.0,
            ),
            Text(state.selectedRide!.from),
            Text(state.selectedRide!.destination),
            Text(state.selectedRide!.startTime),
            Text(state.selectedRide!.endTime),
            Text(state.selectedRide!.duration!),
            Text(state.selectedRide!.distance!),
            Text(state.selectedRide!.price!),
            Text(state.selectedRide!.busCompany!),
            Text(state.selectedRide!.lane!),
            if (state.selectedRide!.routeStops == null) ...[
              const Align(
                alignment: Alignment.center,
                child: LoadingIndicator(radius: 8, dotRadius: 3.41),
              ),
            ] else ...[
              ApStops(routeStops: state.selectedRide!.routeStops!),
            ],
          ],
        ));
  }
}
