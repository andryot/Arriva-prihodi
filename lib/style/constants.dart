import 'dart:math';

import 'package:flutter/widgets.dart';

const String githubUrl = 'https://github.com/andryot/Arriva-prihodi';

const String appVersion = '2.0.4';

const String apiKey = "R300_VozniRed_2015";

double getLogoSize(BuildContext context) => min(
      150.0,
      MediaQuery.of(context).size.width / 3 * 2,
    );
