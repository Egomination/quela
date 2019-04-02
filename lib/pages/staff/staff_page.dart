import 'package:flutter/material.dart';
import 'package:quela/pages/staff/create_patient.dart';

class StaffPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Staff Page'),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          RaisedButton(
            child: Text('Create Patient'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePatient()),
              );
            },
          ),
        ],
      ),
    );
  }
}
