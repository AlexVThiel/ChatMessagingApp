import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../providers/auth_repository.dart';
//import '../../models/auth_response.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _userRepository;

  AuthenticationBloc(this._userRepository) : super(AuthLodingState()) {
    on<CheckAuth>((event, emit) async {
      emit(AuthLodingState());
      try {
        final auth = await _userRepository.isUserSignedIn();
        auth ? emit(AuthAuthenticated(auth)) : emit(AuthUninitialized(auth));
      } catch (e) {
        emit(AuthUnauthenticated(e.toString()));
      }
    });

    on<SignUp>((event, emit) async {
      emit(AuthLodingState());
      try {
        final auth = await _userRepository.singUp(
            email: event.email, password: event.pass);
        emit(AuthAuthenticated(auth));
      } catch (e) {
        emit(AuthUnauthenticated(e.toString()));
      }
    });
    /*on<SignIn>((event, emit) async {
      emit(AuthLodingState());
      try {
        final auth = await _userRepository.login(
            username: event.user, password: event.pass);
        emit(AuthAuthenticated(auth));
      } catch (e) {
        emit(AuthUnauthenticated(e.toString()));
      }
    });

    

    on<LoggedOut>((event, emit) async {
      emit(AuthLodingState());

      try {
        final auth = await _userRepository.signOutCurrentUser();
        emit(AuthUninitialized(auth));
      } catch (e) {
        emit(AuthUnauthenticated(e.toString()));
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
