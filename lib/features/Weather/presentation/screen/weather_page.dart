import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final location = await locationService.getLocationLatLog();
    setState(() {
      print("In Wether Page: $location");
      context.read<WeatherBloc>().add(
            FetchAqi(
              latitude: location["Latitude"],
              longitude: location["Longitude"],
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitial) {
              print("Intiaing.............................................");
              _fetchData();
            }
            if (state is WeatherLoading) {
              print("Loading........................");
            }
            if (state is WeatherSuccess) {
              print("/////////////////////////////////////////////////////");
              print(state.aqiEntity);
            }
            if (state is WeatherFailure) {
              print("/////////////////////////////////////////////////////");

              print(state.message);
            }
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Place Name and
                locwid(context),
                const Padding(
                  padding: EdgeInsets.all(15.0),
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
          },
        ),
      ),
    );
  }

  Padding locwid(BuildContext context) {
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
              child: Icon(Icons.menu),
            )
          ],
        ),
      ),
    );
  }
}
