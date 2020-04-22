import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jptapp/features/login_validation/presentation/bloc/bloc.dart';
import 'package:jptapp/features/list_items_data/presentation/pages/list_items_page.dart';
import 'package:jptapp/features/login_validation/presentation/pages/login_page.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          authenticated: (_) =>
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ListItemsPage()),
              ),
          unauthenticated: (_) =>
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              ),
        );
      },
      child: _PageWidget(),
    );
  }
}

class _PageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}