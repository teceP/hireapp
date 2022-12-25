import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFinals {
  static Color appBarColor = Colors.blue[800]!;
  static Color buttonColor = Colors.blue[800]!;
  static const Color frameColor = Colors.orange;

  static const double borderRadius = 10;
  static const double borderRadiusTextField = 30;

  static const double horizontalPadding = 20;
  static const double horizontalPaddingLess = 10;
  static const double horizontalPaddingTextField = 15;

  static const double verticalPadding = 15;
  static const double verticalPaddingAdditional = 5;
  static const double verticalPaddingTextField = 10;

  static const double elevation = 5;
  static const double textSizeButton = 16;

  static const String appName = 'Hire App';
  static const String appVersion = '7.2.0';
  static TextStyle appNameTextStyle = GoogleFonts.roboto();

  static const double commonButtonDistance = 10;
  static const double commonWidgetDistance = 10;

  static const double iconInTextSize = 16;
  static const double paddingInText = 6;

  ///Following statics are used for search filtering
  static const int minDistance = 1;
  static const int maxDistance = 50;
  static const int defaultDistance = 20;
}
