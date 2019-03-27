import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quela/bloc/blocs.dart';
import 'package:quela/utils/hex_code.dart';

class DoctorPage extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Patient Dashboard",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 17.0,
              ),
            ),
            InkWell(
              onTap: () {
                authBloc.dispatch(LoggedOut());
              },
              child: Icon(Icons.power_settings_new),
            ),
          ],
        ),
        backgroundColor: HexColor("#0f1923"),
      ),
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
