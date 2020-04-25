import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/features/login_validation/presentation/bloc/bloc.dart';
import 'package:jptapp/features/login_validation/presentation/widgets/sign_in_form.dart';

import '../../../../injection_container.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocProvider(
        create: (context) => sl<SignInFormBloc>(),
        child: SignInForm(),
      ),
    );
  }
}