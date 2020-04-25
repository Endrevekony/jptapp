import 'package:flutter/material.dart';

enum AppTheme {
  light,
  dark,
}
final Map<AppTheme, ThemeData> appThemeData = {
    AppTheme.dark: ThemeData.dark(),
    AppTheme.light: ThemeData.light(),
  };

bool selectedDark = false;