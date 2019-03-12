import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:quela/utils/hex_code.dart';

class ScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return new GridView.builder(
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: constraint.maxWidth / constraint.maxHeight,
          ),
          itemBuilder: (context, index) {
            return cd[index];
          },
        );
      },
    );
    ;
  }
}

class CardBuilder extends StatelessWidget {
  CardBuilder({
    this.icon,
    this.frontText,
    this.backHeader,
  });

  final IconData icon;
  final String frontText;
  final String backHeader;

  // NOTE FOR DEVELOPERS: If you want to remove padding between cards, change
  // this return to Container and comment out elevation. Color is little bit tricky,
  // because i chose it for the card background and dunno how it'll look on container.
  // However, after those changes made they'll do the trick.
  @override
  Widget build(BuildContext context) {
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
              Icon(icon),
              Text(frontText, style: Theme.of(context).textTheme.body1),
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
              Text(backHeader, style: Theme.of(context).textTheme.headline),
              //Text(backText, style: Theme.of(context).textTheme.body1),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: Replace this with the actual data
List cd = [
  CardBuilder(
    icon: Icons.wifi_tethering,
    frontText: "HeartBeat",
    backHeader: "88",
    //backText: "",
  ),
  CardBuilder(
    icon: Icons.ac_unit,
    frontText: "Temperature",
    backHeader: "37",
    //backText: "",
  ),
  CardBuilder(
    icon: Icons.airline_seat_flat,
    frontText: "Pressure",
    backHeader: "1",
    //backText: "",
  ),
  CardBuilder(
    icon: Icons.blur_on,
    frontText: "Blood pressure",
    backHeader: "12/8",
    //backText: "",
  ),
];
