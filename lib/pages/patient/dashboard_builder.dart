import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quela/bloc/auth/auth_block.dart';
import 'package:quela/bloc/auth/event.dart';
import 'package:quela/models/patient.dart';
import 'package:quela/pages/patient/dashboard_body.dart';
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

class PatientInfoBar extends StatelessWidget {
  final Patient patient;

  PatientInfoBar({Key key, this.patient});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    //double height = MediaQuery.of(context).size.height;
    return Container(
      height: 140.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      decoration: BoxDecoration(
        color: HexColor("#15202b"),
        shape: BoxShape.rectangle,
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              left: 2 * width / 6,
            ),
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(patient.profilePic),
              ),
            ),
          ),
          Container(
            width: 18.0,
          ),
          Container(
            margin: EdgeInsets.only(
              top: 50.0,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  patient.name + " " + patient.surname,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
