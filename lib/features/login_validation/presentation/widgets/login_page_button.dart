import 'package:flutter/material.dart';
import 'package:jptapp/core/constants/colors.dart';
import 'package:jptapp/features/list_items_data/presentation/pages/list_items_page.dart';
import 'package:jptapp/features/settings/change_language/app_localization.dart';

class LoginPageButton extends StatefulWidget {
  @override
  _LoginPageButtonState createState() => _LoginPageButtonState();
}

class _LoginPageButtonState extends State<LoginPageButton> {

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ListItemsPage()));
        },
        padding: EdgeInsets.all(12),
        color: MyColors.loginButtonColor,
        child: Text(
          allTranslations.text('login'),
          style: TextStyle(color: MyColors.loginButtonTextColor),
        ),
      ),
    );
  }
}
