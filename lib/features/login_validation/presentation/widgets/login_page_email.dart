import 'package:flutter/material.dart';
import 'package:jptapp/core/constants/colors.dart';

class LoginPageEmail extends StatefulWidget {
  String email;
  @override
  _LoginPageEmailState createState() => _LoginPageEmailState();
}

class _LoginPageEmailState extends State<LoginPageEmail> {
  final myController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        fillColor: MyColors.loginFieldColor,
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
  }
}


