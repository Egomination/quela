import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:intl/intl.dart';
import 'package:quela/models/patient.dart';
import 'package:quela/utils/hex_code.dart';

class ScreenBuilder extends StatelessWidget {
  final Patient patient;

  ScreenBuilder({this.patient});

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [
      Icons.blur_on, // Air Prs
      Icons.airline_seat_flat, // Blood Prs
      Icons.wifi_tethering, // Pulse
      Icons.ac_unit, // Temp
    ];
    final List<String> units = [
      utf8.decode([0xE3, 0x8B, 0x8C]),
      utf8.decode([0xE3, 0x8E, 0x9C]) + utf8.decode([0xE3, 0x8B, 0x8C]),
      "b/pm",
      utf8.decode([0xE2, 0x84, 0x83]),
    ];
    return LayoutBuilder(
      builder: (context, constraint) {
        return GridView.builder(
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: constraint.maxWidth / constraint.maxHeight,
          ),
          itemBuilder: (context, index) {
            return CardBuilder(
              icon: icons[index],
              unit: units[index],
              frontText: patient.values[index].name,
              backHeader: patient.values[index]
                  .graphData[patient.values[index].graphData.length - 1].data,
              thresholdMin: patient.values[index].valMin,
              thresholdMax: patient.values[index].valMax,
              lastUpdated: patient.values[index]
                  .graphData[patient.values[index].graphData.length - 1].time,
            );
          },
        );
      },
    );
  }
}

class CardBuilder extends StatelessWidget {
  CardBuilder({
    @required this.icon,
    @required this.unit,
    @required this.frontText,
    @required this.backHeader,
    @required this.thresholdMin,
    @required this.thresholdMax,
    @required this.lastUpdated,
  });

  final IconData icon;
  final String unit;
  final String frontText;
  final String backHeader;
  final String thresholdMin;
  final String thresholdMax;
  final int lastUpdated;

  // NOTE FOR DEVELOPERS: If you want to remove padding between cards, change
  // this return to Container and comment out elevation. Color is little bit tricky,
  // because i chose it for the card background and dunno how it'll look on container.
  // However, after those changes made they'll do the trick.
  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(lastUpdated * 1000);
    String date = DateFormat.yMMMd().add_Hm().format(time);
    return Card(
      elevation: 0.0,
      color: HexColor("#eaeaea"),
      child: FlipCard(
        direction: FlipDirection.VERTICAL,
        front: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            //borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: int.parse(backHeader) > int.parse(thresholdMax) ||
                        int.parse(backHeader) < int.parse(thresholdMin)
                    ? Colors.red
                    : Colors.black,
              ),
              Text(
                frontText,
                style: int.parse(backHeader) > int.parse(thresholdMax) ||
                        int.parse(backHeader) < int.parse(thresholdMin)
                    ? TextStyle(
                        color: Colors.red,
                      )
                    : Theme.of(context).textTheme.body1,
              ),
            ],
          ),
        ),
        back: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            //borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                backHeader + " " + unit,
                style: int.parse(backHeader) > int.parse(thresholdMax) ||
                        int.parse(backHeader) < int.parse(thresholdMin)
                    ? TextStyle(
                        color: Colors.red,
                        fontSize: 24.0,
                      )
                    : Theme.of(context).textTheme.headline,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(date),
              ),
              //Text(backText, style: Theme.of(context).textTheme.body1),
            ],
          ),
        ),
      ),
    );
  }
}
