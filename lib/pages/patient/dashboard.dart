import 'package:flutter/material.dart';

import 'package:quela/utils/colour.dart';
import 'package:quela/pages/patient/bottombar.dart';

class PatientDashboard extends StatelessWidget {
  PatientDashboard({Key key}) : super(key: key);

  List<Map<String, dynamic>> _testData = [
    {"title": "Info 1", "data": "10", "colour": "#FD9F45"},
    {"title": "Info 2", "data": "12", "colour": "#3DA5FA"},
    {"title": "Info 3", "data": "15", "colour": "#F56185"},
    {"title": "Info 4", "data": "17", "colour": "#35BFAF"}
  ];

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
            children: _testData
                .map(
                  (section) => Container(
                        width: 80.0,
                        child: Column(
                          children: <Widget>[
                            Text(
                              section["title"],
                              style: TextStyle(fontSize: 20.0),
                            ),
                            SizedBox(height: 10),
                            Text(
                              section["data"],
                              style: TextStyle(
                                fontSize: 24.0,
                                color: HexColor(section["colour"]),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                )
                .toList(),
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
