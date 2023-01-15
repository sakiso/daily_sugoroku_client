import 'package:flutter/material.dart';

class Settings {
  /// セキュア情報はsecure_storageを使うこと
  static int currentDBversion = 2;
}

class ConstantColors {
  static Color lightBlue = const Color.fromARGB(255, 134, 193, 245);
  static Color royalBlue = const Color.fromARGB(255, 60, 105, 225);
  static Color darkGray = const Color.fromARGB(255, 91, 91, 91);
  static Color inactiveGray = const Color.fromARGB(255, 224, 224, 224);
  static Color green = const Color.fromARGB(255, 89, 181, 94);
}

class TableNames {
  static String plans = 'plans';
}
