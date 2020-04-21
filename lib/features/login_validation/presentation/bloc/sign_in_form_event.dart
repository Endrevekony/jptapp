import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_form_event.freezed.dart';

@freezed
abstract class SignInFormEvent with _$SignInFormEvent {
  // Notice that these events take in "raw" unvalidated Strings
  const factory SignInFormEvent.emailChanged(String emailStr) = EmailChanged;

  const factory SignInFormEvent.passwordChanged(String passwordStr) =
      PasswordChanged;

  const factory SignInFormEvent.signInWithEmailAndPasswordPressed() =
      SignInWithEmailAndPasswordPressed;
}
