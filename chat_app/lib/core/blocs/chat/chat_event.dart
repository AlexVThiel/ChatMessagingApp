part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class LoadAllChat extends ChatEvent {
  const LoadAllChat();
  @override
  List<Object> get props => [];
}

class LoadChat extends ChatEvent {
  const LoadChat(this.roomId);

  final String roomId;
  @override
  List<Object> get props => [roomId];
}

class SaveChat extends ChatEvent {
  const SaveChat(this.message, this.chatRoomId);
  final Map<String, dynamic> message;
  final String chatRoomId;
  @override
  List<Object> get props => [message, chatRoomId];
}
