import 'dart:convert';

class ForecastEntity {
  final double temperature;
  final int weatherId;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final DateTime dt;
  final String dtTxt;
  
  ForecastEntity({
    required this.temperature,
    required this.weatherId,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.dt,
    required this.dtTxt,
  });

  // Convert ForecastEntity to JSON map
  Map<String, dynamic> toJson() => {
        'temperature': temperature,
        'weatherId': weatherId,
        'weatherMain': weatherMain,
        'weatherDescription': weatherDescription,
        'weatherIcon': weatherIcon,
        'dt': dt.toIso8601String(),
        'dtTxt': dtTxt,
      };

  // Convert JSON map to ForecastEntity
  factory ForecastEntity.fromJson(Map<String, dynamic> json) => ForecastEntity(
        temperature: json['temperature'],
        weatherId: json['weatherId'],
        weatherMain: json['weatherMain'],
        weatherDescription: json['weatherDescription'],
        weatherIcon: json['weatherIcon'],
        dt: DateTime.parse(json['dt']),
        dtTxt: json['dtTxt'],
      );
}
