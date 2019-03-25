import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_graphql/flutter_graphql.dart';
import 'package:quela/bloc/auth/auth.dart';
import 'package:quela/bloc/patient/event.dart';
import 'package:quela/bloc/patient/state.dart';
import 'package:quela/models/patient.dart';

class PatientsBloc extends Bloc<PatientEvents, PatientState> {
  final Future<String> userid = new Auth().getUser();

  @override
  PatientState get initialState => PatientUninitialized();

  @override
  Stream<PatientState> mapEventToState(PatientState currentState,
      event) async* {
    if (event is Fetch) {
      try {
        final patient = await _handleApiCall();
        yield PatientLoaded(patient: patient);
      } catch (e) {
        yield PatientError(error: e);
      }
    }
  }

  Future<Patient> _handleApiCall() async {
    final String uid = await userid;
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
              document: search,
              variables: <String, dynamic>{'id': uid},
            ),
          )
          .timeout(const Duration(seconds: 10));

      if (response.errors != null) {
        print(response.errors.toString());
      }

      return Patient.fromJson(response.data['getPatient']);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

final String search = """
query search(\$id: String!) {
  getPatient(id: \$id){
    TC
    name
    surname
    email
    profile_pic
    doctorID{
      id
      name
      surname
      proficiency
    }
    values {
      name 
      val_curr
      val_min 
      val_max
    }
  }
}
"""
    .replaceAll('\n', ' ');