////// *********** IMPORTANT **************** /////////
// It took me a week to solve the issue in this class.
// The problem was that I initially attempted to use a single class (`WeatherSuccess`)
// to represent the success state for all three events (AQI, CurrentWeather, and Forecast).
// I thought this would allow me to access the properties of all three success states
// in one place.
//
// However, since the three events (`FetchAqi`, `FetchCurrentWeather`, and `FetchForecast`)
// were fired at different times, every time a new event was handled,
// a new instance of the `WeatherSuccess` state was created with only the most recent data,
// while the other properties (from the previous events) would be null.
//
// For example, if `FetchCurrentWeather` was the last event handled,
// the state would contain only `currentWeatherEntity`,
// and `aqiEntity` and `forecastEntity` would be null.
//
// The solution was to create separate classes for each event's success state
// (e.g., `AQISuccess`, `CurrentWeatherSuccess`, `ForecastSuccess`),
// allowing each event to maintain its own state independently without overriding
// the previous data.

// final class WeatherSuccess extends WeatherState {
//   final AqiEntity? aqiEntity;
//   final CurrentWeatherEntity? currentWeatherEntity;
//   final List<ForecastEntity>? forecastEntity;

//   WeatherSuccess({
//      this.aqiEntity,
//      this.currentWeatherEntity,
//      this.forecastEntity,
//   });
// }

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
  final AqiEntity aqiEntity;
  final CurrentWeatherEntity currentWeatherEntity;
  final List<ForecastEntity> forecastEntity;

  WeatherSuccess({
    required this.aqiEntity,
    required this.currentWeatherEntity,
    required this.forecastEntity,
  });
}

final class AQISuccess extends WeatherState {
  final AqiEntity aqiEntity;

  AQISuccess({required this.aqiEntity});
}

final class CurrentWeatherSuccess extends WeatherState {
  final CurrentWeatherEntity currentWeatherEntity;

  CurrentWeatherSuccess({required this.currentWeatherEntity});
}

final class ForecastSuccess extends WeatherState {
  final List<ForecastEntity> forecastEntity;

  ForecastSuccess({required this.forecastEntity});
}
