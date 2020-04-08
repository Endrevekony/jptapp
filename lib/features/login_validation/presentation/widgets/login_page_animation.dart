import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class LoginPageAnimation extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        height: 250.0,
        width: 250.0,
        child: new FlareActor("assets/intro.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: "coding"));
  }
}
