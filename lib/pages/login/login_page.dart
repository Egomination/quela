import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quela/bloc/auth/auth.dart';
import 'package:quela/bloc/auth/auth_block.dart';
import 'package:quela/bloc/login/login_block.dart';
import 'package:quela/pages/login/login_form.dart';

class LoginPage extends StatefulWidget {
  final Auth auth;

  LoginPage({Key key, @required this.auth})
      : assert(auth != null),
        super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;
  AuthBloc _authBloc;

  Auth get _auth => widget.auth;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _loginBloc = LoginBloc(
      auth: _auth,
      authBloc: _authBloc,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: LoginForm(
        authBloc: _authBloc,
        loginBloc: _loginBloc,
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}

/*class LoginPage extends StatefulWidget {

  Widget _handleAuth() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return null;
        }
        return LoginForm(auth: auth);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _handleAuth(),
    );
  }
}*/
