import 'package:flutter/material.dart';

import 'package:quela/utils/auth.dart';

class MockMain extends StatelessWidget {
  MockMain({Key key, this.auth, this.uuid}) : super(key: key);

  final Auth auth;
  final String uuid;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: auth.signOut,
        child: Text(uuid),
      ),
    );
  }
}
