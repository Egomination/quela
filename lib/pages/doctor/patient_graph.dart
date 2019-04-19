import 'package:fcharts/fcharts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quela/models/doctor.dart';

class SimpleLineChart extends StatelessWidget {
  final PatientId patient;
  final int type;

  SimpleLineChart({Key key, @required this.patient, @required this.type})
      : assert(patient != null);

  String dateFormatter(data) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(data * 1000);
    //String date = DateFormat.Md().add_Hm().format(time);
    String date = DateFormat.Hms().format(time);
    return date;
  }

  List<int> findMinMax(patient, lenght) {
    // Thanks Obama for this great chart library
    // It allowed me to write such a good function
    int max = 0;
    int min = patient.values[type].graphData[0].data;
    for (int i = 0; i <= lenght; i++) {
      if (patient.values[type].graphData[i].data > max) {
        max = patient.values[type].graphData[i].data;
      }
      if (patient.values[type].graphData[i].data < min) {
        min = patient.values[type].graphData[i].data;
      }
    }
    return [min, max];
  }

  @override
  Widget build(BuildContext context) {
    final int graphLength = patient.values[type].graphData.length - 1;
    final List minMax = findMinMax(patient, graphLength);
    // X value -> Y value
    final myData = [
      [
        patient.values[type].graphData[graphLength - 4].time,
        patient.values[type].graphData[graphLength - 4].data
      ],
      [
        patient.values[type].graphData[graphLength - 3].time,
        patient.values[type].graphData[graphLength - 3].data
      ],
      [
        patient.values[type].graphData[graphLength - 2].time,
        patient.values[type].graphData[graphLength - 2].data
      ],
      [
        patient.values[type].graphData[graphLength - 1].time,
        patient.values[type].graphData[graphLength - 1].data
      ],
      [
        patient.values[type].graphData[graphLength].time,
        patient.values[type].graphData[graphLength].data
      ],
    ];

    return LineChart(
      lines: [
        Line<List, String, int>(
          data: myData,
          xFn: (datum) => dateFormatter(datum[0]),
          yFn: (datum) => datum[1],
          xAxis: ChartAxis(),
          yAxis: ChartAxis(
            span: IntSpan(minMax[0] - 2, minMax[1] + 2),
            //tickGenerator: IntervalTickGenerator.byN(1),
          ),
        ),
      ],
      chartPadding: EdgeInsets.fromLTRB(30.0, 10.0, 10.0, 30.0),
    );
  }
}
