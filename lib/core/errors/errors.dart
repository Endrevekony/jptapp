import 'package:jptapp/core/errors/failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueError;

  UnexpectedValueError(this.valueError);

  @override
  String toString() {
    const explanation =
        'Encountered a Value Failure at an unrecoverable point. ';
    return Error.safeToString(' $explanation Failure was $valueError');
  }
}
