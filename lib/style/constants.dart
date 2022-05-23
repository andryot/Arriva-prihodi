import 'dart:math';

import 'package:flutter/widgets.dart';

double getLogoSize(BuildContext context) =>
    min(150.0, MediaQuery.of(context).size.width / 3 * 2);
