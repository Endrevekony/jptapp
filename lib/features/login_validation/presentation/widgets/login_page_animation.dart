import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class LoginPageAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 250.0,
        width: 250.0,
        child: FlareActor("assets/intro.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: "coding"),);
  }
}
