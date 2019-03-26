import 'package:flutter/material.dart';
import 'package:quela/bloc/blocs.dart';

class CreatePatient extends StatefulWidget {
  _CreatePatientState createState() => _CreatePatientState();
}

class _CreatePatientState extends State<CreatePatient> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _tcController = TextEditingController();
  final _profilePicController = TextEditingController();

  final _staffBloc = new StaffBloc();

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
    _staffBloc.dispatch(CreatePatientEvent(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      surname: _surnameController.text,
      tc: _tcController.text,
      profilePic: _profilePicController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Patient Creator'),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          inputField("Email", TextInputType.emailAddress, _emailController),
          inputField("Password", TextInputType.text, _passwordController),
          inputField("Name", TextInputType.text, _nameController),
          inputField("Surname", TextInputType.text, _surnameController),
          inputField("TC", TextInputType.number, _tcController),
          inputField(
              "Profile Picture", TextInputType.url, _profilePicController),
          RaisedButton(
            child: Text('Create'),
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
