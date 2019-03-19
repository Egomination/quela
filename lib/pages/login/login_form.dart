import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading;

  String _email;
  String _password;
  String _errorMessage;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _errorMessage = "";
  }

  // Auth from Firebase
  void _validateAndSubmit() {}

  Widget _circularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
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
      ),
    );
  }

  Widget _loginButton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: MaterialButton(
          elevation: 5.0,
          minWidth: 200.0,
          height: 42.0,
          color: Colors.blue,
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          onPressed: _validateAndSubmit,
        ));
  }

  Widget _form() {
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
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Show CP if loading
        _circularProgress(),
        _form(),
      ],
    );
  }
}
