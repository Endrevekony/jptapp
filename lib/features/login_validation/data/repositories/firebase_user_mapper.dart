
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:jptapp/core/constants/value_objects.dart';
import 'package:jptapp/features/login_validation/domain/entities/user.dart';
import 'package:jptapp/features/login_validation/domain/entities/value_objects.dart';

@lazySingleton
class FirebaseUserMapper {
  User toDomain(FirebaseUser _) {
    return _ == null
        ? null
        : User(
      id: UniqueId.fromUniqueString(_.uid),
      name: StringSingleLine(_.displayName ?? _.email.split('@').first),
      emailAddress: EmailAddress(_.email),
    );
  }
}