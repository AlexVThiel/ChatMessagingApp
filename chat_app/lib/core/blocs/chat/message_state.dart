part of 'chat_bloc.dart';

@immutable
abstract class ChatState extends Equatable {}

class ChatLodingState extends ChatState {
  @override
  List<Object?> get props => [];
}

class ChatLoadedState extends ChatState {
  @override
  List<Object?> get props => [];
/*  final Message message;

  ChatLoadedState(this.message);

  @override
  List<Object?> get props => [message];*/
}

class ChatErrorState extends ChatState {
  final String error;

  ChatErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
