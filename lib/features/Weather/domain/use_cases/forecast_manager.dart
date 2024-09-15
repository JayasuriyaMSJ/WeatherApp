import 'package:intern_weather/features/Weather/domain/Entities/forecast_entity.dart';

class ForecastManager {
  final List<ForecastEntity> forecasts;

  ForecastManager(this.forecasts);

  List<ForecastEntity> filterByDay(DateTime targetDate) {
    return forecasts.where((forecast) {
      final forecastDate = DateTime.parse(forecast.dtTxt).toLocal();
      return _isSameDay(forecastDate, targetDate);
    }).toList();
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}

// void main() {
//   final forecastDate = DateTime.parse("2024-09-16 06:00:00").toLocal();
//   print(forecastDate);
// }
