class PatientInfo {
  String title;
  String data;
  String colour;
  String min;
  String max;

  PatientInfo({
    this.title,
    this.data,
    this.colour,
    this.min,
    this.max,
  });
}

// Important Info Section
var patients = <PatientInfo>[
  PatientInfo(title: "Pulse", data: "25", colour: "#FD9F45"),
  PatientInfo(title: "Temperature", data: "10", colour: "#3DA5FA"),
  PatientInfo(title: "Air Pressure", data: "15", colour: "#F56185"),
  PatientInfo(title: "Info 4", data: "5", colour: "#35BFAF"),
];

// All Info Section
var patients2 = <PatientInfo>[
  PatientInfo(
    title: "Heart",
    data: "25",
    min: "10",
    max: "30",
  ),
  PatientInfo(
    title: "Info 2",
    data: "5",
    min: "10",
    max: "30",
  ),
];
