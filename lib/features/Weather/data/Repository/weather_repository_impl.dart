import 'package:fpdart/fpdart.dart';
import 'package:intern_weather/core/logs/errors/error_logs.dart';
import 'package:intern_weather/features/Weather/data/DataSource/weather_api_services.dart';
import 'package:intern_weather/features/Weather/data/models/forecast_model.dart';
import 'package:intern_weather/features/Weather/domain/Entities/aqi_entity.dart';
import 'package:intern_weather/features/Weather/domain/Entities/current_weather_entity.dart';
import 'package:intern_weather/features/Weather/domain/Entities/forecast_entity.dart';
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
      print("AQI data from API: ${aqiData.toString()}");
      return aqiData.fold(
        (onError) {
          print("Error fetching AQI data: ${onError.message}");
          return Left(ErrorLog(onError.message));
        },
        (aqiModel) {
          final AqiEntity aqiEntity = AqiEntity(
            aqiInVal: aqiModel.airQuality,
            components: aqiModel.components,
            dateTime: aqiModel.unixDateTime,
          );
          print("Mapped AQI Entity: ${aqiEntity.toString()}");
          return Right(aqiEntity);
        },
      );
    } catch (e) {
      print("Exception in AQI repository: ${e.toString()}");
      return Left(
        ErrorLog("Error in data Layer Repo: ${e.toString()}"),
      );
    }
  }

  @override
  Future<Either<ErrorLog, CurrentWeatherEntity>> getCurrentWeatherData(
      double latitude, double longitude) async {
    try {
      final currentWeather =
          await weatherAPI.currentWeatherService(latitude, longitude);
      print("Current weather data from API: ${currentWeather.toString()}");
      return currentWeather.fold(
        (onError) {
          print("Error fetching current weather data: ${onError.message}");
          return Left(ErrorLog(onError.message));
        },
        (currentWeatherModel) {
          final CurrentWeatherEntity currentweatherEntity =
              CurrentWeatherEntity(
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
          print("Mapped Current Weather Entity: ${currentweatherEntity.toString()}");
          return Right(currentweatherEntity);
        },
      );
    } catch (e) {
      print("Exception in current weather repository: ${e.toString()}");
      return Left(
        ErrorLog("Error in data Layer Repo: ${e.toString()}"),
      );
    }
  }

  @override
 Future<Either<ErrorLog, List<ForecastEntity>>> getForecastData(
      double latitude, double longitude) async {
    try {
      final weatherForecast =
          await weatherAPI.weatherForecast(latitude, longitude);
      print("Weather forecast data from API: ${weatherForecast.toString()}");

      return weatherForecast.fold(
        (onError) {
          print("Error fetching forecast data: ${onError.message}");
          return Left(ErrorLog(onError.message));
        },
        (forecastList) {
          final forecastEntities = forecastList.map((forecastModel) {
            return ForecastEntity(
              temperature: forecastModel.temperature,
              weatherId: forecastModel.weatherId,
              weatherMain: forecastModel.weatherMain,
              weatherDescription: forecastModel.weatherDescription,
              weatherIcon: forecastModel.weatherIcon,
              dt: forecastModel.dt,
              dtTxt: forecastModel.dtTxt,
            );
          }).toList();
          print("Mapped Forecast Entities: ${forecastEntities.toString()}");
          return Right(forecastEntities);
        },
      );
    } catch (e) {
      print("Exception in forecast repository: ${e.toString()}");
      return Left(
        ErrorLog("Error in data Layer Repo: ${e.toString()}"),
      );
    }
  }
}
