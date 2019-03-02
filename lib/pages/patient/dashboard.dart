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

  Widget patientBody() {
    return Container(
      child: SizedBox(
        height: 80.0,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 80.0,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Info 1",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "10",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: HexColor("#FD9F45"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              VerticalDivider(),
              Container(
                width: 80.0,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Info 2",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "10",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: HexColor("#3DA5FA"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              VerticalDivider(),
              Container(
                width: 80.0,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Info 3",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "10",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: HexColor("#F56185"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              VerticalDivider(),
              Container(
                width: 80.0,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Info 4",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "10",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: HexColor("#35BFAF"),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: patientAppBar(),
      body: patientBody(),
      bottomNavigationBar: PatientBottomBar(),
    );
  }
}
