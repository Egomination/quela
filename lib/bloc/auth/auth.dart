import 'dart:async';

import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final storage = new FlutterSecureStorage();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  Future<bool> hasToken() async {
    String value = await storage.read(key: "token");
    bool state = value.isEmpty;
    return state;
  }
}
