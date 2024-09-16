import 'package:intern_weather/features/Weather/domain/Entities/forecast_entity.dart';

class ForecastManager {
  // Private constructor
  ForecastManager._privateConstructor();

  // The single instance of ForecastManager
  static final ForecastManager _instance =
      ForecastManager._privateConstructor();

  // Factory constructor to return the same instance
  factory ForecastManager({required List<ForecastEntity> forecastEntity}) {
    _instance.forecastEntity = forecastEntity;
    return _instance;
  }

  late List<ForecastEntity> forecastEntity;

  // Method to split forecasts by day
  Map<DateTime, List<ForecastEntity>> splitByDay() {
    Map<DateTime, List<ForecastEntity>> forecastByDay = {};
    for (var entity in forecastEntity) {
      DateTime date = DateTime(entity.dt.year, entity.dt.month, entity.dt.day);

      if (forecastByDay.containsKey(date)) {
        forecastByDay[date]!.add(entity);
      } else {
        forecastByDay[date] = [entity];
      }
    }
    return forecastByDay;
  }

  @override
  String toString() {
    final forecastByDay = splitByDay();
    StringBuffer buffer = StringBuffer();
    buffer.writeln(
        'ForecastManager: ${forecastEntity.length} forecast entities managed');
    forecastByDay.forEach((date, entities) {
      buffer.writeln('Date: ${date.toIso8601String()}');
      for (var entity in entities) {
        buffer.writeln('  ${entity.toString()}');
      }
    });
    return buffer.toString();
  }
}
