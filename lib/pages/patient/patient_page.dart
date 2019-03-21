import 'package:flutter/material.dart';
import 'package:quela/pages/patient/dashboard_builder.dart';

import 'package:quela/utils/auth.dart';
import 'package:quela/utils/hex_code.dart';

class PatientPage extends StatelessWidget {
  PatientPage({Key key, this.auth, this.uuid}) : super(key: key);

  final Auth auth;
  final String uuid;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        //backgroundColor: Colors.black,
        body: TabBarView(
          children: <Widget>[
            PatientDashboardBuilder(uuid: uuid, auth: auth),
            Container(),
          ],
        ),
        bottomNavigationBar: TabBar(
          //isScrollable: true,
          labelColor: Colors.white,
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "Dashboard",
            ),
            Tab(
              icon: Icon(Icons.alarm),
              text: "Alarms",
            ),
          ],
        ),
        backgroundColor: HexColor("#0f1923"),
      ),
    );
  }
}
