import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login/infrastructure/login/bloc/login_bloc.dart';

class LoginFormWidget extends StatefulWidget {
  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  _onLoginButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
      username: _usernameController.text,
      password: _passwordController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'username',
                  ),
                  controller: _usernameController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'password',
                  ),
                  controller: _passwordController,
                  obscureText: true,
                ),
                RaisedButton(
                  child: Text('Login'),
                  onPressed:
                      state is! LoginLoading ? _onLoginButtonPressed : null,
                ),
                Container(
                  child: state is LoginLoading
                      ? CircularProgressIndicator()
                      : null,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
