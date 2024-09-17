// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intern_weather/features/Weather/domain/Entities/forecast_entity.dart';

class ForecastManager {
  ForecastManager._privateConstructor();

  static final ForecastManager _instance =
      ForecastManager._privateConstructor();

  // Singleton Method to avoid the creating the New Instances
  factory ForecastManager({required List<ForecastEntity> forecastEntity}) {
    _instance.forecastEntity = forecastEntity;
    return _instance;
  }

  late List<ForecastEntity> forecastEntity;

  Map<String, List<ForecastEntity>> splitByDay() {
    Map<String, List<ForecastEntity>> forecastByDay = {};
    for (var entity in forecastEntity) {
      final dateString = entity.dtTxt.substring(0, 10);

      if (forecastByDay.containsKey(dateString)) {
        forecastByDay[dateString]!.add(entity);
      } else {
        forecastByDay[dateString] = [entity];
      }
    }
    return forecastByDay;
  }

  @override
  String toString() => 'ForecastManager(forecastEntity: $forecastEntity)';
}
