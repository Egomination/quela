import 'dart:convert';

Doctor doctorFromJson(String str) {
  final jsonData = json.decode(str);
  return Doctor.fromJson(jsonData);
}

String doctorToJson(Doctor data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Doctor {
  String name;
  String surname;
  String email;
  String proficiency;
  String profilePic;
  List<PatientId> patientId;

  Doctor({
    this.name,
    this.surname,
    this.email,
    this.proficiency,
    this.profilePic,
    this.patientId,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => new Doctor(
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        proficiency: json["proficiency"],
    profilePic: json["profile_pic"],
        patientId: new List<PatientId>.from(
            json["patientID"].map((x) => PatientId.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "email": email,
        "proficiency": proficiency,
    "profile_pic": profilePic,
        "patientID": new List<dynamic>.from(patientId.map((x) => x.toJson())),
      };
}

class PatientId {
  String id;
  String name;
  String surname;
  String tc;
  String profilePic;
  List<Value> values;

  PatientId({
    this.id,
    this.name,
    this.surname,
    this.tc,
    this.profilePic,
    this.values,
  });

  factory PatientId.fromJson(Map<String, dynamic> json) => new PatientId(
    id: json['id'],
    name: json["name"],
    surname: json["surname"],
    tc: json["TC"],
    profilePic: json["profile_pic"],
    values:
    new List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "surname": surname,
    "TC": tc,
    "profile_pic": profilePic,
    "values": new List<dynamic>.from(values.map((x) => x.toJson())),
  };
}

class Value {
  String name;
  String valMin;
  String valMax;
  String valCurr;

  Value({
    this.name,
    this.valMin,
    this.valMax,
    this.valCurr,
  });

  factory Value.fromJson(Map<String, dynamic> json) => new Value(
        name: json["name"],
        valMin: json["val_min"],
        valMax: json["val_max"],
        valCurr: json["val_curr"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "val_min": valMin,
        "val_max": valMax,
        "val_curr": valCurr,
      };
}
