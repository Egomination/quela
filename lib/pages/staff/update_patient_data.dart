import 'package:flutter/material.dart';
import 'package:quela/bloc/blocs.dart';

class UpdatePatientData extends StatefulWidget {
  _UpdatePatientDataState createState() => _UpdatePatientDataState();
}

class _UpdatePatientDataState extends State<UpdatePatientData> {
  final _idController = TextEditingController();
  final _valueController = TextEditingController();
  final _fieldController = TextEditingController();

  final _staffBloc = new StaffBloc();

  @override
  void dispose() {
    _staffBloc.dispose();
    super.dispose();
  }

  Widget inputField(
      String name, TextInputType type, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: type,
        autofocus: false,
        decoration: InputDecoration(hintText: name),
        controller: controller,
      ),
    );
  }

  void _submit() {
    _staffBloc.dispatch(UpdatePatientDataEvent(
      id: _idController.text,
      value: _valueController.text,
      field: _fieldController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Data Updater'),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          inputField("ID", TextInputType.text, _idController),
          inputField("New Value", TextInputType.number, _valueController),
          inputField("Field Name", TextInputType.text, _fieldController),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: RaisedButton(
              child: Text('Update'),
              onPressed: () {
                _submit();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
