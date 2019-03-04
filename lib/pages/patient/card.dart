import 'package:flutter/material.dart';

import 'package:quela/utils/colour.dart';

class PatientCard extends StatelessWidget {
  final String title;
  final String data;
  final String minVal;
  final String maxVal;
  final bool prefixBadge;
  final bool suffixBadge;
  final IconData icon;
  final IconData reverseIcon;
  final Function onTap;

  const PatientCard({
    Key key,
    this.title,
    this.data,
    this.minVal,
    this.maxVal,
    this.prefixBadge,
    this.suffixBadge,
    // NOTE: Icons are disabled until further notice
    this.icon,
    this.reverseIcon,
    this.onTap,
  }) : super(key: key);

  Map<String, dynamic> patientStatusDecider(
      String data, String minVal, String maxVal) {
    int _data = int.parse(data);
    int _minVal = int.parse(minVal);
    int _maxVal = int.parse(maxVal);

    if (_data > _minVal && _data < _maxVal) {
      // Good State
      return {
        "statusColour": HexColor("#21BC73"),
        "icon": Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        "text": Text("OK"),
      };
    } else {
      // Bad State
      return {
        "statusColour": HexColor("#D53120"),
        "icon": Icon(
          Icons.remove_circle,
          color: Colors.red,
        ),
        "text": Text("Not OK"),
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _dataStatus =
        patientStatusDecider(data, minVal, maxVal);

    return Container(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: InkWell(
          onTap: onTap,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                (prefixBadge)
                    ? Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10.0),
                            width: 10.0,
                            height: 60.0,
                            color: _dataStatus["statusColour"],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "Status",
                                style: TextStyle(fontSize: 22.0),
                              ),
                              Row(
                                children: <Widget>[
                                  _dataStatus["icon"],
                                  _dataStatus["text"],
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    : Container(),
                (icon != null)
                    ? Container(
                        margin: EdgeInsets.all(5.0),
                        width: 50.0,
                        height: 50.0,
                        child: _dataStatus["icon"],
                      )
                    : Container(),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: prefixBadge
                        ? EdgeInsets.only(left: 60.0)
                        : EdgeInsets.only(left: 145.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          title + " - ",
                          style: TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
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
                  ),
                ),
                (reverseIcon != null)
                    ? Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: _dataStatus["icon"],
                      )
                    : Container(),
                (suffixBadge)
                    ? Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "Status",
                                style: TextStyle(fontSize: 22.0),
                              ),
                              Row(
                                children: <Widget>[
                                  _dataStatus["icon"],
                                  _dataStatus["text"],
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.0),
                            width: 10.0,
                            height: 60.0,
                            color: _dataStatus["statusColour"],
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
