import 'package:flutter/material.dart';

import 'package:quela/pages/patient/patient_page.dart';
import 'package:quela/pages/login/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quela',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        // "/": (BuildContext context) => PatientPage(),
        "/": (BuildContext context) => LoginPage(),
      },
    );
  }
}
