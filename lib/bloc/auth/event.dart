import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvents extends Equatable {
  AuthEvents([List props = const []]) : super(props);
}

class AppStarted extends AuthEvents {
  // Initiated after the app launch
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthEvents {
  // Initiated after a successful login
  final String token;

  LoggedIn({@required this.token}) : super([token]);

  @override
  String toString() => 'LoggedIn { token: $token }';
}

class LoggedOut extends AuthEvents {
  // Initiated after a successful logout
  @override
  String toString() => 'LoggedOut';
}
