import 'package:fcharts/fcharts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quela/bloc/blocs.dart';
import 'package:quela/models/doctor.dart';

class SimpleLineChart extends StatelessWidget {
  final PatientId patient;
  final int type;
  final DoctorsBloc bloc;

  SimpleLineChart(
      {Key key,
      @required this.patient,
      @required this.type,
      @required this.bloc})
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

  List dataCreator(patient, lenght) {
    // X value -> Y value
    return [
      [
        patient.values[type].graphData[lenght - 4].time,
        patient.values[type].graphData[lenght - 4].data
      ],
      [
        patient.values[type].graphData[lenght - 3].time,
        patient.values[type].graphData[lenght - 3].data
      ],
      [
        patient.values[type].graphData[lenght - 2].time,
        patient.values[type].graphData[lenght - 2].data
      ],
      [
        patient.values[type].graphData[lenght - 1].time,
        patient.values[type].graphData[lenght - 1].data
      ],
      [
        patient.values[type].graphData[lenght].time,
        patient.values[type].graphData[lenght].data
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: this.bloc,
      builder: (BuildContext context, DoctorState state) {
        final List<PatientId> patientId =
            (state as DoctorLoaded).doctor.patientId;

        var ppatient = this.patient;
        patientId.forEach((patient) =>
            patient.name == this.patient.name ? ppatient = patient : patient);

        final int graphLength = ppatient.values[type].graphData.length - 1;
        final List minMax = findMinMax(ppatient, graphLength);
        final List myData = dataCreator(ppatient, graphLength);

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
      },
    );
  }
}
