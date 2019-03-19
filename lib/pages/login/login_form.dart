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

  // Form validation before sumbit
  bool _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Auth from Firebase
  void _submit() {
    setState(() {
      _errorMessage = "";
    });
    _validateForm();
  }

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
        validator: (value) =>
            value.isEmpty ? 'Email field can\'t be empty' : null,
        onSaved: (value) => _email = value,
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
        validator: (value) =>
            value.isEmpty ? 'Password field can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    );
  }

  // For Firebase errors
  Widget _errorMessageField() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
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
        onPressed: _submit,
      ),
    );
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
            _errorMessageField(),
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
