class NpkDataModel {
  final int hour;
  final String date;
  final double soilTemperature;
  final double soilHumidity;
  final double soilConductivity;

  NpkDataModel({
    required this.hour,
    required this.date,
    required this.soilTemperature,
    required this.soilHumidity,
    required this.soilConductivity,
  });

  factory NpkDataModel.fromJson(Map<String, dynamic> json) {
    return NpkDataModel(
      hour: json['hour'],
      date: json['date'],
      soilTemperature: (json['soiltemperature'] as num).toDouble(),
      soilHumidity: (json['soilhumidity'] as num).toDouble(),
      soilConductivity: (json['soilconductivity'] as num).toDouble(),
    );
  }
}
