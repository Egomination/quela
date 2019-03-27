import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quela/bloc/blocs.dart';
import 'package:quela/pages/doctor/doctor_dashboard.dart';
import 'package:quela/utils/hex_code.dart';

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
            print(state.doctor);
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                //backgroundColor: Colors.black,
                body: TabBarView(
                  children: <Widget>[
                    DoctorDashboard(),
                    Container(),
                    //VoipConnection(entity: state.patient, isDoctor: false),
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
      ),
    );
  }
}