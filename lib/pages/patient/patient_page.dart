import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quela/bloc/patient/patient_bloc.dart';
import 'package:quela/pages/patient/dashboard_builder.dart';
import 'package:quela/theme.dart';
import 'package:quela/widgets/voip.dart';

class PatientPage extends StatefulWidget {
  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  PatientsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PatientsBloc()..dispatch(Fetch());
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _bloc,
      child: BlocBuilder(
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
            Future.delayed(const Duration(minutes: 1), () {
              _bloc.dispatch(Update());
            });
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                //backgroundColor: Colors.black,
                body: TabBarView(
                  children: <Widget>[
                    PatientDashboardBuilder(),
                    VoipConnection(patient: state.patient, isDoctor: false),
                  ],
                ),
                bottomNavigationBar: TabBar(
                  //isScrollable: true,
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.dashboard),
                      text: "Dashboard",
                    ),
                    Tab(
                      icon: Icon(Icons.video_call),
                      text: "Video Call",
                    ),
                  ],
                ),
                backgroundColor: Themes.mainThemeColor,
              ),
            );
          }
        },
      ),
    );
  }
}
