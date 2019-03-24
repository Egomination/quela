import 'package:equatable/equatable.dart';

abstract class AuthStates extends Equatable {}

/*class BeforeAuth extends AuthStates {
  // State where user is yet to see anything
  // NOTE: A splash screen would be ideal
  @override
  String toString() => 'BeforeAuth';
}*/

class Authenticated extends AuthStates {
  // State where user is authenticated
  @override
  String toString() => 'Authenticated';
}

class Unauthenticated extends AuthStates {
  // State where user is unauthenticated
  @override
  String toString() => 'Unauthenticated';
}

class Loading extends AuthStates {
  // State where user is authentication yet to be determined
  @override
  String toString() => 'Loading';
}
