part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherFailure extends WeatherState {
  final String message;
  WeatherFailure(this.message);
}

final class WeatherSuccess extends WeatherState {
  final AqiEntity? aqiEntity;
  final CurrentWeatherEntity? currentWeatherEntity;
  final List<ForecastEntity>? forecastEntity;
  WeatherSuccess({this.aqiEntity, this.currentWeatherEntity, this.forecastEntity});
}
