import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_weather/core/colors/app_color_palette.dart';
import 'package:intern_weather/core/utils/kelvin_converter.dart';
import 'package:intern_weather/features/Weather/presentation/bloc/weather_bloc.dart';

class WeatherUI extends StatefulWidget {
  const WeatherUI({super.key});

  @override
  State<WeatherUI> createState() => _WeatherUIState();
}

class _WeatherUIState extends State<WeatherUI> {
  late double latitude;
  late double longitude;
  bool isLocationFetched = false;

  @override
  void initState() {
    super.initState();
  }

  String getGreetingMessage() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  String airQualityDefiner(int index) {
    if (index == 1) {
      return "Good";
    } else if (index == 2) {
      return "Fair";
    } else if (index == 3) {
      return "Moderate";
    } else if (index == 4) {
      return "Poor";
    } else if (index == 5) {
      return "Very Poor";
    } else {
      return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(),
                  RichText(
                    text: TextSpan(
                      text:
                          "Intializing The Weather App \nwritten by Jayasuriya MSJ",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is WeatherLoading) {
            return Center(
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(),
                  RichText(
                    text: TextSpan(
                      text: "Loading........",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is WeatherSuccess) {
            final weatherMain = state.currentWeatherEntity.weatherMain;
            final weatherDescription =
                state.currentWeatherEntity.weatherDescription;
            final weatherIcon = state.currentWeatherEntity.weatherIcon;
            final weatherId = state.currentWeatherEntity.weatherID;
            final weatherTemp = state.currentWeatherEntity.temperature;
            final weatherHumidity = state.currentWeatherEntity.humidity;
            final weatherWindSpeed = state.currentWeatherEntity.windSpeed;
            final weatherPressure = state.currentWeatherEntity.pressure;

            final airQuality = state.aqiEntity.aqiInVal;

            final weatheCelius = kelvinToCelsius(weatherTemp);
            final weatherFare = kelvinToFahrenheit(weatherTemp);

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 7.0, left: 7.0, bottom: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: getGreetingMessage().toString(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const Icon(
                          Icons.menu,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 30,
                        color: AppColorPalette.red,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Location Name",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                          child: ClipRect(
                            child: Image.asset(
                              "assets/icon/1.png",
                              width: 350,
                              height: 300,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColorPalette.white,
                                AppColorPalette.white,
                                AppColorPalette.black,
                              ],
                            ).createShader(bounds);
                          },
                          child: const Text(
                            '°C',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 130,
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .white, // Color is required but won't be used due to ShaderMask
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      text: state.currentWeatherEntity.weatherDescription,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        right: 5.0,
                        left: 5.0,
                        bottom: 15.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              elements(
                                Icons.wind_power,
                                weatherWindSpeed.toString(),
                                "Wind Speed",
                              ),
                              elements(
                                Icons.air,
                                airQualityDefiner(airQuality),
                                "Air Quality",
                              ),
                              elements(
                                Icons.water_,
                                weatherHumidity.toString(),
                                "Humidity",
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              elements(
                                Icons.air,
                                "Good",
                                "Air Quality",
                              ),
                              elements(
                                Icons.air,
                                "Good",
                                "Air Quality",
                              ),
                              elements(
                                Icons.air,
                                "Good",
                                "Air Quality",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            print("Current state printing from Weather_u_i.dart : $state");
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "   Error code:\n404 Not Found",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColorPalette.red,
                            fontSize: 50,
                          ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      // bottomNavigationBar: AppNavigationBar()
    );
  }

  Widget elements(
    IconData icon,
    dynamic value,
    String name,
  ) {
    return Column(
      children: [
        Icon(
          icon,
        ),
        RichText(
          text: TextSpan(
            text: value.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        RichText(
          text: TextSpan(
            text: name.toString(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
