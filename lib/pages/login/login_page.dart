import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_graphql/flutter_graphql.dart';

import 'package:quela/pages/login/login_form.dart';
import 'package:quela/utils/auth.dart';

class LoginPage extends StatelessWidget {
  final auth = new Auth();

  final String check = """
  query check(\$id: String!) {
    checkType(id: \$id)
  }
  """
      .replaceAll('\n', ' ');

  Future<String> _typeCheck(String id) async {
    HttpLink link = HttpLink(uri: "https://quela-api.herokuapp.com/");
    GraphQLClient client = GraphQLClient(
      link: link,
      cache: InMemoryCache(),
    );
    final QueryResult response = await client
        .query(
          QueryOptions(
            document: check,
            variables: <String, String>{"id": id},
          ),
        )
        .timeout(const Duration(seconds: 10));

    return response.data['checkType'];
  }

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
}
