import 'dart:async';

import 'package:flutter_graphql/flutter_graphql.dart';
import 'package:quela/bloc/auth/auth.dart';
import 'package:quela/bloc/bloc.dart';
import 'package:quela/models/patient.dart';
import 'package:rxdart/rxdart.dart';

class PatientBloc implements BlocBase {
  PatientBloc() {
    _handleApiCall();
  }

  // This is needed for every type of User
  // Don't forget to add this to other types
  final Future<String> userid = new Auth().getUser();

  BehaviorSubject<Patient> _controller = BehaviorSubject<Patient>();

  Stream<Patient> get patient => _controller;

  void _handleApiCall() async {
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

      _controller.sink.add(Patient.fromJson(response.data['getPatient']));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _controller?.close();
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
