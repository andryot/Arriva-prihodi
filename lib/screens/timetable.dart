import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/global/global_bloc.dart';
import '../bloc/timetable/timetable_bloc.dart';
import '../services/backend_service.dart';
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
      child: _TimetableScreen(),
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
          if (state.isLoading == true) {
            return Center(
              child: LoadingIndicator(
                dotRadius: 8,
                radius: 24,
              ),
            );
          }
          if (state.failure != null || state.initialized == false) {
            return Center(child: Text("Napaka!"));
          }

          return CustomScrollView(
            //physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                leading: CupertinoButton(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: Navigator.of(context).pop,
                ),
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Card(
                      child: Text(state.rideList![index].from),
                    );
                  },
                  childCount: state.rideList!.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
