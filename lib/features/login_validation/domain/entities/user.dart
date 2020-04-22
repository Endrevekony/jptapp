import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jptapp/core/constants/value_objects.dart';
import 'package:jptapp/core/errors/failures.dart';
import 'package:jptapp/features/login_validation/domain/entities/value_objects.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User implements IEntity {
  const factory User({
    @required UniqueId id,
    @required StringSingleLine name,
    @required EmailAddress emailAddress,
  }) = _User;
}

extension UserX on User {
  Option<ValueFailure<dynamic>> get failureOption {
    return name.failureOrUnit
        .andThen(emailAddress.failureOrUnit)
        .fold((l) => some(l), (r) => none());
  }
}