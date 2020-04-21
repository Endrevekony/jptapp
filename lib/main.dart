import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:jptapp/features/login_validation/presentation/pages/login_page.dart';
import 'package:jptapp/features/settings/change_language/app_localization.dart';
import 'package:jptapp/features/settings/change_theme/bloc/bloc.dart';
import 'package:jptapp/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await allTranslations.init(ui.window.locale.languageCode);
  configureInjection(Environment.prod);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState(){
    super.initState();
    allTranslations.onLocaleChangedCallback = _onLocaleChanged;
  }

  _onLocaleChanged() async {
    print('Language has been changed to: ${allTranslations.currentLanguage}');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return new MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'JPT App',
            theme: state.themeData,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            // Tells the system which are the supported languages
            supportedLocales: allTranslations.supportedLocales(),
            home: LoginPage(),
          );
        },
      ),
    );
  }
}