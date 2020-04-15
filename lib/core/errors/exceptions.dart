import 'package:flutter/foundation.dart';

class ServerException implements Exception {}

class CacheException implements Exception{}

class ValueException implements Exception{}

class InvalidEmailException implements Exception {
  final String failedValue;

  InvalidEmailException({@required this.failedValue});
}
