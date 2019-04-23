import 'package:flutter/material.dart';
import 'package:quela/theme.dart';

class PatientInfo extends StatelessWidget {
  final dynamic person;

  PatientInfo({Key key, this.person});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: 140.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Themes.patientInfoBarColor,
        shape: BoxShape.rectangle,
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              left: 2 * width / 55,
            ),
            width: width / 4.4,
            height: height / 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(person.profilePic),
              ),
            ),
          ),
          Container(
            width: 20.0,
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Welcome, ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      person.name + " " + person.surname,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: height / 80),
                  child: Text(
                    "Room Number: " + person.roomNo,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: height / 65),
                  child: Row(
                    children: <Widget>[
                      Text(
                        person.weight + " kg ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        person.height + " cm",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: height / 65),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: width / 4),
                        child: Text(
                          "Gender: " + person.gender,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        " Age: " + person.age.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
