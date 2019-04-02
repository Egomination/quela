import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PatientEvents extends Equatable {}

class Fetch extends PatientEvents {
  @override
  String toString() => 'Fetch';
}
