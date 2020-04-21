import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

// ignore: must_be_immutable
abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

//General Failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.invalidEmail({
    @required T failedValue,
  }) = InvalidEmail<T>;

  const factory ValueFailure.shortPassword({
    @required T failedValue,
  }) = ShortPassword<T>;
}