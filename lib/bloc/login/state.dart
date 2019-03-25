import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginStates extends Equatable {
  LoginStates([List props = const []]) : super(props);
}

class BeforeLogin extends LoginStates {
  @override
  String toString() => 'BeforeLogin';
}

class LoginLoading extends LoginStates {
  @override
  String toString() => 'Loading';
}

class Failure extends LoginStates {
  final String error;

  Failure({@required this.error}) : super([error]);

  @override
  String toString() => 'Failure { error: $error }';
}
