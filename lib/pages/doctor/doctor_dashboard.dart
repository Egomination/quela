import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quela/bloc/blocs.dart';
import 'package:quela/models/doctor.dart';
import 'package:quela/pages/doctor/doctor_patient.dart';
import 'package:quela/utils/hex_code.dart';

class DoctorDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DoctorsBloc _bloc = BlocProvider.of<DoctorsBloc>(context);
    return BlocBuilder(
      bloc: _bloc,
      builder: (BuildContext context, DoctorState state) {
        final Doctor doctor = (state as DoctorLoaded).doctor;
        return Scaffold(
          body: DoctorInfoBuilder(doctor: doctor),
        );
      },
    );
  }
}

class DoctorInfoBuilder extends StatelessWidget {
  final Doctor doctor;

  DoctorInfoBuilder({Key key, this.doctor}) : assert(doctor != null);

  Widget _imageNameBuilder(BuildContext context, {PatientId patient}) {
    return InkWell(
      onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(
                    patient: patient,
                  ),
            ),
          ),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(60.0),
            child: Image.network(
              patient.profilePic,
              fit: BoxFit.fill,
              scale: 1.0,
              width: 45.0,
              height: 45.0,
            ),
          ),
          Container(height: 2.0),
          Text(patient.name),
        ],
      ),
    );
  }

  Widget _listViewBuilder(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(
          left: (MediaQuery.of(context).size.width / 100) * 10,
        ),
        physics: BouncingScrollPhysics(),
        itemCount:
            doctor.patientId.length == null ? 0 : doctor.patientId.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _imageNameBuilder(context, patient: doctor.patientId[index]);
        });
  }

  Column _doctorInfoBuilder(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 34.0), // FIXME:
          child: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () => authBloc.dispatch(LoggedOut()),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: (MediaQuery.of(context).size.width / 100) * 10,
          ),
          child: Text(
            "Welcome",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          ),
        ),
        Container(height: 12.0),
        Padding(
          padding: EdgeInsets.only(
            left: (MediaQuery.of(context).size.width / 100) * 10,
          ),
          child: Text(
            "Dr. ${doctor.surname}",
            style: TextStyle(
              color: HexColor("#214D70"),
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
        ),
        Container(height: 5.0),
        Padding(
          padding: EdgeInsets.only(
            left: (MediaQuery.of(context).size.width / 100) * 10,
          ),
          child: Text(
            "Recently Viewed Patients",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
        ),
        Container(height: 15.0),
        Container(
          height: (MediaQuery.of(context).size.height / 100) * 10,
          child: _listViewBuilder(context),
        ),
      ],
    );
  }

  Widget _doctorNotes(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: 25.0,
            left: 35.0,
            right: 35.0,
          ),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("Doctor Notes")),
              Text("See all"),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: (MediaQuery.of(context).size.height / 100) * 5.0,
            left: 35.0,
            right: 35.0,
          ),
          width: MediaQuery.of(context).size.width,
          height: 120.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                15.0,
              ),
              topRight: Radius.circular(
                15.0,
              ),
              bottomRight: Radius.circular(
                15.0,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 22.0,
                  left: 22.0,
                ),
                child: Text(
                  "Text Text Text Text Text Text Text"
                      "Text Text Text Text Text Text"
                      "Text Text Text Text Text Text",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Container(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(
                  left: 22.0,
                  bottom: 10.0,
                ),
                child: Text("10 min ago from ago"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Container(
            padding: EdgeInsets.only(
              top: (MediaQuery.of(context).size.height / 100) * 6,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.28,
            decoration: BoxDecoration(
              color: HexColor("#FF9A91"),
            ),
            child: _doctorInfoBuilder(context),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.37,
            decoration: BoxDecoration(
              color: HexColor("#FFE0B9"),
            ),
            child: _doctorNotes(context),
          ),
        ),
      ],
    );
  }
}
