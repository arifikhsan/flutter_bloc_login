import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_login/repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepostitory userRepostitory;

  AuthenticationBloc({
    @required this.userRepostitory,
  }) : assert(userRepostitory != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepostitory.hasToken();
      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    } else if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepostitory.persistToken(event.token);
      yield AuthenticationAuthenticated();
    } else if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepostitory.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
