part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthLodingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthUninitialized extends AuthState {
  final bool auth;

  AuthUninitialized(this.auth);
  @override
  List<Object> get props => [auth];
}

class IsSingIn extends AuthState {
  final bool isSingIn;

  IsSingIn(this.isSingIn);
  @override
  List<Object> get props => [isSingIn];
}

class IsSingUp extends AuthState {
  final String uid;

  IsSingUp(this.uid);
  @override
  List<Object> get props => [uid];
}

class AuthAuthenticated extends AuthState {
  final bool auth;

  AuthAuthenticated(this.auth);

  @override
  List<Object?> get props => [auth];
}

class AuthUnauthenticated extends AuthState {
  final String error;
  AuthUnauthenticated(this.error);

  @override
  List<Object?> get props => [error];
}
