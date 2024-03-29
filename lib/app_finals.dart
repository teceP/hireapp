import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFinals {
  static Color primaryColorDark = Color.fromARGB(255, 19, 86, 21);

  static Color primaryColor = Color.fromARGB(255, 90, 165, 92);
  static Color secondaryColor = Color.fromARGB(255, 112, 184, 115);
  static Color thirdColor = Color.fromARGB(255, 218, 233, 219);
  static Color thirdColorGreyed = Color.fromARGB(255, 154, 174, 155);
  static Color thirdColorGreened = Color.fromARGB(255, 91, 126, 94);

  static Color backgroundColor = Colors.grey[50]!;

  static Color appBarColor = Colors.white; //Colors.blue[800]!;
  static Color buttonColor = Colors.blue[800]!;
  static const Color frameColor = Colors.transparent;

  static const double borderRadius = 10;
  static const double borderRadiusTextField = 30;

  static const double horizontalPadding = 20;
  static const double horizontalPaddingLess = 10;
  static const double horizontalPaddingTextField = 15;

  static const double verticalPadding = 15;
  static const double verticalPaddingAdditional = 5;
  static const double verticalPaddingTextField = 10;
  static const double bottomSafeAreaPadding = 40;

  static const double elevation = 2;
  static const double textSizeButton = 16;

  static const String appName = 'Hire App';
  static const String appVersion = '7.2.0';
  static TextStyle appNameTextStyle = GoogleFonts.roboto();

  static const double commonButtonDistance = 10;
  static const double commonWidgetDistance = 10;

  static const double iconSize = 30;
  static const double iconInTextSize = 16;
  static const double paddingInText = 6;

  static const Duration animationDuration = Duration(milliseconds: 300);

  ///Common small widgets
  static const Widget navigageNextIcon = Icon(
    Icons.navigate_next,
    size: AppFinals.iconSize,
  );

  static const Widget navigageNextIconWhite = Icon(
    Icons.navigate_next,
    size: AppFinals.iconSize,
    color: Colors.white,
  );

  ///Following statics are used for search filtering
  static const int minDistance = 1;
  static const int maxDistance = 50;
  static const int defaultDistance = 20;

  static const double minPrice = 1;
  static const double maxPrice = 500;
}
