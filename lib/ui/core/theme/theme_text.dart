import 'package:flutter/material.dart';

class Themetext {
  Themetext._();

  // Font sizes
  static const double smallSize = 13.0;
  static const double mediumSize = 15.0;
  static const double largeSize = 18.0;
  static const double extraLargeSize = 24.0;

  // TextTheme for global usage
  static TextTheme textTheme = const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Roboto',
      fontSize: extraLargeSize,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: mediumSize,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Roboto',
      fontSize: smallSize,
      fontWeight: FontWeight.w400,
    ),
  );

  // Additional reusable text styles
  static TextStyle headline = const TextStyle(
    fontFamily: 'Roboto',
    fontSize: largeSize,
    fontWeight: FontWeight.w600,
  );

  static TextStyle superHeadline = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle subheadline = const TextStyle(
    fontFamily: 'Roboto',
    fontSize: largeSize,
    fontWeight: FontWeight.bold,
  );

  static TextStyle greyText = const TextStyle(
    fontFamily: 'Roboto',
    fontSize: mediumSize,
    fontWeight: FontWeight.w400,
    color: Color(0xFF9E9E9E),
  );

  static TextStyle whiteText = const TextStyle(
    fontFamily: 'Roboto',
    fontSize: mediumSize,
    fontWeight: FontWeight.w500,
    color: Color(0xFFFFFFFF),
  );

  static TextStyle blackBoldText = const TextStyle(
    fontFamily: 'Roboto',
    fontSize: mediumSize,
    fontWeight: FontWeight.w700,
    color: Color(0xFF000000),
  );
}
