import 'package:flutter/material.dart';
import 'package:quela/models/doctor.dart';
import 'package:quela/utils/hex_code.dart';

/// As the name indicates, it builds the whole body of the dashboard.
class DashboardBody extends StatelessWidget {
  final Doctor doctor;

  DashboardBody({Key key, this.doctor});

  /// Building card content's texts
  ///
  /// =====================
  /// |        This: part  |
  /// |        This: part  |
  /// =====================
  ///
  /// [fieldName] corresponds to the left side of the card which was depicted by
  /// This: in the art above. [fieldValue] is the latter part.
  Row _cardContentRowBuilder({String fieldName, String fieldValue}) {
    return Row(
      children: <Widget>[
        Text(
          "$fieldName:",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 24.0,
          ),
        ),
        Container(width: 18.0),
        Text(
          fieldValue,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }

  /// It's the card content's text part.
  Column _cardContent(PatientId patient) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: _cardContentRowBuilder(
            fieldName: "Name",
            fieldValue: patient.name,
          ),
        ),
        _cardContentRowBuilder(
          fieldName: "Surname",
          fieldValue: patient.surname,
        ),
        _cardContentRowBuilder(
          fieldName: "TC",
          fieldValue: patient.tc,
        ),
      ],
    );
  }

  /// Actual builder function.
  /// It uses [context] to determine [width] of the card.
  /// [PatientId] stands for the patient's information polled via doctor query
  /// and [values] is the array that contains only the patient's sensor values.
  /// The reason of the separation is there's a emergency indicator in this class
  /// and need to find if any of those values are resides between max and min values.
  ///
  /// Also img part of the card is build here.
  ///
  /// ==================================
  /// |   img   |   Text       | indc   |
  /// |   img   |   Text       | indc   |
  /// ==================================
  Widget _cardBuilder(BuildContext context, PatientId patient) {
    List<Value> values = patient.values;
    return InkWell(
      onTap: () => null,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        width: MediaQuery.of(context).size.width,
        height: 90.0,
        decoration: BoxDecoration(
          color: HexColor("#15202b"),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Row(
          children: <Widget>[
            Image.network(
              patient.profilePic,
            ),
            Container(width: 24.0),
            Expanded(
              child: _cardContent(patient),
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: 10.0,
              decoration: BoxDecoration(
                color: _logicForColoring(values) ? Colors.red : Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Logic of the emergency indicator.
  /// It checks each and every [sensor] value whether they're inside of the
  /// boundaries or not
  _logicForColoring(List<Value> values) {
    bool flag = false;
    values.forEach((val) {
      if (int.parse(val.valCurr) <= int.parse(val.valMin) ||
          int.parse(val.valCurr) >= int.parse(val.valMax)) flag = true;
    });
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: doctor.patientId.length,
      itemBuilder: (context, index) {
        return _cardBuilder(context, doctor.patientId[index]);
      },
    );
  }
}
