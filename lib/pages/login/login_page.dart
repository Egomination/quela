import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:quela/pages/login/login_form.dart';
import 'package:quela/pages/login/mock_main.dart';
import 'package:quela/utils/auth.dart';

class LoginPage extends StatelessWidget {
  final auth = new Auth();

  Widget _handleAuth() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          //return MockMain(firestore: firestore, uuid: snapshot.data.uid);
          return MockMain(uuid: snapshot.data.uid, auth: auth);
        }
        return LoginForm(auth: auth);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Quela Login"),
        ),
      ),
      body: _handleAuth(),
    );
  }
}
