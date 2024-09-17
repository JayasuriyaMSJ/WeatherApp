import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_weather/core/APIs/api_keys.dart';
import 'package:intern_weather/core/themes/app_theme.dart';
import 'package:intern_weather/core/utils/LocationService/location_service.dart';
import 'package:intern_weather/core/utils/app_preference.dart';
import 'package:intern_weather/core/utils/design/app_navigation_bar.dart';
import 'package:intern_weather/features/Weather/data/DataSource/weather_api_services.dart';
import 'package:intern_weather/features/Weather/data/Repository/weather_repository_impl.dart';
import 'package:intern_weather/features/Weather/domain/use_cases/get_aqi.dart';
import 'package:intern_weather/features/Weather/domain/use_cases/get_current_weather.dart';
import 'package:intern_weather/features/Weather/domain/use_cases/get_forecast.dart';
import 'package:intern_weather/features/Weather/presentation/bloc/weather_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print("Starting initialization...");

  final AppPreference pref = AppPreference();
  print("Initializing AppPreference...");
  await pref.init();
  print("AppPreference initialized.");

  final LocationService locationService = LocationService();
  print("Initializing LocationService...");
  await locationService.init();
  print("LocationService initialized.");

  final WeatherApiServiceImpl weatherApiServices = WeatherApiServiceImpl(
    apiKey: ApiKeys.weatherAPIKey,
  );

  final WeatherRepositoryImpl weatherRepository = WeatherRepositoryImpl(
    weatherAPI: weatherApiServices,
  );

  final GetAqi getAqiUseCase = GetAqi(
    weatherRepository,
  );

  final GetCurrentWeather getCurrentWeather = GetCurrentWeather(
    weatherRepository,
  );

  final GetForecast getForecast = GetForecast(
    weatherRepository,
  );

  print("Initialization complete. Running the app...");

  runApp(MyApp(
    getAqiUseCase: getAqiUseCase,
    getCurrentWeather: getCurrentWeather,
    getForecast: getForecast,
  ));
}

class MyApp extends StatelessWidget {
  final GetAqi getAqiUseCase;
  final GetCurrentWeather getCurrentWeather;
  final GetForecast getForecast;
  MyApp({
    super.key,
    required this.getAqiUseCase,
    required this.getCurrentWeather,
    required this.getForecast,
  });
  static const keyLoginStatus = "LoggedIn";
  static const keyUserName = "userName";
  final LocationService locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    final AppPreference pref = AppPreference();
    final bool? userIsLoggedIn = pref.getBool(keyLoginStatus);
    final AppTheme appTheme = AppTheme();
    final position = locationService.getLocationLatLog();

    print("Building MaterialApp...");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme.lighttheme,
      darkTheme: appTheme.darktheme,
      themeMode: appTheme.themeMode,
      home: //const AppNavigationBar()
          FutureBuilder(
              future: position,
              builder: (context, snap) {
                if (snap.hasData) {
                  print("Got Data from LocationService : ${snap.data}");
                  // \nLatitude: ${snap.data!['Latitude']}\nLongitude: ${snap.data!['Longitude']}");
                  final latitude = snap.data!['Latitude'];
                  final longitude = snap.data!['Longitude'];
                  return BlocProvider<WeatherBloc>(
                    create: (context) => WeatherBloc(
                      getAqiUseCase: getAqiUseCase,
                      getCurrentWeatherUseCase: getCurrentWeather,
                      getForecastUseCase: getForecast,
                    )
                      ..add(
                        FetchAqi(
                          latitude: latitude,
                          longitude: longitude,
                        ),
                      )
                      ..add(
                        FetchCurrentWeather(
                          latitude: latitude,
                          longitude: longitude,
                        ),
                      )
                      ..add(
                        FetchForecast(
                          latitude: latitude,
                          longitude: longitude,
                        ),
                      ),
                    child: const AppNavigationBar(),
                    //  userIsLoggedIn == true
                    //     ? const WeatherPage()
                    //     : const WelcomePage(),
                  );
                } else {
                  return Scaffold(
                    body: SafeArea(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center ,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Loading.....",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }),
    );
  }
}
