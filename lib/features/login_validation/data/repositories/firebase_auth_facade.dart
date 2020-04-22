import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:jptapp/features/login_validation/domain/entities/user.dart';
import 'package:jptapp/features/login_validation/domain/entities/value_objects.dart';
import 'package:jptapp/features/login_validation/domain/repositories/auth_facade.dart';
import 'package:jptapp/features/login_validation/domain/use_cases/auth_failure.dart';

import 'firebase_user_mapper.dart';

@prod
@lazySingleton
@RegisterAs(AuthFacade)
class FirebaseAuthFacade implements AuthFacade {
  final FirebaseAuth _firebaseAuth;
  final FirebaseUserMapper _firebaseUserMapper;

  FirebaseAuthFacade(
      this._firebaseAuth,
      this._firebaseUserMapper,
      );

  @override
  Future<Option<User>> getSignedInUser() async => _firebaseAuth
      .currentUser()
      .then((u) => optionOf(_firebaseUserMapper.toDomain(u)));


  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required Password password,
  }) async {
    final emailAddressStr = emailAddress.value.getOrElse(() => 'INVALID EMAIL');
    final passwordStr = password.value.getOrElse(() => 'INVALID PASSWORD');
    try {
      return await _firebaseAuth
          .signInWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      )
          .then((_) => right(unit));
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_WRONG_PASSWORD' ||
          e.code == 'ERROR_USER_NOT_FOUND') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      }
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }
}
