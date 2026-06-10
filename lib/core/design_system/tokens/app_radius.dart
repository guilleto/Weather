import 'package:flutter/material.dart';

abstract class AppRadius {
  static const double small = 4.0;
  static const double medium = 8.0;
  static const double large = 16.0;

  static const BorderRadius smallAll = BorderRadius.all(Radius.circular(small));
  static const BorderRadius mediumAll = BorderRadius.all(Radius.circular(medium));
  static const BorderRadius largeAll = BorderRadius.all(Radius.circular(large));
}
