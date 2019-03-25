import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:quela/models/patient.dart';

@immutable
abstract class PatientState extends Equatable {
  PatientState([List props = const []]) : super(props);
}

class PatientUninitialized extends PatientState {
  @override
  String toString() => 'PatientUninitialized';
}

class PatientLoading extends PatientState {
  @override
  String toString() => 'PatientLoading';
}

class PatientLoaded extends PatientState {
  final Patient patient;

  PatientLoaded({this.patient}) : super([patient]);

  @override
  String toString() => 'PatientLoaded';
}

class PatientError extends PatientState {
  final String error;

  PatientError({@required this.error}) : super([error]);

  @override
  String toString() => 'PatientError{ error: $error }';
}
