import 'package:flutter/material.dart';
import 'package:quela/bloc/bloc.dart';
import 'package:quela/bloc/patient_dashboard_bloc.dart';
import 'package:quela/pages/patient/dashboard_builder.dart';
import 'package:quela/pages/patient/voip.dart';
import 'package:quela/utils/hex_code.dart';

class PatientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatientBloc>(
      bloc: PatientBloc(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          //backgroundColor: Colors.black,
          body: TabBarView(
            children: <Widget>[
              PatientDashboardBuilder(),
              VoipConnection(),
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
      ),
    );
  }
}
