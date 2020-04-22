import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/core/constants/colors.dart';
import 'package:jptapp/features/login_validation/presentation/bloc/bloc.dart';
import 'package:jptapp/features/list_items_data/presentation/pages/list_items_page.dart';
import 'package:jptapp/features/settings/change_language/app_localization.dart';

import 'login_page_animation.dart';

// ignore: must_be_immutable
class SignInForm extends StatelessWidget {
  String errorMessage = '';
  SignInForm({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) {
            either.fold(
              (failure) {
                errorMessage = failure.map(
                  invalidEmailAndPasswordCombination: (_) =>
                  'Invalid email and password combination',
                  serverError: (_) => 'Server error',
                );
              },
              (_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ListItemsPage()),
                );
                context
                    .bloc<AuthBloc>()
                    .add(const AuthEvent.authCheckRequested());
              },
            );
          },
        );
      },
      builder: (context, state) {
        return Form(
          autovalidate: state.showErrorMessages,
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
              const SizedBox(height: 60),
              LoginPageAnimation(),
              const SizedBox(height: 26),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                ),
                autocorrect: false,
                onChanged: (value) => context
                    .bloc<SignInFormBloc>()
                    .add(SignInFormEvent.emailChanged(value.trim())),
                validator: (_) => context
                    .bloc<SignInFormBloc>()
                    .state
                    .emailAddress
                    .value
                    .fold(
                      (f) => f.maybeMap(
                        invalidEmail: (_) =>
                            allTranslations.text('invalid_email'),
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                // controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: allTranslations.text('password'),
                ),
                obscureText: true,
                autocorrect: false,
                onChanged: (value) => context
                    .bloc<SignInFormBloc>()
                    .add(SignInFormEvent.passwordChanged(value)),
                validator: (_) =>
                    context.bloc<SignInFormBloc>().state.password.value.fold(
                          (f) => f.maybeMap(
                            shortPassword: (_) =>
                                allTranslations.text('short_password'),
                            orElse: () => null,
                          ),
                          (_) => null,
                        ),
              ),
              const SizedBox(height: 15),
              Center(
                  child: Text(
                errorMessage,
                style: TextStyle(color: MyColors.errorMessage),
              )),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                onPressed: () => context.bloc<SignInFormBloc>().add(
                    const SignInFormEvent.signInWithEmailAndPasswordPressed()),
                padding: EdgeInsets.all(12),
                color: MyColors.loginButtonColor,
                child: Text(
                  allTranslations.text('login'),
                  style: TextStyle(color: MyColors.loginButtonTextColor),
                ),
              ),
              if (state.isSubmitting) ...[
                const SizedBox(height: 15),
                const LinearProgressIndicator(value: null),
              ]
            ],
          ),
        );
      },
    );
  }
}
