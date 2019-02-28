import 'package:flutter/material.dart';

import 'package:quela/utils/colour.dart';

class PatientDashboard extends StatelessWidget {
  PatientDashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                height: 130.0,
                child: DrawerHeader(
                  child: Text("Account Info Here"),
                  decoration: BoxDecoration(color: HexColor("#3E4271")),
                ),
              ),
              ListTile(
                title: Text("1"),
                //trailing: Icon(Icons.arrow_forward),
              ),
              ListTile(
                title: Text("2"),
              ),
            ],
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.0),
          child: AppBar(
            backgroundColor: HexColor("#3E4271"),
            centerTitle: true,
            title: Text('Dashboard',
                style: TextStyle(color: HexColor("#E19A4A"), fontSize: 25.0)),
          ),
        ),
        body: Text("DB"));
  }
}
