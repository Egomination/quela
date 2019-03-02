import 'package:flutter/material.dart';

import 'package:quela/utils/colour.dart';
import 'package:quela/pages/patient/bottombar.dart';

class PatientDashboard extends StatelessWidget {
  PatientDashboard({Key key}) : super(key: key);

  Widget patientAppBar() {
    return AppBar(
      backgroundColor: HexColor("#3E4271"),
      centerTitle: true,
      title: Text('Dashboard',
          style: TextStyle(color: HexColor("#E19A4A"), fontSize: 25.0)),
    );
  }

  Widget patientBody() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: patientAppBar(),
      body: patientBody(),
      bottomNavigationBar: PatientBottomBar(),
    );
  }
}
