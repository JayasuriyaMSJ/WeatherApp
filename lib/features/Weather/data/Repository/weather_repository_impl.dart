import 'package:fpdart/fpdart.dart';
import 'package:intern_weather/core/logs/errors/error_logs.dart';
import 'package:intern_weather/features/Weather/data/DataSource/weather_api_services.dart';
import 'package:intern_weather/features/Weather/domain/Entities/aqi_entity.dart';
import 'package:intern_weather/features/Weather/domain/Entities/current_weather_entity.dart';
import 'package:intern_weather/features/Weather/domain/Repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiServices weatherAPI;
  WeatherRepositoryImpl({required this.weatherAPI});

  @override
  Future<Either<ErrorLog, AqiEntity>> getAQI(
    double latitude,
    double longitude,
  ) async {
    try {
      final aqiData = await weatherAPI.aqiService(latitude, longitude);
      print(aqiData);
      return aqiData.fold((onError) => Left(ErrorLog(onError.toString())),
          (aqiModel) {
        final AqiEntity aqiEntity = AqiEntity(
          aqiInVal: aqiModel.airQuality,
          components: aqiModel.components,
          dateTime: aqiModel.unixDateTime,
        );
        return Right(aqiEntity);
      });
    } catch (e) {
      return Left(
        ErrorLog("Error in datat Layer Repo : ${e.toString()}"),
      );
    }
  }

  @override
  Future<Either<ErrorLog, CurrentWeatherEntity>> getCurrentWeatherData(
      double latitude, double longitude) async {
    try {
      final currentWeather =
          await weatherAPI.currentWeatherService(latitude, longitude);
      print(currentWeather);
      return currentWeather
          .fold((onError) => Left(ErrorLog(onError.toString())),
              (currentWeatherModel) {
        final CurrentWeatherEntity currentweatherEntity = CurrentWeatherEntity(
          weatherID: currentWeatherModel.weatherID,
          weatherMain: currentWeatherModel.weatherMain,
          weatherDescription: currentWeatherModel.weatherDescription,
          weatherIcon: currentWeatherModel.weatherIcon,
          temperature: currentWeatherModel.temperature,
          feelsLike: currentWeatherModel.feelsLike,
          tempMin: currentWeatherModel.tempMin,
          tempMax: currentWeatherModel.tempMax,
          pressure: currentWeatherModel.pressure,
          humidity: currentWeatherModel.humidity,
          seaLevel: currentWeatherModel.seaLevel,
          grndLevel: currentWeatherModel.grndLevel,
          visibility: currentWeatherModel.visibility,
          windSpeed: currentWeatherModel.windSpeed,
          windDeg: currentWeatherModel.windDeg,
          windGust: currentWeatherModel.windGust,
          cloudiness: currentWeatherModel.cloudiness,
          unixDateTime: currentWeatherModel.unixDateTime,
          country: currentWeatherModel.country,
          sunrise: currentWeatherModel.sunrise,
          sunset: currentWeatherModel.sunset,
          timeZone: currentWeatherModel.timeZone,
          placeID: currentWeatherModel.placeID,
          name: currentWeatherModel.name,
          cod: currentWeatherModel.cod.toString(),
        );
        return Right(currentweatherEntity);
      });
    } catch (e) {
      return Left(
        ErrorLog("Error in data Layer Repo : ${e.toString()}"),
      );
    }
  }
}
