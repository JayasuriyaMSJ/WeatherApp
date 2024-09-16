import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_weather/core/colors/app_color_palette.dart';
import 'package:intern_weather/core/utils/LocationService/location_service.dart';
import 'package:intern_weather/core/utils/kelvin_converter.dart';
import 'package:intern_weather/core/utils/widget_for_weather/icon_selector.dart';
import 'package:intern_weather/features/Weather/presentation/bloc/weather_bloc.dart';
import 'package:intl/intl.dart';

class WeatherUI extends StatefulWidget {
  const WeatherUI({super.key});

  @override
  State<WeatherUI> createState() => _WeatherUIState();
}

class _WeatherUIState extends State<WeatherUI> {
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
  }

  // TODO: Need to fetch location from the moblie
  // for fetched from th API openweathermap
  String getLocation() {
    // final locationName = _locationService.locationPlaceAsName(latitude, longitude)
    return 'London';
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
            final weatherSunrise = state.currentWeatherEntity.sunrise;
            final weatherSunset = state.currentWeatherEntity.sunset;
            final placeName = state.currentWeatherEntity.name;

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
                          text: placeName.toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Card(
                          color: AppColorPalette.grey.withOpacity(0.2),
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  // AppColorPalette.white,
                                  AppColorPalette.cyan,
                                  AppColorPalette.white,
                                ],
                              ).createShader(bounds);
                            },
                            child: Text(
                              '${valueFormatter(weatheCelius).toString()}°C',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 130,
                                fontWeight: FontWeight.bold,
                                color: Colors
                                    .white, // Color is required but won't be used due to ShaderMask
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                          child: ClipRect(
                            child: Image.asset(
                              getWeatherIcon(weatherId).toString(),
                              width: 350,
                              height: 250,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Weather: ",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        TextSpan(
                          text: '"${weatherMain.toUpperCase()}"',
                          style: Theme.of(context).textTheme.titleLarge,
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
                      const Icon(Icons.info_outline),
                      const SizedBox(
                        width: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: weatherDescription.toUpperCase(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
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
                                "assets/images/speed.png",
                                weatherWindSpeed.toString(),
                                "Wind Speed",
                              ),
                              elements(
                                "assets/images/wind.png",
                                airQualityDefiner(airQuality),
                                "Air Quality",
                              ),
                              elements(
                                "assets/images/humidity.png",
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
                                "assets/images/sunrise.png",
                                timeFormatter(weatherSunrise).toString(),
                                "Sun Rise",
                              ),
                              elements(
                                "assets/images/atmospheric.png",
                                weatherPressure.toString(),
                                "Pressure",
                              ),
                              elements(
                                "assets/images/sunset.png",
                                timeFormatter(weatherSunset).toString(),
                                "Sunset",
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
    String icon,
    dynamic value,
    String name,
  ) {
    return GestureDetector(
      onLongPressStart: (details) {
        print('Long press started');
      },
      onLongPressEnd: (details) {
        print("Long press ended");
      },
      child: Column(
        children: [
          Image.asset(
            icon,
            height: 25,
            width: 30,
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
      ),
    );
  }

  String timeFormatter(DateTime dateTime) {
    final DateFormat format = DateFormat('hh:mm a'); // Format for AM/PM time
    final String formattedTime = format.format(dateTime);
    return formattedTime;
  }

  String valueFormatter(double value) {
    String formatterValue = value.toStringAsFixed(0);
    return formatterValue;
  }
}
