// To parse this JSON data, do
//
//     final patient = patientFromJson(jsonString);

import 'dart:convert';

Patient patientFromJson(String str) {
  final jsonData = json.decode(str);
  return Patient.fromJson(jsonData);
}

String patientToJson(Patient data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Patient {
  String tc;
  String name;
  String surname;
  String email;
  String profilePic;
  String valTemperature;
  String valAirPressure;
  String valBloodPressure;
  String valPulse;
  DoctorId doctorId;

  Patient({
    this.tc,
    this.name,
    this.surname,
    this.email,
    this.profilePic,
    this.valTemperature,
    this.valAirPressure,
    this.valBloodPressure,
    this.valPulse,
    this.doctorId,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => new Patient(
        tc: json["TC"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        profilePic: json["profile_pic"],
        valTemperature: json["val_temperature"],
        valAirPressure: json["val_airPressure"],
        valBloodPressure: json["val_bloodPressure"],
        valPulse: json["val_pulse"],
        doctorId: DoctorId.fromJson(json["doctorID"]),
      );

  Map<String, dynamic> toJson() => {
        "TC": tc,
        "name": name,
        "surname": surname,
        "email": email,
        "profile_pic": profilePic,
        "val_temperature": valTemperature,
        "val_airPressure": valAirPressure,
        "val_bloodPressure": valBloodPressure,
        "val_pulse": valPulse,
        "doctorID": doctorId.toJson(),
      };
}

class DoctorId {
  String name;

  DoctorId({
    this.name,
  });

  factory DoctorId.fromJson(Map<String, dynamic> json) => new DoctorId(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
