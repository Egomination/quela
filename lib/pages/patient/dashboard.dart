import 'package:flutter/material.dart';
import 'package:quela/pages/patient/mock_data.dart';

import 'package:quela/utils/colour.dart';
import 'package:quela/pages/patient/bottombar.dart';
import 'package:quela/pages/patient/card.dart';

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

  Widget patientInformer() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: SizedBox(
        height: 80.0,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: patients.map(
              (section) {
                return Container(
                  width: 80.0,
                  child: Column(
                    children: <Widget>[
                      Text(
                        section.title,
                        style: TextStyle(fontSize: 12.0),
                      ),
                      SizedBox(height: 15),
                      Text(
                        section.data,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: HexColor(section.colour),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }

  Widget patientTables() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        children: patients2.map(
          (card) {
            return PatientCard(
              title: card.title,
              data: card.data,
              minVal: card.min,
              maxVal: card.max,
              // TODO: For now static
              prefixBadge: true,
              suffixBadge: false,
            );
          },
        ).toList(),
      ),
    );
  }

  Widget patientBody() {
    return Column(
      children: <Widget>[
        Text("Main Informations"),
        patientInformer(),
        Text("Other Informations"),
        patientTables(),
      ],
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
