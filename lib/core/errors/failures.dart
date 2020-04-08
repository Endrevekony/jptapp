import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

//General Failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
