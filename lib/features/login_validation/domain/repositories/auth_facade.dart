import 'package:dartz/dartz.dart';
import 'package:jptapp/features/login_validation/domain/entities/value_objects.dart';
import 'package:jptapp/features/login_validation/domain/use_cases/auth_failure.dart';
import 'package:meta/meta.dart';

abstract class AuthFacade {
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required Password password,
  });
}
