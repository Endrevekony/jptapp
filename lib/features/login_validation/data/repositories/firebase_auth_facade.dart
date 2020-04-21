import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:jptapp/features/login_validation/domain/entities/value_objects.dart';
import 'package:jptapp/features/login_validation/domain/repositories/auth_facade.dart';
import 'package:jptapp/features/login_validation/domain/use_cases/auth_failure.dart';

@lazySingleton
@RegisterAs(AuthFacade)
class FireBaseAuthFacade implements AuthFacade {
  final FirebaseAuth _firebaseAuth;

  FireBaseAuthFacade(this._firebaseAuth);

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {@required EmailAddress emailAddress,
      @required Password password}) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailAddressStr, password: passwordStr);
      return right(unit);
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_USER_NOT_FOUND' ||
          e.code == 'ERROR_WRONG_PASSWORD') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }
}
