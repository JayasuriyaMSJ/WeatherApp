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
}
