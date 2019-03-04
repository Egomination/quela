class PatientInfo {
  String title;
  String data;
  String colour;
  PatientInfo({
    this.title,
    this.data,
    this.colour,
  });
}

// Important Info Section
List patients = <PatientInfo>[
  PatientInfo(title: "Pulse", data: "25", colour: "#FD9F45"),
  PatientInfo(title: "Temperature", data: "10", colour: "#3DA5FA"),
  PatientInfo(title: "Air Pressure", data: "15", colour: "#F56185"),
  PatientInfo(title: "Info 4", data: "5", colour: "#35BFAF"),
];

// All Info Section
List<Map<String, dynamic>> patients2 = [
  {
    "title": "Heart",
    "data": "25",
    "min": "10",
    "max": "30",
    "prefix": true,
    "suffix": false,
  },
  {
    "title": "Info 2",
    "data": "5",
    "min": "10",
    "max": "30",
    "prefix": false,
    "suffix": true,
  },
];
