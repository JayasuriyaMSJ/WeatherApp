import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_weather/features/Weather/domain/Entities/aqi_entity.dart';
import 'package:intern_weather/features/Weather/domain/use_cases/get_aqi.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetAqi getAqiUseCase;
  WeatherBloc({
    required this.getAqiUseCase,
  }) : super(WeatherInitial()) {
    on<FetchAqi>((event, emit) async {
      print("FetchAqi event received with coordinates: "
          "Latitude: ${event.latitude}, Longitude: ${event.longitude}");
      emit(WeatherLoading());
      try {
        print("Hello");
        final result = await getAqiUseCase.execute(
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
              aqiEntity,
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
  }
}
