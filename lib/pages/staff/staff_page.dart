import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quela/bloc/blocs.dart';
import 'package:quela/pages/staff/create_patient.dart';
import 'package:quela/pages/staff/update_patient_data.dart';

class StaffPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Staff Page",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 17.0,
              ),
            ),
            InkWell(
              onTap: () {
                authBloc.dispatch(LoggedOut());
              },
              child: Icon(Icons.power_settings_new),
            ),
          ],
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
