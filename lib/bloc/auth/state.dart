import 'package:equatable/equatable.dart';

abstract class AuthStates extends Equatable {}

class PatientAuthenticated extends AuthStates {
  // State where user is authenticated as patient
  @override
  String toString() => 'PatientAuthenticated';
}

class StaffAuthenticated extends AuthStates {
  // State where user is authenticated as staff
  @override
  String toString() => 'StaffAuthenticated';
}

class DoctorAuthenticated extends AuthStates {
  // State where user is authenticated as doctor
  @override
  String toString() => 'DoctorAuthenticated';
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
