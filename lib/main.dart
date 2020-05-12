import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login/delegate/simple_bloc_delegate.dart';
import 'package:flutter_bloc_login/infrastructure/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc_login/page/home_page.dart';
import 'package:flutter_bloc_login/page/login_page.dart';
import 'package:flutter_bloc_login/page/splash_page.dart';
import 'package:flutter_bloc_login/page/widget/loading_indicator_widget.dart';
import 'package:flutter_bloc_login/repository/user_repository.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final userRepostitory = UserRepostitory();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepostitory: userRepostitory)
          ..add(AppStarted());
      },
      child: App(userRepostitory: userRepostitory),
    );
  }
}

class App extends StatelessWidget {
  final UserRepostitory userRepostitory;

  const App({
    Key key,
    this.userRepostitory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return SplashPage();
          } else if (state is AuthenticationAuthenticated) {
            return HomePage();
          } else if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepostitory: userRepostitory);
          } else if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}
