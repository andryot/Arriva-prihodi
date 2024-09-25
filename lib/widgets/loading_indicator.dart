import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/loading_indicator/loading_indicator_bloc.dart';
import '../style/colors.dart';

class LoadingIndicator extends StatelessWidget {
  final double radius;
  final double dotRadius;

  const LoadingIndicator(
      {Key? key, required this.radius, required this.dotRadius})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoadingIndicatorBloc>(
      create: (context) => LoadingIndicatorBloc(),
      child: _LoadingIndicator(radius: radius, dotRadius: dotRadius),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  final double radius;
  final double dotRadius;

  const _LoadingIndicator(
      {Key? key, required this.radius, required this.dotRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> colors =
        BlocProvider.of<LoadingIndicatorBloc>(context).state.colors;

    return BlocBuilder<LoadingIndicatorBloc, LoadingIndicatorState>(
      builder: (context, state) {
        return SizedBox(
          height: radius * 2.5,
          width: radius * 2.5,
          child: Center(
              child: Stack(
            children: [
              Transform.translate(
                offset: Offset(radius * cos(pi / 4), radius * sin(pi / 4)),
                child: Dot(
                  radius: dotRadius,
                  color: APColor.resolveColor(context, colors[0]),
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(2 * pi / 4), radius * sin(2 * pi / 4)),
                child: Dot(
                  radius: dotRadius,
                  color: APColor.resolveColor(context, colors[1]),
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(3 * pi / 4), radius * sin(3 * pi / 4)),
                child: Dot(
                  radius: dotRadius,
                  color: APColor.resolveColor(context, colors[2]),
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(4 * pi / 4), radius * sin(4 * pi / 4)),
                child: Dot(
                  radius: dotRadius,
                  color: APColor.resolveColor(context, colors[3]),
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(5 * pi / 4), radius * sin(5 * pi / 4)),
                child: Dot(
                  radius: dotRadius,
                  color: APColor.resolveColor(context, colors[4]),
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(6 * pi / 4), radius * sin(6 * pi / 4)),
                child: Dot(
                  radius: dotRadius,
                  color: APColor.resolveColor(context, colors[5]),
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(7 * pi / 4), radius * sin(7 * pi / 4)),
                child: Dot(
                  radius: dotRadius,
                  color: APColor.resolveColor(context, colors[6]),
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(8 * pi / 4), radius * sin(8 * pi / 4)),
                child: Dot(
                  radius: dotRadius,
                  color: APColor.resolveColor(context, colors[7]),
                ),
              ),
            ],
          )),
        );
      },
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;
  const Dot({Key? key, required this.radius, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
