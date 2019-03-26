import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class StaffEvents extends Equatable {
  StaffEvents([List props = const []]) : super(props);
}

class CreatePatient extends StaffEvents {
  final String email;
  final String password;
  final String name;
  final String surname;
  final String tc;
  final String profilePic;

  CreatePatient({
    @required this.email,
    @required this.password,
    @required this.name,
    @required this.surname,
    @required this.tc,
    @required this.profilePic,
  }) : super([email, password, name, surname, tc, profilePic]);

  @override
  String toString() =>
      'Account Created: { email: $email, password: $password }';
}
