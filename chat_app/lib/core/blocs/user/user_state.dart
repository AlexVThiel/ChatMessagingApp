part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

class UsersLodingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UsersLoadedState extends UserState {
  final List<UserModel> usersList;
  UsersLoadedState(this.usersList);
  @override
  List<Object?> get props => [usersList];
/*  final Message message;

  ChatLoadedState(this.message);

  @override
  List<Object?> get props => [message];*/
}

class UsersErrorState extends UserState {
  final String error;

  UsersErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
