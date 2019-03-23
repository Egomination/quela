import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth {
  final storage = new FlutterSecureStorage();

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
