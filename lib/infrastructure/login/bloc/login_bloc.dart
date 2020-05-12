import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_login/infrastructure/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc_login/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepostitory userRepostitory;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepostitory,
    @required this.authenticationBloc,
  })  : assert(userRepostitory != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        final token = await userRepostitory.authenticate(
          username: event.username,
          password: event.password,
        );
        authenticationBloc.add(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
