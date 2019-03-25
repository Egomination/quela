import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quela/bloc/patient/bloc.dart';
import 'package:quela/bloc/patient/event.dart';
import 'package:quela/bloc/patient/state.dart';
import 'package:quela/pages/patient/dashboard_builder.dart';
import 'package:quela/pages/patient/voip.dart';
import 'package:quela/utils/hex_code.dart';

class PatientPage extends StatelessWidget {
  final PatientsBloc _bloc = PatientsBloc();

  PatientPage() {
    _bloc.dispatch(Fetch());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (BuildContext context, PatientState state) {
        if (state is PatientUninitialized || state is PatientLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is PatientError) {
          return Center(
            child: Text(state.toString()),
          );
        }
        if (state is PatientLoaded) {
          print(state.patient);
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              //backgroundColor: Colors.black,
              body: TabBarView(
                children: <Widget>[
                  PatientDashboardBuilder(patient: state.patient),
                  VoipConnection(patient: state.patient),
                ],
              ),
              bottomNavigationBar: TabBar(
                //isScrollable: true,
                labelColor: Colors.white,
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                    text: "Dashboard",
                  ),
                  Tab(
                    icon: Icon(Icons.video_call),
                    text: "Call",
                  ),
                ],
              ),
              backgroundColor: HexColor("#0f1923"),
            ),
          );
        }
      },
    );
  }
}
