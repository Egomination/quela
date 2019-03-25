import 'package:flutter/material.dart';
import 'package:quela/models/patient.dart';
import 'package:quela/utils/hex_code.dart';

class PatientInfoBar extends StatelessWidget {
  final Patient patient;

  PatientInfoBar({Key key, this.patient});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    return Container(
      height: 140.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      decoration: BoxDecoration(
        color: HexColor("#15202b"),
        shape: BoxShape.rectangle,
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              left: 2 * width / 6,
            ),
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(patient.profilePic),
              ),
            ),
          ),
          Container(
            width: 18.0,
          ),
          Container(
            margin: EdgeInsets.only(
              top: 50.0,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  patient.name + " " + patient.surname,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
