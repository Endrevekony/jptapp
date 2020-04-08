import 'package:flutter/material.dart';
import 'package:jptapp/features/login_validation/presentation/pages/login_page.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}