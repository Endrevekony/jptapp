import 'package:flutter/material.dart';
import 'package:jptapp/features/login_validation/presentation/widgets/widgets.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            LoginPageAnimation(),
            SizedBox(height: 48.0),
            LoginPageEmail(),
            SizedBox(height: 8.0),
            LoginPagePassword(),
            SizedBox(height: 24.0),
            LoginPageButton(),
            SizedBox(height: 8.0),
            LoginPageErrorMessage()
          ],
        ),
      ),
    );
  }
}
