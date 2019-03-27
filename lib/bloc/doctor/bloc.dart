import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_graphql/flutter_graphql.dart';
import 'package:quela/bloc/auth/auth.dart';
import 'package:quela/bloc/doctor/event.dart';
import 'package:quela/bloc/doctor/state.dart';
import 'package:quela/models/doctor.dart';

class DoctorsBloc extends Bloc<DoctorEvents, DoctorState> {
  final Future<String> userId = new Auth().getUser();

  @override
  DoctorState get initialState => DoctorUninitialized();

  @override
  Stream<DoctorState> mapEventToState(
    DoctorState currentState,
    event,
  ) async* {
    if (event is DoctorFetch) {
      try {
        final _doctor = await _handleApiCall();
        yield DoctorLoaded(doctor: _doctor);
      } catch (e) {
        yield DoctorError(error: e);
      }
    }
  }

  Future<Doctor> _handleApiCall() async {
    final String uid = await userId;
    // Linking api url
    HttpLink link = HttpLink(uri: "https://quela-api.herokuapp.com/");
    // Gql client
    GraphQLClient client = GraphQLClient(
      link: link,
      cache: InMemoryCache(),
    );
    try {
      final QueryResult response = await client
          .query(
            QueryOptions(
              document: query,
              variables: <String, dynamic>{'id': uid},
            ),
          )
          .timeout(const Duration(seconds: 10));

      if (response.errors != null) {
        print(response.errors.toString());
      }

      print("Doctor Info: =>:  ${response.data['getPatient']}");
      return Doctor.fromJson(response.data['getDoctor']);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

final String query = """
query search(\$id: String!){
  getDoctor(id:\$id){
    name
    surname
    email
    proficiency
    profile_pic
    patientID{
      name
      surname
      TC
      profile_pic
      values{
        name
        val_min
        val_max
        val_curr
      }
    }
  }
}
"""
    .replaceAll('\n', ' ');
