import 'package:flutter/material.dart';
import 'package:quela/pages/login/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter login demo"),
      ),
      body: LoginForm(),
    );
  }
}
