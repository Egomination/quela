import 'package:flutter/material.dart';

import 'package:quela/utils/colour.dart';

// "https://via.placeholder.com/150"

class PatientDashboard extends StatelessWidget {
  PatientDashboard({Key key}) : super(key: key);

  Widget patientDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: HexColor("#3E4271"),
            ),
            //margin: EdgeInsets.only(bottom: 10.0),
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage("https://via.placeholder.com/150"),
                ),
              ),
            ),
            accountName: new Container(
              child: Text(
                'Name',
                style: TextStyle(color: Colors.black),
              ),
            ),
            accountEmail: new Container(
              child: Text(
                'Email',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          ListTile(
            title: Text("Detailed View"),
            //trailing: Icon(Icons.arrow_forward),
          ),
          /*FittedBox(
            fit: BoxFit.contain,
            child: Container(),
          ),*/
          Container(
            // NOTE: Change the margin if you will add more item
            margin: EdgeInsets.only(top: 290.0),
            child: SizedBox(
              height: 150.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: HexColor("#E19A4A"),
                ),
                child: Text("Insert recent status here"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget patientAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(120.0),
      child: AppBar(
        backgroundColor: HexColor("#3E4271"),
        centerTitle: true,
        title: Text('Dashboard',
            style: TextStyle(color: HexColor("#E19A4A"), fontSize: 25.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: patientDrawer(), appBar: patientAppBar(), body: Text("DB"));
  }
}
