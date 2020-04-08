import 'package:flutter/material.dart';
import 'package:jptapp/core/constants/colors.dart';
import 'package:jptapp/features/list_items_data/presentation/pages/list_items_page.dart';

class LoginPageButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ListItemsPage()));
        },
        padding: EdgeInsets.all(12),
        color: MyColors.loginButtonColor,
        child: Text('Log In',
            style: TextStyle(color: MyColors.loginButtonTextColor)),
      ),
    );
  }
}
