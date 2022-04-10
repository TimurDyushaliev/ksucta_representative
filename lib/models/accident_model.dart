class AccidentModel {
  const AccidentModel({
    required this.fullName,
    required this.address,
    required this.dateTime,
    required this.vehicle,
    required this.vehicleNumber,
    required this.vehicleBrand,
  });

  final String fullName;
  final String address;
  final String dateTime;
  final String vehicle;
  final String vehicleNumber;
  final String vehicleBrand;

  factory AccidentModel.fromMap(Map<dynamic, dynamic> map) {
    return AccidentModel(
      fullName: map['full_name'] as String,
      address: map['address'] as String,
      dateTime: map['date_time'] as String,
      vehicle: map['vehicle'] as String,
      vehicleNumber: map['vehicle_number'] as String,
      vehicleBrand: map['vehicle_brand'] as String,
    );
  }

  factory AccidentModel.fromTexts(List<String> texts) {
    return AccidentModel(
      fullName: texts[0],
      address: texts[1],
      dateTime: texts[2],
      vehicle: texts[3],
      vehicleNumber: texts[4],
      vehicleBrand: texts[5],
    );
  }

  Map<String, String> toJson() {
    return {
      'full_name': fullName,
      'address': address,
      'date_time': dateTime,
      'vehicle': vehicle,
      'vehicle_number': vehicleNumber,
      'vehicle_brand': vehicleBrand,
    };
  }
}
