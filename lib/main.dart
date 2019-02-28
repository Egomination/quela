import 'package:flutter/material.dart';

import 'package:quela/pages/auth/login.dart';
import 'package:quela/pages/patient/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (BuildContext context) => LoginPage(),
        "/patient": (BuildContext context) => PatientDashboard(),
      },
    );
  }
}
