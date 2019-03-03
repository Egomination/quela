import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

import 'package:quela/utils/colour.dart';

class PatientBottomBar extends StatefulWidget {
  @override
  _PatientBottomBarState createState() => _PatientBottomBarState();
}

class _PatientBottomBarState extends State<PatientBottomBar> {
  // FIXME: Local state. Needs to be global / state management
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return FancyBottomNavigation(
      initialSelection: 0,
      circleColor: HexColor("#E19A4A"),
      barBackgroundColor: HexColor("#3E4271"),
      textColor: Colors.white,
      inactiveIconColor: Colors.white,
      onTabChangedListener: (position) {
        setState(() {
          _currentPage = position;
          if (_currentPage == 0) {
            Navigator.pushReplacementNamed(context, "/patient");
          } else if (_currentPage == 1) {
            Navigator.pushReplacementNamed(context, "/patient/alarms");
          }
        });
      },
      tabs: [
        TabData(
          iconData: Icons.home,
          title: "Dashboard",
        ),
        TabData(
          iconData: Icons.add_alert,
          title: "Alarms",
        ),
      ],
    );
  }
}
