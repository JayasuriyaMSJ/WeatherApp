import 'dart:convert';

class CurrentWeatherModel {
  final int weatherID;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int grndLevel;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final double windGust;
  final int cloudiness;
  final DateTime unixDateTime;
  final String country;
  final DateTime sunrise;
  final DateTime sunset;
  final int timeZone;
  final int placeID;
  final String name;
  final String cod;

  CurrentWeatherModel({
    required this.weatherID,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.cloudiness,
    required this.unixDateTime,
    required this.country,
    required this.sunrise,
    required this.sunset,
    required this.timeZone,
    required this.placeID,
    required this.name,
    required this.cod,
  });

  CurrentWeatherModel copyWith({
    int? weatherID,
    String? weatherMain,
    String? weatherDescription,
    String? weatherIcon,
    double? temperature,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? humidity,
    int? seaLevel,
    int? grndLevel,
    int? visibility,
    double? windSpeed,
    int? windDeg,
    double? windGust,
    int? cloudiness,
    DateTime? unixDateTime,
    String? country,
    DateTime? sunrise,
    DateTime? sunset,
    int? timeZone,
    int? placeID,
    String? name,
    String? cod,
  }) {
    return CurrentWeatherModel(
      weatherID: weatherID ?? this.weatherID,
      weatherMain: weatherMain ?? this.weatherMain,
      weatherDescription: weatherDescription ?? this.weatherDescription,
      weatherIcon: weatherIcon ?? this.weatherIcon,
      temperature: temperature ?? this.temperature,
      feelsLike: feelsLike ?? this.feelsLike,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      seaLevel: seaLevel ?? this.seaLevel,
      grndLevel: grndLevel ?? this.grndLevel,
      visibility: visibility ?? this.visibility,
      windSpeed: windSpeed ?? this.windSpeed,
      windDeg: windDeg ?? this.windDeg,
      windGust: windGust ?? this.windGust,
      cloudiness: cloudiness ?? this.cloudiness,
      unixDateTime: unixDateTime ?? this.unixDateTime,
      country: country ?? this.country,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      timeZone: timeZone ?? this.timeZone,
      placeID: placeID ?? this.placeID,
      name: name ?? this.name,
      cod: cod ?? this.cod,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weatherID': weatherID,
      'weatherMain': weatherMain,
      'weatherDescription': weatherDescription,
      'weatherIcon': weatherIcon,
      'temperature': temperature,
      'feelsLike': feelsLike,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'pressure': pressure,
      'humidity': humidity,
      'seaLevel': seaLevel,
      'grndLevel': grndLevel,
      'visibility': visibility,
      'windSpeed': windSpeed,
      'windDeg': windDeg,
      'windGust': windGust,
      'cloudiness': cloudiness,
      'unixDateTime': unixDateTime.millisecondsSinceEpoch ~/ 1000,
      'country': country,
      'sunrise': sunrise.millisecondsSinceEpoch ~/ 1000,
      'sunset': sunset.millisecondsSinceEpoch ~/ 1000,
      'timeZone': timeZone,
      'placeID': placeID,
      'name': name,
      'cod': cod,
    };
  }

  factory CurrentWeatherModel.fromMap(Map<String, dynamic> map) {
    return CurrentWeatherModel(
      weatherID: map['weather'][0]['id'] as int,
      weatherMain: map['weather'][0]['main'] as String,
      weatherDescription: map['weather'][0]['description'] as String,
      weatherIcon: map['weather'][0]['icon'] as String,
      temperature: map['main']['temp'].toDouble(),
      feelsLike: map['main']['feels_like'].toDouble(),
      tempMin: map['main']['temp_min'].toDouble(),
      tempMax: map['main']['temp_max'].toDouble(),
      pressure: map['main']['pressure'] as int,
      humidity: map['main']['humidity'] as int,
      seaLevel: map['main']['sea_level'] as int,
      grndLevel: map['main']['grnd_level'] as int,
      visibility: map['visibility'] as int,
      windSpeed: map['wind']['speed'] as double,
      windDeg: map['wind']['deg'] as int,
      windGust: map['wind']['gust'] as double,
      cloudiness: map['cloud']['all'] as int,
      unixDateTime: DateTime.fromMillisecondsSinceEpoch(map['dt'] * 1000),
      country: map['sys']['country'] as String,
      sunrise:
          DateTime.fromMillisecondsSinceEpoch(map['sys']['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(map['sys']['sunset'] * 1000),
      timeZone: map['timeZone'] as int,
      placeID: map['id'] as int,
      name: map['name'] as String,
      cod: map['cod'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentWeatherModel.fromJson(String source) =>
      CurrentWeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CurrentWeatherModel(weatherID: $weatherID, weatherMain: $weatherMain, weatherDescription: $weatherDescription, weatherIcon: $weatherIcon, temperature: $temperature, feelsLike: $feelsLike, tempMin: $tempMin, tempMax: $tempMax, pressure: $pressure, humidity: $humidity, seaLevel: $seaLevel, grndLevel: $grndLevel, visibility: $visibility, windSpeed: $windSpeed, windDeg: $windDeg, windGust: $windGust, cloudiness: $cloudiness, unixDateTime: $unixDateTime, country: $country, sunrise: $sunrise, sunset: $sunset, timeZone: $timeZone, placeID: $placeID, name: $name, cod: $cod)';
  }

  @override
  bool operator ==(covariant CurrentWeatherModel other) {
    if (identical(this, other)) return true;

    return other.weatherID == weatherID &&
        other.weatherMain == weatherMain &&
        other.weatherDescription == weatherDescription &&
        other.weatherIcon == weatherIcon &&
        other.temperature == temperature &&
        other.feelsLike == feelsLike &&
        other.tempMin == tempMin &&
        other.tempMax == tempMax &&
        other.pressure == pressure &&
        other.humidity == humidity &&
        other.seaLevel == seaLevel &&
        other.grndLevel == grndLevel &&
        other.visibility == visibility &&
        other.windSpeed == windSpeed &&
        other.windDeg == windDeg &&
        other.windGust == windGust &&
        other.cloudiness == cloudiness &&
        other.unixDateTime == unixDateTime &&
        other.country == country &&
        other.sunrise == sunrise &&
        other.sunset == sunset &&
        other.timeZone == timeZone &&
        other.placeID == placeID &&
        other.name == name &&
        other.cod == cod;
  }

  @override
  int get hashCode {
    return weatherID.hashCode ^
        weatherMain.hashCode ^
        weatherDescription.hashCode ^
        weatherIcon.hashCode ^
        temperature.hashCode ^
        feelsLike.hashCode ^
        tempMin.hashCode ^
        tempMax.hashCode ^
        pressure.hashCode ^
        humidity.hashCode ^
        seaLevel.hashCode ^
        grndLevel.hashCode ^
        visibility.hashCode ^
        windSpeed.hashCode ^
        windDeg.hashCode ^
        windGust.hashCode ^
        cloudiness.hashCode ^
        unixDateTime.hashCode ^
        country.hashCode ^
        sunrise.hashCode ^
        sunset.hashCode ^
        timeZone.hashCode ^
        placeID.hashCode ^
        name.hashCode ^
        cod.hashCode;
  }
}
