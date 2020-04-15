part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  @override
  List<Object> get props => [];
}

class ThemeChange extends ThemeEvent {
  final AppTheme theme;

  ThemeChange({@required this.theme});
}