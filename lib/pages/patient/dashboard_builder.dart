import 'package:flutter/material.dart';
import 'package:quela/pages/patient/dashboard_body.dart';
import 'package:quela/pages/patient/patient_info_bar.dart';
import 'package:quela/utils/auth.dart';
import 'package:quela/utils/hex_code.dart';

class PatientDashboardBuilder extends StatelessWidget {
  PatientDashboardBuilder({Key key, this.auth}) : super(key: key);

  final Auth auth;

  @override
  Widget build(BuildContext context) {
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
              onTap: auth.signOut,
              child: Icon(Icons.power_settings_new),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          PatientInfoBar(),
          Container(
            margin: EdgeInsets.only(
              top: 140.0,
            ),
            child: ScreenBuilder(),
          ),
        ],
      ),
    );
  }
}
