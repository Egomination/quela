import 'package:flutter/material.dart';
import 'package:quela/models/doctor.dart';
import 'package:quela/utils/hex_code.dart';

class DashboardBody extends StatelessWidget {
  final Doctor doctor;

  DashboardBody({Key key, this.doctor});

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
