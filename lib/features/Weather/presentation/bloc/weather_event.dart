part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class FetchAqi extends WeatherEvent {
  final double latitude;
  final double longitude;

  FetchAqi({required this.latitude, required this.longitude});
}

class FetchCurrentWeather extends WeatherEvent {
  final double latitude;
  final double longitude;

  FetchCurrentWeather({required this.latitude, required this.longitude});
}

class FetchForecast extends WeatherEvent {
  final double latitude;
  final double longitude;

  FetchForecast({required this.latitude, required this.longitude});
}
