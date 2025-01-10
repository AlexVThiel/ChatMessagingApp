part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignUp extends AuthEvent {
  const SignUp(this.email, this.pass);
  final String email;
  final String pass;
  @override
  List<Object?> get props => [email, pass];
}

class SignIn extends AuthEvent {
  const SignIn(this.email, this.pass);
  final String email;
  final String pass;
  @override
  List<Object?> get props => [email, pass];
}

class CheckAuth extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoggedOut extends AuthEvent {
  @override
  List<Object> get props => [];
}
