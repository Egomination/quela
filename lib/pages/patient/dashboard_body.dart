import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:quela/bloc/bloc.dart';
import 'package:quela/bloc/patient_dashboard_bloc.dart';
import 'package:quela/models/patient.dart';
import 'package:quela/utils/hex_code.dart';

class ScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DashboardBloc _bloc = BlocProvider.of(context);
    return StreamBuilder<Patient>(
      stream: _bloc.patient,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        // Those variables are for providing the 'dynamic' feels of the UI
        final Patient data = snapshot.data;
        final List<IconData> icons = [
          Icons.wifi_tethering,
          Icons.ac_unit,
          Icons.airline_seat_flat,
          Icons.blur_on,
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
                  frontText: data.values[index].name,
                  backHeader: data.values[index].valCurr,
                  thresholdMin: data.values[index].valMin,
                  thresholdMax: data.values[index].valMax,
                );
              },
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
    @required this.frontText,
    @required this.backHeader,
    @required this.thresholdMin,
    @required this.thresholdMax,
  });

  final IconData icon;
  final String frontText;
  final String backHeader;
  final String thresholdMin;
  final String thresholdMax;

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
                    : Theme
                    .of(context)
                    .textTheme
                    .body1,
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
                backHeader,
                style: int.parse(backHeader) > int.parse(thresholdMax) ||
                    int.parse(backHeader) < int.parse(thresholdMin)
                    ? TextStyle(
                  color: Colors.red,
                  fontSize: 24.0,
                )
                    : Theme
                    .of(context)
                    .textTheme
                    .headline,
              ),
              //Text(backText, style: Theme.of(context).textTheme.body1),
            ],
          ),
        ),
      ),
    );
  }
}