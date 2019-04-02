import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class StaffEvents extends Equatable {
  StaffEvents([List props = const []]) : super(props);
}

class CreatePatientEvent extends StaffEvents {
  final String email;
  final String password;
  final String name;
  final String surname;
  final String tc;
  final String profilePic;

  CreatePatientEvent({
    @required this.email,
    @required this.password,
    @required this.name,
    @required this.surname,
    @required this.tc,
    @required this.profilePic,
  }) : super([email, password, name, surname, tc, profilePic]);

  @override
  String toString() => 'Account Creation';
}
