import 'package:flutter/material.dart';
import 'package:jptapp/core/constants/colors.dart';
import 'package:jptapp/features/settings/change_language/app_localization.dart';
class LoginPagePassword extends StatefulWidget {
  @override
  _LoginPagePasswordState createState() => _LoginPagePasswordState();
}

class _LoginPagePasswordState extends State<LoginPagePassword> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          fillColor: MyColors.loginFieldColor,
          hintText: allTranslations.text('password'),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        )
    );
  }
}