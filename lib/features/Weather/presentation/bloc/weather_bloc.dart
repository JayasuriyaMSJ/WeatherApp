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
      emit(WeatherLoading());
      final result = await getAqiUseCase.execute(
        event.latitude,
        event.longitude,
      );
      result.fold(
        (onError) => emit(
          WeatherFailure(
            onError.toString(),
          ),
        ),
        (aqiEntity) => emit(
          WeatherSuccess(
            aqiEntity,
          ),
        ),
      );
    });
  }
}