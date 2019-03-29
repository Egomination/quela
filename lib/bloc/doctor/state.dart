import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:quela/models/doctor.dart';

abstract class DoctorState extends Equatable {
  DoctorState([List props = const []]) : super(props);
}

class DoctorUninitialized extends DoctorState {
  @override
  String toString() => 'PatientUninitialized';
}

class DoctorLoading extends DoctorState {
  @override
  String toString() => 'PatientLoading';
}

class DoctorLoaded extends DoctorState {
  final Doctor doctor;

  DoctorLoaded({this.doctor}) : super([doctor]);

  @override
  String toString() => 'PatientLoaded';
}

class DoctorError extends DoctorState {
  final String error;

  DoctorError({@required this.error}) : super([error]);

  @override
  String toString() => 'PatientError{ error: $error }';
}
