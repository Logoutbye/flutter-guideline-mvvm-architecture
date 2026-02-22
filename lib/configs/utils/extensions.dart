import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get mediaQueryHeight => MediaQuery.sizeOf(this).height;
  double get mediaQueryWidth => MediaQuery.sizeOf(this).width;
}

extension EmptySpace on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}

extension NumberFormatter on num {
  /// Converts a number into a short readable format, e.g. 1k, 1.2M, etc.
  String get viewCountFormatted {
    if (this >= 1000000000) {
      return "${(this / 1000000000).toStringAsFixed(1)}B"; // Billions
    } else if (this >= 1000000) {
      return "${(this / 1000000).toStringAsFixed(1)}M"; // Millions
    } else if (this >= 1000) {
      return "${(this / 1000).toStringAsFixed(1)}k"; // Thousands
    } else {
      return toString(); // Less than 1000, no formatting
    }
  }
}
