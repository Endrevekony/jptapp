import 'package:flutter/material.dart';
import 'package:jptapp/core/constants/colors.dart';
import 'package:jptapp/features/settings/change_language/app_localization.dart';
import 'package:jptapp/features/settings/widgets/widgets.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              trailing: ThemeChangerAnimationButton(),
              title: Text(
                allTranslations.text('darkmode'),
              ),
            ),
            ListTile(
              trailing: LanguageDropDown(),
              title: Text(
                allTranslations.text('language'),
              ),
            ),
          ],
        ).toList(),
      ),
    );
  }
}
