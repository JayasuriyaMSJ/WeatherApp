import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_weather/features/Weather/domain/Entities/aqi_entity.dart';
import 'package:intern_weather/features/Weather/domain/Entities/current_weather_entity.dart';
import 'package:intern_weather/features/Weather/domain/Entities/forecast_entity.dart';
import 'package:intern_weather/features/Weather/domain/use_cases/get_aqi.dart';
import 'package:intern_weather/features/Weather/domain/use_cases/get_current_weather.dart';
import 'package:intern_weather/features/Weather/domain/use_cases/get_forecast.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetAqi getAqiUseCase;
  final GetCurrentWeather getCurrentWeatherUseCase;
  final GetForecast getForecastUseCase;

  WeatherBloc({
    required this.getAqiUseCase,
    required this.getCurrentWeatherUseCase,
    required this.getForecastUseCase,
  }) : super(WeatherInitial()) {
    on<FetchAqi>((event, emit) async {
      print("FetchAqi event received with coordinates: "
          "Latitude: ${event.latitude}, Longitude: ${event.longitude}");
      emit(WeatherLoading());
      try {
        print("Started fetching AQI for coordinates "
            "Lat: ${event.latitude}, Lon: ${event.longitude}");
        final result = await getAqiUseCase.executeAQI(
          event.latitude,
          event.longitude,
        );
        print("Received AQI data: $result");
        result.fold(
          (onError) {
            print("Error while fetching AQI: ${onError.toString()}");
            emit(WeatherFailure(onError.toString()));
          },
          (aqiEntity) {
            print("AQI successfully fetched: $aqiEntity");
            emit(WeatherSuccess(aqiEntity: aqiEntity));
          },
        );
      } on Exception catch (e) {
        print("Exception in FetchAQI: ${e.toString()}");
        emit(WeatherFailure(e.toString()));
      }
    });

    on<FetchCurrentWeather>((event, emit) async {
      print("FetchCurrentWeather event received with coordinates: "
          "Latitude: ${event.latitude}, Longitude: ${event.longitude}");
      emit(WeatherLoading());
      try {
        print("Started fetching current weather for coordinates "
            "Lat: ${event.latitude}, Lon: ${event.longitude}");
        final result = await getCurrentWeatherUseCase.executeCurrentWeather(
          event.latitude,
          event.longitude,
        );
        print("Received current weather data: $result");
        result.fold(
          (onError) {
            print(
                "Error while fetching current weather: ${onError.toString()}");
            emit(WeatherFailure(onError.toString()));
          },
          (currentWeatherEntity) {
            print(
                "Current weather successfully fetched: $currentWeatherEntity");
            emit(WeatherSuccess(currentWeatherEntity: currentWeatherEntity));
          },
        );
      } catch (e) {
        print("Exception in FetchCurrentWeather: ${e.toString()}");
        emit(WeatherFailure(e.toString()));
      }
    });

    on<FetchForecast>((event, emit) async {
      print("FetchForecast event received with coordinates: "
          "Latitude: ${event.latitude}, Longitude: ${event.longitude}");
      emit(WeatherLoading());
      try {
        print("Started fetching forecast for coordinates "
            "Lat: ${event.latitude}, Lon: ${event.longitude}");
        final result = await getForecastUseCase.executeForecast(
          event.latitude,
          event.longitude,
        );
        print("Received forecast data: $result");
        result.fold(
          (onError) {
            print("Error while fetching forecast: ${onError.toString()}");
            emit(WeatherFailure(onError.toString()));
          },
          (forecastEntities) {
            print("Forecast successfully fetched: $forecastEntities");
            emit(WeatherSuccess(forecastEntity: forecastEntities));
          },
        );
      } catch (e) {
        print("Exception in FetchForecast: ${e.toString()}");
        emit(WeatherFailure(e.toString()));
      }
    });
  }
}
