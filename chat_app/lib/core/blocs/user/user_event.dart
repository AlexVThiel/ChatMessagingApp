part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUsers extends UserEvent {
  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent {
  @override
  List<Object> get props => [];
}

class SearchUsers extends UserEvent {
  const SearchUsers(this.search);
  final String search;
  @override
  List<Object> get props => [search];
}

class UpdateRoom extends UserEvent {
  const UpdateRoom(this.rid, this.room);
  final String rid;
  final String room;
  @override
  List<Object> get props => [rid, room];
}

/*class SignIn extends AuthEvent {
  const SignIn(this.email, this.pass);
  final String email;
  final String pass;
  @override
  List<Object?> get props => [email, pass];
} */
