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
  final String roomNo;
  final String illness;
  final String gender;
  final String age;
  final String weight;
  final String height;
  final String telephone;

  CreatePatientEvent({
    @required this.email,
    @required this.password,
    @required this.name,
    @required this.surname,
    @required this.tc,
    @required this.profilePic,
    @required this.roomNo,
    @required this.illness,
    @required this.gender,
    @required this.age,
    @required this.weight,
    @required this.height,
    @required this.telephone,
  }) : super([
          email,
          password,
          name,
          surname,
          tc,
          profilePic,
          roomNo,
          illness,
          gender,
          age,
          weight,
          height,
          telephone
        ]);

  @override
  String toString() => 'Account Creation';
}

class UpdatePatientDataEvent extends StaffEvents {
  final String id;
  final String value;
  final String field;

  UpdatePatientDataEvent({
    @required this.id,
    @required this.value,
    @required this.field,
  }) : super([id, value, field]);

  @override
  String toString() => 'Field Updated';
}
