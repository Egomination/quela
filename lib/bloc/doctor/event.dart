import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DoctorEvents extends Equatable {}

class DoctorFetch extends DoctorEvents {
  @override
  String toString() => 'DoctorFetch';
}

class DoctorUpdate extends DoctorEvents {
  @override
  String toString() => 'DoctorUpdate';
}
