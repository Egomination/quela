import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quela/bloc/auth/auth_block.dart';
import 'package:quela/bloc/login/event.dart';
import 'package:quela/bloc/login/login_block.dart';
import 'package:quela/bloc/login/state.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthBloc authBloc;

  LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authBloc,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  void _submit() {
    _loginBloc.dispatch(ButtonPressed(
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 65.0,
        child: Image.asset('assets/q-logo.png'),
      ),
    );
  }

  Widget _emailInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Email',
          icon: Icon(
            Icons.mail,
            color: Colors.grey,
          ),
        ),
        controller: _emailController,
      ),
    );
  }

  Widget _passwordInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Password',
          icon: Icon(
            Icons.lock,
            color: Colors.grey,
          ),
        ),
        controller: _passwordController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvents, LoginStates>(
      bloc: _loginBloc,
      builder: (BuildContext context, LoginStates state) {
        if (state is Failure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        Widget _loginButton() {
          return Padding(
            padding: EdgeInsets.fromLTRB(70.0, 35.0, 70.0, 0.0),
            child: OutlineButton(
              borderSide: BorderSide(
                color: Colors.blue,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 18.0, color: Colors.blue),
              ),
              onPressed: state is Loading ? null : _submit,
            ),
          );
        }

        Widget _circularProgress() {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          }
          return null;
        }

        return Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                _logo(),
                _emailInput(),
                _passwordInput(),
                //_errorMessageField(),
                _loginButton(),
                _circularProgress()
              ],
            ),
          ),
        );
      },
    );
  }
  /*

  // Auth from Firebase
  void _submit() async {
    String userId = "";

    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    if (_validateForm()) {
      try {
        userId = await widget.auth.signIn(_email, _password);
        print('Signed in: $userId');
      } catch (err) {
        print('Error: $err');
        setState(() {
          _isLoading = false;
          _errorMessage = err.message;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }*/
}
