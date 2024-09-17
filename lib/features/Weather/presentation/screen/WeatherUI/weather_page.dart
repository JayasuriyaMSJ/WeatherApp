import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_weather/core/colors/app_color_palette.dart';
import 'package:intern_weather/core/utils/LocationService/location_service.dart';
import 'package:intern_weather/core/utils/date_time_service.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:intern_weather/features/Weather/presentation/bloc/weather_bloc.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final DateTimeService date = DateTimeService();
  final LocationService locationService = LocationService();
  Future<String> locationName() async {
    final currentLocation = await locationService.curlocationPlaceAsName();
    print("currentLocation :  $currentLocation");
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherSuccess) {
                try {
                  // print(
                  //     "Result of AQI Class: ${state.aqiEntity!.aqiInVal},\n${state.aqiEntity!.components},\n${state.aqiEntity!.dateTime},");
                      // print(
  // "Result of Current Weather: Weather ID = ${state.currentWeatherEntity!.weatherID},\nWeather Main = ${state.currentWeatherEntity!.weatherMain},\nWeather Description = ${state.currentWeatherEntity!.weatherDescription},\nWeather Icon = ${state.currentWeatherEntity!.weatherIcon},\nTemperature = ${state.currentWeatherEntity!.temperature},\nFeels Like = ${state.currentWeatherEntity!.feelsLike},\nTemp Min = ${state.currentWeatherEntity!.tempMin},\nTemp Max = ${state.currentWeatherEntity!.tempMax},\nPressure = ${state.currentWeatherEntity!.pressure},\nHumidity = ${state.currentWeatherEntity!.humidity},\nSea Level = ${state.currentWeatherEntity!.seaLevel},\nGrnd Level = ${state.currentWeatherEntity!.grndLevel},\nVisibility = ${state.currentWeatherEntity!.visibility},\nWind Speed = ${state.currentWeatherEntity!.windSpeed},\nWind Deg = ${state.currentWeatherEntity!.windDeg},\nWind Gust = ${state.currentWeatherEntity!.windGust},\nCloudiness = ${state.currentWeatherEntity!.cloudiness},\nUnix DateTime = ${state.currentWeatherEntity!.unixDateTime},\nCountry = ${state.currentWeatherEntity!.country},\nSunrise = ${state.currentWeatherEntity!.sunrise},\nSunset = ${state.currentWeatherEntity!.sunset},\nTime Zone = ${state.currentWeatherEntity!.timeZone},\nPlace ID = ${state.currentWeatherEntity!.placeID},\nName = ${state.currentWeatherEntity!.name},\nCOD = ${state.currentWeatherEntity!.cod}"
// );
                  if (state.currentWeatherEntity != null) {
                    print("Result of AQI Weather class: ${state.aqiEntity.toString()}");
                    print("Result of Current Weather class: ${state.currentWeatherEntity.toString()}");
                    // print("Result of Current Weather class: ${state.currentWeatherEntity.toString()}");
                  } else {
                    print("null");
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20.0, left: 20.0, top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "Good Morning",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            const Align(
                              alignment: Alignment.topCenter,
                              child: Icon(
                                Icons.menu,
                                size: 35,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on),
                                      const SizedBox(
                                        width: 5 + 2,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: state.currentWeatherEntity?.name != null? state.currentWeatherEntity!.name : "Unknown" 
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: date.formattedDate(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 7.56,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 15.0, left: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("18"),
                                Text("data"),
                              ],
                            ),
                            Icon(Icons.telegram)
                          ],
                        ),
                      ),
                    ],
                  );
                } on Exception catch (e) {
                  return Scaffold(
                    body: Center(
                      child: RichText(
                          text: TextSpan(text: "Error:\n ${e.toString()}")),
                    ),
                  );
                }
              } else {
                print(state);
                return Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Error while Building",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColorPalette.red,
                          ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

// Not Used because changed the method fetching the location Method is BLOC
  Padding loc_wid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(
                      width: 5,
                    ),
                    FutureBuilder<List<geo.Placemark>>(
                        future: locationService.curlocationPlaceAsName(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<geo.Placemark>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            final placemarks = snapshot.data!;
                            final address = placemarks.isNotEmpty
                                ? placemarks[0]
                                    .locality
                                    .toString() // or format the placemark as needed
                                : 'No address found';
                            final country = placemarks.isNotEmpty
                                ? placemarks[0].isoCountryCode.toString()
                                : 'No Country Code Found';
                            return RichText(
                              text: TextSpan(
                                text: "$address $country",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text('No data available'),
                            );
                          }
                        }),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: date.formattedDate(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Icon(
                Icons.menu,
                size: 35,
              ),
            )
          ],
        ),
      ),
    );
  }
}
