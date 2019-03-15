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
  DoctorId doctorId;
  List<Value> values;

  Patient({
    this.tc,
    this.name,
    this.surname,
    this.email,
    this.profilePic,
    this.doctorId,
    this.values,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => new Patient(
        tc: json["TC"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        profilePic: json["profile_pic"],
        doctorId: DoctorId.fromJson(json["doctorID"]),
    values:
    new List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TC": tc,
        "name": name,
        "surname": surname,
        "email": email,
        "profile_pic": profilePic,
        "doctorID": doctorId.toJson(),
    "values": new List<dynamic>.from(values.map((x) => x.toJson())),
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

class Value {
  String name;
  String valCurr;
  String valMin;
  String valMax;

  Value({
    this.name,
    this.valCurr,
    this.valMin,
    this.valMax,
  });

  factory Value.fromJson(Map<String, dynamic> json) =>
      new Value(
        name: json["name"],
        valCurr: json["val_curr"],
        valMin: json["val_min"],
        valMax: json["val_max"],
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "val_curr": valCurr,
        "val_min": valMin,
        "val_max": valMax,
      };
}
