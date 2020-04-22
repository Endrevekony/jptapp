import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jptapp/features/login_validation/domain/entities/user.dart';

part 'auth_bloc_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.authenticated(User user) = Authenticated;
  const factory AuthState.unauthenticated() = Unauthenticated;
}

