import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../change_theme.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;

  const ThemeChanged({
    @required this.theme,
  });

  @override
  List<Object> get props => [theme];
}