import 'dart:async';

import 'package:meta/meta.dart';
import 'package:flutter_graphql/flutter_graphql.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final storage = new FlutterSecureStorage();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final String check = """
  query check(\$id: String!) {
    checkType(id: \$id)
  }
  """
      .replaceAll('\n', ' ');

  Future<String> typeCheck(String id) async {
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

    if (response.errors != null) {
      print(response.errors.toString());
    }
    return response.data['checkType'];
  }

  Future<String> signIn({
    @required String email,
    @required String password,
  }) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<void> deleteToken() async {
    await storage.delete(key: "token");
    await storage.delete(key: "type");
    return _firebaseAuth.signOut();
  }

  Future<void> persistToken(String token) async {
    String type = await typeCheck("H6v2616cL8QUvP3mKNW1");
    await storage.write(key: "type", value: type);
    await storage.write(key: "token", value: token);
  }

  Future<bool> hasToken() async {
    String value = await storage.read(key: "token");
    bool state = value.isEmpty;
    return state;
  }

  Future<String> getType() async {
    String type = await storage.read(key: "type");
    return type;
  }
}
