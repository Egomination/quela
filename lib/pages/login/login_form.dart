import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quela/bloc/blocs.dart';

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

  final _formKey = GlobalKey<FormState>();

  LoginBloc get _loginBloc => widget.loginBloc;

  void _submit() {
    if (_formKey.currentState.validate()) {
      _loginBloc.dispatch(ButtonPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
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
        validator: validateEmail,
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return "Please enter a valid email";
    else
      return null;
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
        validator: validatePassword,
      ),
    );
  }

  String validatePassword(String value) {
    if (value.length < 6)
      return "Password must contain atleast 6 characters";
    else
      return null;
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
              onPressed: state is LoginLoading ? null : _submit,
            ),
          );
        }

        Widget _circularProgress() {
          if (state is LoginLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(width: 0.0, height: 0.0);
        }

        return Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                _logo(),
                _emailInput(),
                _passwordInput(),
                _loginButton(),
                _circularProgress()
              ],
            ),
          ),
        );
      },
    );
  }
}
