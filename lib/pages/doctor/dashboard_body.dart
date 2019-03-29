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
      onTap: () =>
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailsPage(
                      patient: patient,
                    )),
          ),
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

class DetailsPage extends StatelessWidget {
  final PatientId patient;

  DetailsPage({Key key, @required this.patient}) : assert(patient != null);

  Widget _buildTopRows() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 12.0,
              left: 12.0,
            ),
            child: Text(
              "Age: 34",
              style: TextStyle(
                color: Colors.white,
                fontSize: 19.0,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
            right: 12.0,
          ),
          child: Text(
            "Male",
            style: TextStyle(
              color: Colors.white,
              fontSize: 19.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUnderneathOfTheImage(PatientId patient) {
    return Column(
      children: <Widget>[
        _buildTopRows(),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Text(
            "${patient.name} ${patient.surname}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 19.0,
            ),
          ),
        ),
        Text(
          "TC: ${patient.tc}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 19.0,
          ),
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context, PatientId patient) {
    return Container(
      margin: EdgeInsets.only(
        left: (MediaQuery
            .of(context)
            .size
            .width / 100) * 37,
        top: 24.0,
      ),
      child: Image.network(
        patient.profilePic,
        scale: 3 / 24,
        width: 90.0,
        height: 120.0,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _infoCard(BuildContext context, PatientId patient) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(
            top: 96.0,
            left: 24.0,
            right: 24.0,
          ),
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 120.0,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: _buildUnderneathOfTheImage(patient),
        ),
        _buildImage(context, patient),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${patient.name} ${patient.surname}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 17.0,
          ),
        ),
        backgroundColor: HexColor("#0f1923"),
      ),
      body: Column(
        children: <Widget>[
          _infoCard(context, patient),
          Container(height: 24.0),
          Expanded(
            child: ListViewOfTheValues(
              patient: patient,
            ),
          ),
        ],
      ),
    );
  }
}

class ListViewOfTheValues extends StatelessWidget {
  final PatientId patient;

  ListViewOfTheValues({Key key, this.patient}) : assert(patient != null);

  Widget _card(BuildContext context, {
    PatientId patient,
    int index,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 120.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        children: <Widget>[
          _buildTopRow(patient.values[index]),
          Container(height: 20.0),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: _valueCreator("Min", patient.values[index].valMin),
              ),
              Expanded(
                child: _valueCreator("Current", patient.values[index].valCurr),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: _valueCreator("Max", patient.values[index].valMax),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopRow(Value value) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              value.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Text(
            "2 hrs ago",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _valueCreator(String fieldName, String value) {
    return Column(
      children: <Widget>[
        Text(
          fieldName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ),
        Text(value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: patient.values.length,
      itemBuilder: (context, index) {
        return _card(
          context,
          patient: patient,
          index: index,
        );
      },
    );
  }
}
