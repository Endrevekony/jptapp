import 'package:dartz/dartz.dart';
import 'package:jptapp/core/errors/failures.dart';
import 'package:jptapp/features/login_validation/domain/entities/login_validation.dart';

abstract class LoginValidationRepository {
  Future<Either<Failure, LoginValidation>> getLoginValidation (
      String email, String password);
}
