import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../bloc/global/global_bloc.dart';
import '../bloc/timetable/timetable_bloc.dart';
import '../services/backend_service.dart';
import '../util/parser.dart';
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
          print(MediaQuery.of(context).size.height);
          return SlidingUpPanel(
            body: CustomScrollView(
              controller: bloc.scrollController,
              //physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  delegate: APSliverAppBar(
                    maxExtent: max(MediaQuery.of(context).size.height / 5, 200),
                    minExtent:
                        max(MediaQuery.of(context).size.height / 12, 70) +
                            MediaQuery.of(context).padding.top,
                    isFavorite: state.isFavorite,
                    from: state.from,
                    destination: state.destination,
                    date: APParser.dateToString(state.date),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 30,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => APListTile(
                      ride: state.rideList![index],
                      index: index,
                      onTap: () => BlocProvider.of<TimetableBloc>(context)
                          .showDetailsPanel(index),
                    ),
                    childCount: state.rideList!.length,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50,
                  ),
                ),
              ],
            ),
            panelBuilder: (scrollController) =>
                _panel(scrollController, context, state),
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
    if (state.selectedRide == null || state.selectedRide!.startTime == null) {
      return const SizedBox();
    }

    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            const SizedBox(height: 12.0),
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
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 15.0),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        state.selectedRide!.from,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5.0),
                      Transform.rotate(
                        angle: pi + pi / 2,
                        child: const Icon(
                          Icons.arrow_back,
                          size: 15,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        state.selectedRide!.destination,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(state.selectedRide!.startTime!),
                      const SizedBox(height: 10.0),
                      Text(state.selectedRide!.endTime!),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text('${state.selectedRide!.duration!} min'),
                      const SizedBox(height: 10.0),
                      Text(state.selectedRide!.distance!),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text(state.selectedRide!.price!),
                      const SizedBox(height: 10.0),
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
              ],
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
            if (state.selectedRide!.routeStops == null) ...[
              const Center(
                child: LoadingIndicator(radius: 8, dotRadius: 3.41),
              ),
            ] else ...[
              ApStops(
                routeStops: state.selectedRide!.routeStops!,
                from: state.from,
              ),
            ],
          ],
        ));
  }
}
