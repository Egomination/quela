import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quela/bloc/blocs.dart';
import 'package:quela/pages/patient/dashboard_body.dart';
import 'package:quela/utils/hex_code.dart';
import 'package:quela/widgets/info_bar.dart';

class PatientDashboardBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    final PatientsBloc _patientBlock = BlocProvider.of<PatientsBloc>(context);
    return BlocBuilder(
      bloc: _patientBlock,
      builder: (BuildContext context, PatientState state) {
        final patient = (state as PatientLoaded).patient;
        return Scaffold(
          //backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: HexColor("#0f1923"),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Patient Dashboard",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 17.0,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () =>
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TestList())),
                  child: Icon(Icons.donut_small),
                ),
                Container(width: 20.0),
                InkWell(
                  onTap: () => authBloc.dispatch(LoggedOut()),
                  child: Icon(Icons.power_settings_new),
                ),
              ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              InfoBar(person: patient),
              Container(
                margin: EdgeInsets.only(
                  top: 140.0,
                ),
                child: ScreenBuilder(patient: patient),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TestList extends StatelessWidget {
  final imgURL =
      "https://image.freepik.com/free-photo/doctor-smiling-with-stethoscope_1154-36.jpg";

  Widget _testChildBuilder() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 45.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.network(
              imgURL,
              width: 150,
              height: 150,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Text(
            "Muhittin Topalak",
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          "Hearth and Brain Specialist",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            fontSize: 20.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 34.0,
            left: 4.0,
            right: 4.0,
          ),
          child: Text(
            "Note: Please use Video Call panel to call this doctor. It'll be"
                " shown that whether the doctor is available or not.",
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Info"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 50.0,
          horizontal: 15.0,
        ),
        itemCount: 10,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            width: 230.0,
            height: 200.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(120.0)),
            ),
            child: _testChildBuilder(),
          );
        },
      ),
    );
  }
}
