import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_weather/features/Weather/domain/Entities/aqi_entity.dart';
import 'package:intern_weather/features/Weather/domain/Entities/current_weather_entity.dart';
import 'package:intern_weather/features/Weather/domain/use_cases/get_aqi.dart';
import 'package:intern_weather/features/Weather/domain/use_cases/get_current_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetAqi getAqiUseCase;
  final GetCurrentWeather getCurrentWeather;
  WeatherBloc({
    required this.getAqiUseCase,
    required this.getCurrentWeather,
  }) : super(WeatherInitial()) {
    on<FetchAqi>((event, emit) async {
      print("FetchAqi event received with coordinates: "
          "Latitude: ${event.latitude}, Longitude: ${event.longitude}");
      emit(WeatherLoading());
      try {
        print("Hello entered in Fetch AQI Event try block");
        final result = await getAqiUseCase.executeAQI(
          event.latitude,
          event.longitude,
        );
        print("getAQI data: ${result.toString()}");
        result.fold((onError) {
          print(onError);
          emit(
            WeatherFailure(
              onError.toString(),
            ),
          );
        }, (aqiEntity) {
          print(aqiEntity);
          emit(
            WeatherSuccess(
              aqiEntity: aqiEntity
            ),
          );
        });
      } on Exception catch (e) {
        print("error in FetchAQI Event ERROR:\n${e.toString()}");
        emit(
          WeatherFailure(
            e.toString(),
          ),
        );
      }
    });

    on<FetchCurrentWeather>((event, emit) async {
      print("FetchCurrentWeather event received with coordinates: "
          "Latitude: ${event.latitude}, Longitude: ${event.longitude}");
      emit(WeatherLoading());
      try {
        print("Hello entered in Fetch Current Weather Event try block");
        final result = await getCurrentWeather.executeCurrentWeather(
          event.latitude,
          event.longitude,
        );
        print("getCurrentWeather data: ${result.toString()}");
        result.fold((onError) {
          print(onError);
          emit(
            WeatherFailure(
              onError.toString(),
            ),
          );
        }, (cwEntity) {
          print(cwEntity);
          emit(
            WeatherSuccess(
              currentWeatherEntity: cwEntity
            ),
          );
        });
      } catch (e) {}
    });
  }
}
