import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jptapp/core/errors/failures.dart';
import 'package:jptapp/core/use_cases/usecase.dart';
import 'package:jptapp/features/login_validation/domain/entities/login_validation.dart';
import 'package:jptapp/features/login_validation/domain/repositories/login_validation_repository.dart';
import 'package:meta/meta.dart';

class GetLoginValidation implements UseCase<LoginValidation, Params> {
  final LoginValidationRepository repository;

  GetLoginValidation(this.repository);

  @override
  Future<Either<Failure, LoginValidation>> call(Params params) async =>
      await repository.getLoginValidation(params.email,params.password);
}

class Params extends Equatable {
  final String email;
  final String password;

  Params({@required this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
