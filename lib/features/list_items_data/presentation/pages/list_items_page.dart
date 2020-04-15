import 'package:flutter/material.dart';
import 'package:jptapp/core/constants/colors.dart';
import 'package:jptapp/features/settings/change_language/app_localization.dart';
import 'package:jptapp/features/settings/pages/settings_page.dart';

class ListItemsPage extends StatefulWidget {
  @override
  _ListItemsPageState createState() => _ListItemsPageState();
}

class _ListItemsPageState extends State<ListItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          allTranslations.text('documents'),
        ),
        backgroundColor: MyColors.appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.floatingActionButtonColor,
          child: Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () async{
            await allTranslations.setNewLanguage('en');
            setState((){});
          }),
    );
  }
}
