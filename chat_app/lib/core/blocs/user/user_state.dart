part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

class LodingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UsersLoadedState extends UserState {
  final List<UserM> usersList;
  UsersLoadedState(this.usersList);
  @override
  List<Object?> get props => [usersList];
/*  final Message message;

  ChatLoadedState(this.message);

  @override
  List<Object?> get props => [message];*/
}

class UserUpdated extends UserState {
  @override
  List<Object?> get props => [];
/*  final Message message;

  ChatLoadedState(this.message);

  @override
  List<Object?> get props => [message];*/
}

class UserLoadedState extends UserState {
  final UserM user;
  UserLoadedState(this.user);
  @override
  List<Object?> get props => [user];
/*  final Message message;

  ChatLoadedState(this.message);

  @override
  List<Object?> get props => [message];*/
}

class ErrorState extends UserState {
  final String error;

  ErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
