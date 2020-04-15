import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/core/constants/globals.dart';
import 'package:jptapp/features/settings/change_theme/bloc/bloc.dart';
import 'package:jptapp/features/settings/change_theme/bloc/theme_bloc.dart';
import 'package:jptapp/features/settings/change_theme/change_theme.dart';

class ThemeChangerAnimationButton extends StatefulWidget {
  @override
  _ThemeChangerAnimationButtonState createState() =>
      _ThemeChangerAnimationButtonState();
}

class _ThemeChangerAnimationButtonState
    extends State<ThemeChangerAnimationButton> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65,
      child: GestureDetector(
        onTap: () {
          setState(
            () {
              if (Globals.isDark == true) {
                Globals.isDark = false;
                BlocProvider.of<ThemeBloc>(context)
                    .add(ThemeChanged(theme: AppTheme.Light));
              } else if (Globals.isDark == false) {
                Globals.isDark = true;
                BlocProvider.of<ThemeBloc>(context)
                    .add(ThemeChanged(theme: AppTheme.Dark));
              }
            },
          );
        },
        child: FlareActor(
          'assets/switch_daytime.flr',
          animation: (Globals.isDark == true) ? 'night_idle' : 'day_idle',
        ),
      ),
    );
  }
}
