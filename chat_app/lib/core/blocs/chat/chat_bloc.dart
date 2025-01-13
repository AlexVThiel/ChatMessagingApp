import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../providers/chat_reposity.dart';

part 'chat_event.dart';
part 'message_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;

  ChatBloc(this._chatRepository) : super(ChatLodingState()) {
    on<LoadAllChat>((event, emit) async {
      emit(ChatLodingState());
      try {
        /* final auth = await _chatRepository. .signUp(
            email: event.email, password: event.pass);*/
        emit(ChatLoadedState());
      } catch (e) {
        emit(ChatErrorState(e.toString()));
      }
    });
  }

  /*AuthenticationBloc({required this.userRepository}) : super(AuthenticationState());
  
  AuthenticationState get initialState => AuthenticationUninitialized();
  
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();
      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }*/
}
