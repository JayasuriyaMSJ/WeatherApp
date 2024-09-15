import 'dart:convert';

class CurrentWeatherEntity {
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

  CurrentWeatherEntity({
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

  // Convert CurrentWeatherEntity to JSON map
  Map<String, dynamic> toJson() => {
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
        'unixDateTime': unixDateTime.toIso8601String(),
        'country': country,
        'sunrise': sunrise.toIso8601String(),
        'sunset': sunset.toIso8601String(),
        'timeZone': timeZone,
        'placeID': placeID,
        'name': name,
        'cod': cod,
      };

  // Convert JSON map to CurrentWeatherEntity
  factory CurrentWeatherEntity.fromJson(Map<String, dynamic> json) =>
      CurrentWeatherEntity(
        weatherID: json['weatherID'],
        weatherMain: json['weatherMain'],
        weatherDescription: json['weatherDescription'],
        weatherIcon: json['weatherIcon'],
        temperature: json['temperature'],
        feelsLike: json['feelsLike'],
        tempMin: json['tempMin'],
        tempMax: json['tempMax'],
        pressure: json['pressure'],
        humidity: json['humidity'],
        seaLevel: json['seaLevel'],
        grndLevel: json['grndLevel'],
        visibility: json['visibility'],
        windSpeed: json['windSpeed'],
        windDeg: json['windDeg'],
        windGust: json['windGust'],
        cloudiness: json['cloudiness'],
        unixDateTime: DateTime.parse(json['unixDateTime']),
        country: json['country'],
        sunrise: DateTime.parse(json['sunrise']),
        sunset: DateTime.parse(json['sunset']),
        timeZone: json['timeZone'],
        placeID: json['placeID'],
        name: json['name'],
        cod: json['cod'],
      );
}
