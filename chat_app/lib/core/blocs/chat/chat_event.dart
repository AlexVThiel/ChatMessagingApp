part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class LoadAllChat extends ChatEvent {
  @override
  List<Object> get props => [];
}
