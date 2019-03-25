import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quela/bloc/auth/auth_block.dart';
import 'package:quela/bloc/auth/event.dart';
import 'package:quela/models/patient.dart';
import 'package:quela/pages/patient/dashboard_body.dart';
import 'package:quela/pages/patient/patient_info_bar.dart';
import 'package:quela/utils/hex_code.dart';

class PatientDashboardBuilder extends StatelessWidget {
  final Patient patient;

  PatientDashboardBuilder({this.patient});

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: HexColor("#0f1923"),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Patient Dashboard",
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
      body: Stack(
        children: <Widget>[
          PatientInfoBar(patient: patient),
          Container(
            margin: EdgeInsets.only(
              top: 140.0,
            ),
            child: ScreenBuilder(patient: patient),
          ),
        ],
      ),
    );
  }
}
