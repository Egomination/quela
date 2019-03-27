import 'package:flutter/material.dart';
import 'package:quela/models/doctor.dart';
import 'package:quela/utils/hex_code.dart';

class InfoBar extends StatelessWidget {
  final dynamic person;

  InfoBar({Key key, this.person});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    return Container(
      height: 140.0,
      width: MediaQuery.of(context).size.width,
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
                image: NetworkImage(person.profilePic),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  person.name + " " + person.surname,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                (person is Doctor)
                    ? Text(
                  person.proficiency,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
