import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../models/user.dart';
import '../../providers/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(LodingState()) {
    on<SearchUsers>((event, emit) async {
      emit(LodingState());
      try {
        final users = await _userRepository.searchUsers(event.search);
        emit(UsersLoadedState(users));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });

    on<LoadUser>((event, emit) async {
      emit(LodingState());
      try {
        // Fetch user data from repository or API
        final user = await _userRepository.loadUser();
        emit(UserLoadedState(user!));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });

    on<UpdateRoom>((event, emit) async {
      emit(LodingState());
      try {
        await _userRepository.addRooms(event.rid, event.room);
        emit(UserUpdated());
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });

    /*on<SearchUsers>((event, emit) async {
      emit(UsersLodingState());
      try {
        final users = await _userRepository.searchUsers(event.search);
        /* final auth = await _chatRepository. .signUp(
            email: event.email, password: event.pass);*/
        emit(UsersLoadedState(users));
      } catch (e) {
        emit(UsersErrorState(e.toString()));
      }
    });*/
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
