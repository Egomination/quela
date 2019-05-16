import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:quela/bloc/auth/auth.dart';
import 'package:quela/bloc/doctor/event.dart';
import 'package:quela/bloc/doctor/state.dart';
import 'package:quela/models/doctor.dart';

/// The bloc class that handles GraphQL requests for the doctors.
class DoctorsBloc extends Bloc<DoctorEvents, DoctorState> {
  final Future<String> userId = new Auth().getUser();

  @override
  DoctorState get initialState => DoctorUninitialized();

  /// The main dispatcher for the states.
  /// It yields to the corresponding state depending on the event and its result
  @override
  Stream<DoctorState> mapEventToState(event) async* {
    if (event is DoctorFetch || event is DoctorUpdate) {
      try {
        final _doctor = await _handleApiCall();
        yield DoctorLoaded(doctor: _doctor);
      } catch (e) {
        yield DoctorError(error: e);
      }
    }
  }

  /// The function that responsible from actual network traffic.
  /// It uses [userId] to fetch current user id from secure storage.
  ///
  /// It has its own GraphQL client inside because we didn't want to deal with
  /// widgets since we're using actual dart code rather than flutter's building
  /// blocks.
  Future<Doctor> _handleApiCall() async {
    final String uid = await userId;
    // Linking api url
    HttpLink link = HttpLink(uri: "https://quela-api.herokuapp.com/");
    // Gql client
    GraphQLClient client = GraphQLClient(
      link: link as Link,
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

      print("Doctor Info: =>:  ${response.data['getDoctor']}");
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
    gender
    age
    hospital_name
    telephone
    patientID{
      id
      name
      surname
      TC
      profile_pic
      room_no
      illness
      gender
      age
      weight
      height
      telephone
      values{
        name
        val_min
        val_max
        graph_data {
          data
          time
        }
      }
    }
  }
}
"""
    .replaceAll('\n', ' ');
