part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class FetchAqi extends WeatherEvent {
  final double latitude;
  final double longitude;

  FetchAqi({required this.latitude, required this.longitude});
}
