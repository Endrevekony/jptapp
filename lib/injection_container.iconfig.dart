// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:jptapp/features/login_validation/data/models/firebase_injectable_module.dart';
import 'package:jptapp/features/login_validation/data/repositories/firebase_user_mapper.dart';
import 'package:jptapp/features/login_validation/data/repositories/firebase_auth_facade.dart';
import 'package:jptapp/features/login_validation/domain/repositories/auth_facade.dart';
import 'package:jptapp/features/login_validation/presentation/bloc/sign_in_form_bloc.dart';
import 'package:jptapp/features/login_validation/presentation/bloc/auth_bloc_bloc.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  g.registerLazySingleton<FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  g.registerLazySingleton<FirebaseUserMapper>(() => FirebaseUserMapper());
  g.registerFactory<SignInFormBloc>(() => SignInFormBloc(g<AuthFacade>()));
  g.registerFactory<AuthBloc>(() => AuthBloc(g<AuthFacade>()));

  //Register prod Dependencies --------
  if (environment == 'prod') {
    g.registerLazySingleton<AuthFacade>(
        () => FirebaseAuthFacade(g<FirebaseAuth>(), g<FirebaseUserMapper>()));
  }
}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}
