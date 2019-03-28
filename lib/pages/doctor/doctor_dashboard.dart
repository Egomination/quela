import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quela/bloc/blocs.dart';
import 'package:quela/models/doctor.dart';
import 'package:quela/pages/doctor/dashboard_body.dart';
import 'package:quela/utils/hex_code.dart';
import 'package:quela/widgets/info_bar.dart';

class DoctorDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    final DoctorsBloc _bloc = BlocProvider.of<DoctorsBloc>(context);
    return BlocBuilder(
      bloc: _bloc,
      builder: (BuildContext context, DoctorState state) {
        final Doctor doctor = (state as DoctorLoaded).doctor;
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Doctor Dashboard",
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
          body: Stack(
            children: <Widget>[
              InfoBar(person: doctor),
              Container(
                margin: EdgeInsets.only(top: 140.0),
                child: DashboardBody(doctor: doctor),
              ),
            ],
          ),
        );
      },
    );
  }
}
