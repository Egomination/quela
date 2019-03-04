import 'package:flutter/material.dart';
import 'package:quela/pages/patient/mock_data.dart';

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

  Widget patientStatusDecider(String data, String minVal, String maxVal) {
    int _data = int.parse(data);
    int _minVal = int.parse(minVal);
    int _maxVal = int.parse(maxVal);

    if (_data > _minVal && _data < _maxVal) {
      // Good State
      return Row(
        children: <Widget>[
          Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          Text("OK"),
        ],
      );
    } else {
      // Bad State
      return Row(
        children: <Widget>[
          Icon(
            Icons.remove_circle,
            color: Colors.red,
          ),
          Text("Not OK"),
        ],
      );
    }
  }

  Widget patientCard(
      Icon icon, String title, String data, String minVal, String maxVal) {
    return SizedBox(
      height: 80.0,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            icon,
            Row(
              children: <Widget>[
                Container(
                  //margin: EdgeInsets.only(right: 5.0),
                  child: Text(
                    title + " - ",
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
                //SizedBox(height: 8),
                Text(
                  data,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: HexColor("#3E4271"),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 15.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Status",
                    style: TextStyle(fontSize: 22.0),
                  ),
                  SizedBox(height: 8),
                  patientStatusDecider(data, minVal, maxVal),
                ],
              ),
            ),
          ],
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
            return patientCard(
              Icon(
                Icons.add,
                size: 50.0,
              ),
              card.title,
              card.data,
              card.min,
              card.max,
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
