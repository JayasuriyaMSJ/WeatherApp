import 'dart:convert';

class ForecastModel {
  final double temperature;
  final int weatherId;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final DateTime dt;
  final String dtTxt;

  ForecastModel({
    required this.temperature,
    required this.weatherId,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.dt,
    required this.dtTxt,
  });

  ForecastModel copyWith({
    double? temperature,
    int? weatherId,
    String? weatherMain,
    String? weatherDescription,
    String? weatherIcon,
    DateTime? dt,
    String? dtTxt,
  }) {
    return ForecastModel(
      temperature: temperature ?? this.temperature,
      weatherId: weatherId ?? this.weatherId,
      weatherMain: weatherMain ?? this.weatherMain,
      weatherDescription: weatherDescription ?? this.weatherDescription,
      weatherIcon: weatherIcon ?? this.weatherIcon,
      dt: dt ?? this.dt,
      dtTxt: dtTxt ?? this.dtTxt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'temperature': temperature,
      'weatherId': weatherId,
      'weatherMain': weatherMain,
      'weatherDescription': weatherDescription,
      'weatherIcon': weatherIcon,
      'dt': dt.millisecondsSinceEpoch,
      'dtTxt': dtTxt,
    };
  }

  factory ForecastModel.fromMap(Map<String, dynamic> map) {
    return ForecastModel(
      temperature: map['main']['temp']?.toDouble() ?? 0.0,
      weatherId: map['weather'][0]['id'] as int,
      weatherMain:  map['weather'][0]['main'] as String,
      weatherDescription: map['weather'][0]['description'] as String,
      weatherIcon: map['weather'][0]['icon'] as String,
      dt: DateTime.fromMillisecondsSinceEpoch(map['dt'] * 1000 as int),
      dtTxt: map['dt_txt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForecastModel.fromJson(String source) => ForecastModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ForecastModel(temperature: $temperature, weatherId: $weatherId, weatherMain: $weatherMain, weatherDescription: $weatherDescription, weatherIcon: $weatherIcon, dt: $dt, dtTxt: $dtTxt)';
  }

  @override
  bool operator ==(covariant ForecastModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.temperature == temperature &&
      other.weatherId == weatherId &&
      other.weatherMain == weatherMain &&
      other.weatherDescription == weatherDescription &&
      other.weatherIcon == weatherIcon &&
      other.dt == dt &&
      other.dtTxt == dtTxt;
  }

  @override
  int get hashCode {
    return temperature.hashCode ^
      weatherId.hashCode ^
      weatherMain.hashCode ^
      weatherDescription.hashCode ^
      weatherIcon.hashCode ^
      dt.hashCode ^
      dtTxt.hashCode;
  }
}

// To avoid the error and handle the multiple weather at the time
// Parsing function for the entire forecast data
List<ForecastModel> parseForecastList(String responseBody) {
  final parsed = json.decode(responseBody);
  final list = parsed['list'] as List<dynamic>;
  return list.map((json) => ForecastModel.fromMap(json as Map<String, dynamic>)).toList();
}