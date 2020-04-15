import 'package:flutter/material.dart';
enum AppTheme {
  Light,
  Dark,
}
final appThemeData = {
    AppTheme.Dark: ThemeData.dark(),
    AppTheme.Light: ThemeData.light(),
  };