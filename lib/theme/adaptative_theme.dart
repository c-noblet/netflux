import 'package:flutter/material.dart';

final setLightTheme = _buildLightTheme();
final setDarkTheme = _buildDarkTheme();

ThemeData _buildLightTheme() {
  return ThemeData(
    primarySwatch: Colors.blue,
  );
}

ThemeData _buildDarkTheme() {
  return ThemeData(
    primarySwatch: Colors.red,
  );
}
