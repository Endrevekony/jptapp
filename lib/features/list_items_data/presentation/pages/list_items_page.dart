import 'package:flutter/material.dart';
import 'package:jptapp/core/constants/colors.dart';

class ListItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Items'),
        backgroundColor: MyColors.appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
