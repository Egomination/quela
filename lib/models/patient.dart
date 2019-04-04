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
  String roomNo;
  String illness;
  String gender;
  int age;
  String weight;
  String height;
  List<DoctorId> doctorId;
  List<Value> values;

  Patient({
    this.tc,
    this.name,
    this.surname,
    this.email,
    this.profilePic,
    this.roomNo,
    this.illness,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.doctorId,
    this.values,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => new Patient(
        tc: json["TC"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        profilePic: json["profile_pic"],
        roomNo: json["room_no"],
        illness: json["illness"],
        gender: json["gender"],
        age: json["age"],
        weight: json["weight"],
        height: json["height"],
        doctorId: new List<DoctorId>.from(
            json["doctorID"].map((x) => DoctorId.fromJson(x))),
        values:
            new List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TC": tc,
        "name": name,
        "surname": surname,
        "email": email,
        "profile_pic": profilePic,
        "room_no": roomNo,
        "illness": illness,
        "gender": gender,
        "age": age,
        "weight": weight,
        "height": height,
        "doctorID": new List<dynamic>.from(doctorId.map((x) => x.toJson())),
        "values": new List<dynamic>.from(values.map((x) => x.toJson())),
      };
}

class DoctorId {
  String id;
  String name;
  String surname;
  String proficiency;
  String profilePic;

  DoctorId({
    this.id,
    this.name,
    this.surname,
    this.proficiency,
    this.profilePic,
  });

  factory DoctorId.fromJson(Map<String, dynamic> json) => new DoctorId(
      id: json["id"],
      name: json["name"],
      surname: json["surname"],
      proficiency: json["proficiency"],
      profilePic: json["profile_pic"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "proficiency": proficiency,
        "profile_pic": profilePic,
      };
}

class Value {
  String name;
  String valCurr;
  String valMin;
  String valMax;
  int lastUpd;

  Value({
    this.name,
    this.valCurr,
    this.valMin,
    this.valMax,
    this.lastUpd,
  });

  factory Value.fromJson(Map<String, dynamic> json) => new Value(
        name: json["name"],
        valCurr: json["val_curr"],
        valMin: json["val_min"],
        valMax: json["val_max"],
        lastUpd: json["last_upd"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "val_curr": valCurr,
        "val_min": valMin,
        "val_max": valMax,
        "last_upd": lastUpd,
      };
}
