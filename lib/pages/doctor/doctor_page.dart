import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quela/bloc/blocs.dart';
import 'package:quela/pages/doctor/doctor_dashboard.dart';
import 'package:quela/theme.dart';
import 'package:quela/widgets/voip.dart';

/// Class that responsible from passing the corresponding bloc instances to its
/// children. Also it reacts to current state of the [DoctorsBloc] instance.
class DoctorPage extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  DoctorsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = DoctorsBloc()
      ..dispatch(DoctorFetch());
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _bloc,
      child: BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, DoctorState state) {
          if (state is DoctorUninitialized || state is DoctorLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is DoctorError) {
            return Center(
              child: Text(state.toString()),
            );
          }
          if (state is DoctorLoaded) {
            Future.delayed(const Duration(minutes: 1), () {
              _bloc.dispatch(DoctorUpdate());
            });
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                //backgroundColor: Colors.black,
                body: TabBarView(
                  children: <Widget>[
                    DoctorDashboard(),
                    VoipConnection(
                      doctor: state.doctor,
                      isDoctor: true,
                    ),
                    //VoipConnection(entity: state.patient, isDoctor: false),
                  ],
                ),
                bottomNavigationBar: TabBar(
                  isScrollable: false,
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.dashboard),
                      text: "Dashboard",
                    ),
                    Tab(
                      icon: Icon(Icons.video_call),
                      text: "Call",
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
