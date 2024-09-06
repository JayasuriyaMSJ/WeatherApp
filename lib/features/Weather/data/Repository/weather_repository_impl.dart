import 'package:fpdart/fpdart.dart';
import 'package:intern_weather/core/logs/errors/error_logs.dart';
import 'package:intern_weather/features/Weather/data/DataSource/weather_api_services.dart';
import 'package:intern_weather/features/Weather/domain/Entities/aqi_entity.dart';
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
}
