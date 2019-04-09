import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quela/bloc/blocs.dart';
import 'package:quela/models/doctor.dart';

class DoctorDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
	  //final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
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

	//Widget _imageNameBuilder() {}

	Widget _listViewBuilder(BuildContext context) {
		return ListView.builder(
				padding: EdgeInsets.only(
					left: (MediaQuery
							.of(context)
							.size
							.width / 100) * 10,
				),
				physics: BouncingScrollPhysics(),
				itemCount:
				doctor.patientId.length == null ? 0 : doctor.patientId.length,
				scrollDirection: Axis.horizontal,
				shrinkWrap: true,
				itemBuilder: (context, index) {
					return Container(
						height: 20.0,
						width: 20.0,
						color: Colors.purpleAccent,
					);
				});
	}

	Column _doctorInfoBuilder(BuildContext context) {
		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.start,
			children: <Widget>[
				Padding(
					padding: EdgeInsets.only(
						left: (MediaQuery
								.of(context)
								.size
								.width / 100) * 10,
					),
					child: Text(
						"Welcome",
						style: TextStyle(
							color: Colors.white,
							fontSize: 24.0,
						),
					),
				),
				Container(height: 15.0),
				Padding(
					padding: EdgeInsets.only(
						left: (MediaQuery
								.of(context)
								.size
								.width / 100) * 10,
					),
					child: Text(
						"Dr. ${doctor.surname}",
						style: TextStyle(
							color: Colors.black45,
							fontWeight: FontWeight.bold,
							fontSize: 32.0,
						),
					),
				),
				Container(height: 15.0),
				Container(
					height: (MediaQuery
							.of(context)
							.size
							.height / 100) * 5,
					child: _listViewBuilder(context),
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
					padding: const EdgeInsets.only(left: 34.0),
					child: Container(
						padding: EdgeInsets.only(
							top: (MediaQuery
									.of(context)
									.size
									.height / 100) * 10,
						),
						width: MediaQuery
								.of(context)
								.size
								.width,
						height: MediaQuery
								.of(context)
								.size
								.height / 2.4,
						decoration: BoxDecoration(
							color: Colors.blueAccent,
						),
						child: _doctorInfoBuilder(context),
					),
				),
				Padding(
					padding: const EdgeInsets.only(left: 34.0),
					child: Container(
						width: MediaQuery
								.of(context)
								.size
								.width,
						height: MediaQuery
								.of(context)
								.size
								.height / 2.4,
						decoration: BoxDecoration(
							color: Colors.amber,
						),
					),
				),
			],
    );
  }
}
