import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_graphql/flutter_graphql.dart';
import 'package:quela/pages/login/mock_main.dart';
import 'package:quela/pages/patient/patient_page.dart';

import 'package:quela/utils/auth.dart';

class LoginRouter extends StatelessWidget {
  final String uuid;
  final Auth auth;

  LoginRouter({Key key, this.uuid, this.auth}) : super(key: key);

  final String check = """
  query check(\$id: String!) {
    checkType(id: \$id)
  }
  """
      .replaceAll('\n', ' ');

  Future<String> _typeCheck(String id) async {
    HttpLink link = HttpLink(uri: "https://quela-api.herokuapp.com/");
    GraphQLClient client = GraphQLClient(
      link: link,
      cache: InMemoryCache(),
    );
    final QueryResult response = await client
        .query(
          QueryOptions(
            document: check,
            variables: <String, String>{"id": id},
          ),
        )
        .timeout(const Duration(seconds: 10));

    return response.data['checkType'];
  }

  Widget _handleRoute() {
    return FutureBuilder(
      future: _typeCheck("H6v2616cL8QUvP3mKNW1"),
      //initialData: "Loading text..",
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        print(snapshot.data);
        if (snapshot.data == "patient") {
          return PatientPage(uuid: uuid, auth: auth);
        } else {
          return MockMain(uuid: uuid, auth: auth);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _handleRoute(),
    );
  }
}
