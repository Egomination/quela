import 'package:flutter/material.dart';
import 'package:quela/pages/staff/create_patient.dart';
import 'package:quela/pages/staff/update_patient_data.dart';

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
          RaisedButton(
            child: Text('Update Patient Data'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdatePatientData()),
              );
            },
          ),
        ],
      ),
    );
  }
}
