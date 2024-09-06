import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_weather/core/APIs/api_keys.dart';
import 'package:intern_weather/core/themes/app_theme.dart';
import 'package:intern_weather/core/utils/LocationService/location_service.dart';
import 'package:intern_weather/core/utils/app_preference.dart';
import 'package:intern_weather/features/Auth/presentation/screens/welcome_page.dart';
import 'package:intern_weather/features/Weather/data/DataSource/weather_api_services.dart';
import 'package:intern_weather/features/Weather/data/Repository/weather_repository_impl.dart';
import 'package:intern_weather/features/Weather/domain/use_cases/get_aqi.dart';
import 'package:intern_weather/features/Weather/presentation/bloc/weather_bloc.dart';
import 'package:intern_weather/features/Weather/presentation/screen/weather_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AppPreference pref = AppPreference();
  final LocationService locationService = LocationService();
  final WeatherApiServiceImpl weatherApiServices = WeatherApiServiceImpl(
    apiKey: ApiKeys.weatherAPIKey,
  );
  final WeatherRepositoryImpl weatherRepository = WeatherRepositoryImpl(
    weatherAPI: weatherApiServices,
  );
  final GetAqi getAqiUseCase = GetAqi(
    weatherRepository,
  );
  await pref.init();
  await locationService.init();
  runApp(MyApp(
    getAqiUseCase: getAqiUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final GetAqi getAqiUseCase;
  const MyApp({super.key, required this.getAqiUseCase});
  static const keyLoginStatus = "LoggedIn";
  static const keyUserName = "userName";

  @override
  Widget build(BuildContext context) {
    final AppPreference pref = AppPreference();
    final bool? userIsLoggedIn = pref.getBool(keyLoginStatus);
    final AppTheme appTheme = AppTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme.lighttheme,
      darkTheme: appTheme.darktheme,
      themeMode: appTheme.themeMode,
      home: BlocProvider(
        create: (_) => WeatherBloc(
          getAqiUseCase: getAqiUseCase,
        ),
        child:
            userIsLoggedIn == true ? const WeatherPage() : const WelcomePage(),
      ),
    );
  }
}
