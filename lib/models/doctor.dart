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
  String gender;
  int age;
  String hospitalName;
  String telephone;
  List<PatientId> patientId;

  Doctor({
    this.name,
    this.surname,
    this.email,
    this.proficiency,
    this.profilePic,
    this.patientId,
    this.gender,
    this.age,
    this.hospitalName,
    this.telephone,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => new Doctor(
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        proficiency: json["proficiency"],
        profilePic: json["profile_pic"],
        gender: json["gender"],
        age: json["age"],
        hospitalName: json["hospital_name"],
        telephone: json["telephone"],
        patientId: new List<PatientId>.from(
            json["patientID"].map((x) => PatientId.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "email": email,
        "proficiency": proficiency,
        "profile_pic": profilePic,
        "gender": gender,
        "age": age,
        "hospital_name": hospitalName,
        "telephone": telephone,
        "patientID": new List<dynamic>.from(patientId.map((x) => x.toJson())),
      };
}

class PatientId {
  String id;
  String name;
  String surname;
  String tc;
  String profilePic;
  String roomNo;
  String illness;
  String gender;
  int age;
  String weight;
  String height;
  String telephone;
  List<Value> values;

  PatientId({
    this.id,
    this.name,
    this.surname,
    this.tc,
    this.profilePic,
    this.roomNo,
    this.illness,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.telephone,
    this.values,
  });

  factory PatientId.fromJson(Map<String, dynamic> json) => new PatientId(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        tc: json["TC"],
        profilePic: json["profile_pic"],
        roomNo: json["room_no"],
        illness: json["illness"],
        gender: json["gender"],
        age: json["age"],
        weight: json["weight"],
        height: json["height"],
        telephone: json["telephone"],
        values:
            new List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "TC": tc,
        "profile_pic": profilePic,
        "room_no": roomNo,
        "illness": illness,
        "gender": gender,
        "age": age,
        "weight": weight,
        "height": height,
        "telephone": telephone,
        "values": new List<dynamic>.from(values.map((x) => x.toJson())),
      };
}

class Value {
  String name;
  String valMin;
  String valMax;
  String valCurr;
  int lastUpd;

  Value({
    this.name,
    this.valMin,
    this.valMax,
    this.valCurr,
    this.lastUpd,
  });

  factory Value.fromJson(Map<String, dynamic> json) => new Value(
        name: json["name"],
        valMin: json["val_min"],
        valMax: json["val_max"],
        valCurr: json["val_curr"],
        lastUpd: json["last_upd"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "val_min": valMin,
        "val_max": valMax,
        "val_curr": valCurr,
        "last_upd": lastUpd,
      };
}
