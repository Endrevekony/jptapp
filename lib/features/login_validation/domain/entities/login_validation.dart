import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class LoginValidation extends Equatable {
  final String email;
  final String password;

  LoginValidation({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
