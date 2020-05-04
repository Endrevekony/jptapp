import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/core/constants/colors.dart';
import 'package:jptapp/features/login_validation/presentation/pages/login_page.dart';
import 'package:jptapp/features/settings/change_language/app_localization.dart';
import 'package:jptapp/features/settings/change_theme/bloc/bloc.dart';
import 'package:jptapp/features/settings/change_theme/bloc/theme_bloc.dart';
import 'package:jptapp/features/settings/change_theme/change_theme.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void changeLanguage({@required String lang}) {
    setState(
      () async {
        await allTranslations.setNewLanguage(lang);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Settings()),
        );
      },
    );
  }

  Widget selectedLanguageCheck(String current) {
    if (allTranslations.currentLanguage == current) {
      return Icon(Icons.check);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context, false),
        ),
        centerTitle: true,
        backgroundColor: MyColors.appBarColor,
        title: Text(
          allTranslations.text('settings'),
        ),
      ),
      body: Column(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ExpansionTile(
              leading: Icon(Icons.chrome_reader_mode),
              title: Text(allTranslations.text('themes')),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(allTranslations.text('light')),
                      trailing: selectedDark ? null : Icon(Icons.check),
                      onTap: () {
                        BlocProvider.of<ThemeBloc>(context)
                            .add(const ThemeChanged(theme: AppTheme.light));
                        selectedDark = false;
                      },
                    ),
                    ListTile(
                      title: Text(allTranslations.text('dark')),
                      trailing: selectedDark ? Icon(Icons.check) : null,
                      onTap: () {
                        BlocProvider.of<ThemeBloc>(context)
                            .add(const ThemeChanged(theme: AppTheme.dark));
                        selectedDark = true;
                      },
                    ),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.language),
              title: Text(allTranslations.text('languages')),
              children: <Widget>[
                ListTile(
                  title: const Text('English'),
                  trailing: selectedLanguageCheck('en'),
                  onTap: () {
                    changeLanguage(lang: 'en');
                  },
                ),
                ListTile(
                  title: const Text('Magyar'),
                  trailing: selectedLanguageCheck('hu'),
                  onTap: () {
                    changeLanguage(lang: 'hu');
                  },
                ),
                ListTile(
                  title: const Text('Srpski'),
                  trailing: selectedLanguageCheck('rs'),
                  onTap: () {
                    changeLanguage(lang: 'rs');
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            ListTile(
              leading: Icon(Icons.exit_to_app,
                  color: MyColors.logOutButtonIconColor),
              title: Text(allTranslations.text('logout')),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ).toList(),
      ),
    );
  }
}
