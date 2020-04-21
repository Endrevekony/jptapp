import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/core/constants/colors.dart';
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
                new Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(allTranslations.text('light')),
                      onTap: () {
                        BlocProvider.of<ThemeBloc>(context)
                            .add(ThemeChanged(theme: AppTheme.Light));
                      },
                    ),
                    ListTile(
                      title: Text(allTranslations.text('dark')),
                      onTap: () {
                        BlocProvider.of<ThemeBloc>(context)
                            .add(ThemeChanged(theme: AppTheme.Dark));
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
                  title: Text('English'),
                  onTap: () {
                    changeLanguage(lang: 'en');
                  },
                ),
                ListTile(
                  title: Text('Magyar'),
                  onTap: () {
                    changeLanguage(lang: 'hu');
                  },
                ),
                ListTile(
                  title: Text('Srpski'),
                  onTap: () {
                    changeLanguage(lang: 'rs');
                  },
                ),
              ],
            ),
            SizedBox(height: 10.0),
            ListTile(
              leading: Icon(Icons.exit_to_app,
                  color: MyColors.logOutButtonIconColor),
              title: Text(allTranslations.text('logout')),
              onTap: () {
                //Logout
              },
            ),
          ],
        ).toList(),
      ),
    );
  }
}
