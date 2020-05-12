import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login/infrastructure/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc_login/infrastructure/login/bloc/login_bloc.dart';
import 'package:flutter_bloc_login/page/widget/login_form_widget.dart';
import 'package:flutter_bloc_login/repository/user_repository.dart';

class LoginPage extends StatelessWidget {
  final UserRepostitory userRepostitory;

  const LoginPage({
    Key key,
    @required this.userRepostitory,
  })  : assert(userRepostitory != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            userRepostitory: userRepostitory,
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          );
        },
        child: LoginFormWidget(),
      ),
    );
  }
}
