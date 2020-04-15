import 'dart:async';
import 'package:bloc/bloc.dart';
import '../change_theme.dart';
import './bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState =>
      ThemeState(themeData: appThemeData[AppTheme.Light]);

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event,) async* {
    if (event is ThemeChanged) {
      yield ThemeState(themeData: appThemeData[event.theme]);
    }
  }
}
