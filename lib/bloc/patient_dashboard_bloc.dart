import 'dart:async';

import 'package:flutter_graphql/flutter_graphql.dart';
import 'package:quela/bloc/bloc.dart';
import 'package:quela/models/patient.dart';
import 'package:rxdart/rxdart.dart';

class DashboardBloc implements BlocBase {
  BehaviorSubject<Patient> _controller = BehaviorSubject<Patient>();

  Stream<Patient> get patient => _controller;

  DashboardBloc() {
    _handleApiCall();
  }

  void _handleApiCall() async {
    // Linking api url
    HttpLink link = HttpLink(uri: "http://192.168.1.108:4000");
    // Gql client
    GraphQLClient client = GraphQLClient(
      link: link,
      cache: InMemoryCache(),
    );

    final QueryResult response = await client
        .query(
          QueryOptions(
            document: search,
            variables: <String, dynamic>{'id': 'pV6PGqbsE2asoGqu7k8c'},
          ),
        )
        .timeout(const Duration(seconds: 10));

    if (response.errors != null) {
      print(response.errors.toString());
    }

    _controller.sink.add(Patient.fromJson(response.data['getPatient']));
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
      name
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
