import 'package:flutter/material.dart';
import 'package:quela/pages/patient/mock_data.dart';

class PatientDataTableSample extends StatefulWidget {
  @override
  _PatientDataTableSampleState createState() => _PatientDataTableSampleState();
}

class _PatientDataTableSampleState extends State<PatientDataTableSample> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text("Information"),
        ),
        DataColumn(
          label: Text("Data"),
        ),
      ],
      rows: patients2
          .map(
            (info) => DataRow(
                  // NOTE: Old return gives error for cells
                  // Arrow function causes indent bug for map
                  cells: [
                    DataCell(
                      Text(info.title),
                      placeholder: false,
                    ),
                    DataCell(
                      Text(info.data),
                      placeholder: false,
                      //onTap: _getSelectedRowInfo,
                    ),
                  ],
                ),
          )
          .toList(),
    );
  }
}
