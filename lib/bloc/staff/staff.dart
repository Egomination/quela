import 'dart:async';

import 'package:meta/meta.dart';
import 'package:flutter_graphql/flutter_graphql.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Staff {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final String createPatientQuery = """
    mutation addPatient(
      \$id: String!
      \$name: String!
      \$surname: String!
      \$email: String!
      \$profile_pic: String!
      \$tc: String!
    ) {
      createPatient(
        id: \$id
        name: \$name
        surname: \$surname
        TC: \$tc
        email: \$email
        profile_pic: \$profile_pic
      )
    }
  """
      .replaceAll('\n', ' ');

  Future<void> patientCreator(String id, String name, String surname, String tc,
      String email, String profilePic) async {
    HttpLink link = HttpLink(uri: "https://quela-api.herokuapp.com/");
    GraphQLClient client = GraphQLClient(
      link: link,
      cache: InMemoryCache(),
    );
    final QueryResult response = await client
        .mutate(
          MutationOptions(
            document: createPatientQuery,
            variables: <String, dynamic>{
              "id": id,
              "name": name,
              "surname": surname,
              "tc": tc,
              "email": email,
              "profile_pic": profilePic
            },
          ),
        )
        .timeout(const Duration(seconds: 10));

    if (response.errors != null) {
      print(response.errors.toString());
    }
  }

  Future<void> createPatient({
    @required String email,
    @required String password,
    @required String name,
    @required String surname,
    @required String tc,
    @required String profilePic,
  }) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    await patientCreator(user.uid, name, surname, tc, email, profilePic);
  }
}
