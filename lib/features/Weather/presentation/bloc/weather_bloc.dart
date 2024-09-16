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

  AqiEntity? _aqiEntity;
  CurrentWeatherEntity? _currentWeatherEntity;
  List<ForecastEntity>? _forecastEntity;

  WeatherBloc({
    required this.getAqiUseCase,
    required this.getCurrentWeatherUseCase,
    required this.getForecastUseCase,
  }) : super(
          WeatherInitial(),
        ) {
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
        print("Received AQI data: ${result.toString()}");
        result.fold(
          (onError) {
            print("Error while fetching AQI: ${onError.toString()}");
            emit(WeatherFailure(onError.toString()));
          },
          (aqiEntity) {
            print("AQI successfully fetched: ${aqiEntity.toString()}");
            _aqiEntity = aqiEntity;
            _checkAndEmitCombinedSuccessState(emit);
            // emit(
            //   AQISuccess(
            //     aqiEntity: aqiEntity,
            //   ),
            // );
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
        print("Received current weather data: ${result.toString()}");
        result.fold(
          (onError) {
            print(
                "Error while fetching current weather: ${onError.toString()}");
            emit(WeatherFailure(onError.toString()));
          },
          (currentWeatherEntity) {
            print(
                "Current weather successfully fetched: ${currentWeatherEntity.toString()}");
            _currentWeatherEntity = currentWeatherEntity;
            _checkAndEmitCombinedSuccessState(emit);
            // emit(
            //   CurrentWeatherSuccess(
            //     currentWeatherEntity: currentWeatherEntity,
            //   ),
            // );
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
        print("Received forecast data: ${result.toString()}");
        result.fold(
          (onError) {
            print("Error while fetching forecast: ${onError.toString()}");
            emit(WeatherFailure(onError.toString()));
          },
          (forecastEntities) async {
            if (forecastEntities.isNotEmpty) {
              print(
                  "Forecast successfully fetched: ${forecastEntities.toString()}");
              _forecastEntity = forecastEntities;
              _checkAndEmitCombinedSuccessState(emit);
              // emit(
              //   ForecastSuccess(
              //     forecastEntity: forecastEntities,
              //   ),
              // );
            } else {
              print("No forecast data received");
              emit(WeatherFailure("No forecast data received"));
            }
          },
        );
      } catch (e) {
        print("Exception in FetchForecast: ${e.toString()}");
        emit(WeatherFailure(e.toString()));
      }
    });
  }

  void _checkAndEmitCombinedSuccessState(Emitter<WeatherState> emit) {
    try {
      if (_aqiEntity != null &&
          _currentWeatherEntity != null &&
          _forecastEntity != null) {
        emit(
          WeatherSuccess(
            aqiEntity: _aqiEntity!,
            currentWeatherEntity: _currentWeatherEntity!,
            forecastEntity: _forecastEntity!,
          ),
        );
      } else {
        print("Error in BLoC: ${emit.toString()}");
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
