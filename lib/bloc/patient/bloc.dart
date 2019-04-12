import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_graphql/flutter_graphql.dart';
import 'package:quela/bloc/auth/auth.dart';
import 'package:quela/bloc/patient/event.dart';
import 'package:quela/bloc/patient/state.dart';
import 'package:quela/models/patient.dart';

class PatientsBloc extends Bloc<PatientEvents, PatientState> {
  final Future<String> userId = new Auth().getUser();

  @override
  PatientState get initialState => PatientUninitialized();

  @override
  Stream<PatientState> mapEventToState(event) async* {
    if (event is Fetch || event is Update) {
      try {
        final patient = await _handleApiCall();
        yield PatientLoaded(patient: patient);
      } catch (e) {
        yield PatientError(error: e);
      }
    }
  }

  Future<Patient> _handleApiCall() async {
    final String uid = await userId;
    // Linking api url
    //HttpLink link = HttpLink(uri: "https://quela-api.herokuapp.com/");
    HttpLink link = HttpLink(uri: "http://192.168.1.108:4000/graphql");
    // Gql client
    GraphQLClient client = GraphQLClient(link: link, cache: InMemoryCache());
    try {
      final QueryResult response = await client
          .query(
            QueryOptions(
              document: search,
              variables: <String, dynamic>{'id': uid},
              //pollInterval: 1,
            ),
          )
          .timeout(const Duration(seconds: 10));
      client.cache.reset();

      if (response.errors != null) {
        print(response.errors.toString());
      }

      print("Patient Info: =>:  ${response.data['getPatient']}");
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
    room_no
    illness
    gender
    age
    weight
    height
    telephone
    doctorID{
      id
      profile_pic
      name
      surname
      proficiency
      gender
      telephone
    }
    values {
      name 
      val_curr
      val_min 
      val_max
      last_upd
    }
  }
}
"""
    .replaceAll('\n', ' ');
