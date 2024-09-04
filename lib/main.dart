import 'package:flutter/material.dart';
import 'package:intern_weather/core/themes/app_theme.dart';
import 'package:intern_weather/core/utils/LocationService/location_service.dart';
import 'package:intern_weather/core/utils/app_preference.dart';
import 'package:intern_weather/features/Auth/presentation/screens/welcome_page.dart';
import 'package:intern_weather/features/Weather/presentation/screen/weather_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AppPreference pref = AppPreference();
  final LocationService locationService = LocationService();
  await pref.init();
  await locationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
      home: userIsLoggedIn == true ? const WeatherPage() : const WelcomePage(),
    );
  }
}
