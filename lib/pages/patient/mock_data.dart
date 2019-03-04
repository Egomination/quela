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
var patients = <PatientInfo>[
  PatientInfo(title: "Pulse", data: "25", colour: "#FD9F45"),
  PatientInfo(title: "Temperature", data: "10", colour: "#3DA5FA"),
  PatientInfo(title: "Air Pressure", data: "15", colour: "#F56185"),
  PatientInfo(title: "Info 4", data: "5", colour: "#35BFAF"),
];

// All Info Section
var patients2 = <PatientInfo>[
  PatientInfo(
    title: "Info 1",
    data: "25",
  ),
  PatientInfo(
    title: "Info 2",
    data: "10",
  ),
  PatientInfo(
    title: "Info 3",
    data: "15",
  ),
  PatientInfo(
    title: "Info 4",
    data: "5",
  ),
  PatientInfo(
    title: "Info 5",
    data: "5",
  ),
  PatientInfo(
    title: "Info 6",
    data: "5",
  ),
];
