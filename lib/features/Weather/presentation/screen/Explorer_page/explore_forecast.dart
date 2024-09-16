import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern_weather/core/colors/app_color_palette.dart';
import 'package:intern_weather/core/utils/date_time_service.dart';
import 'package:intern_weather/core/utils/widget_for_weather/icon_selector.dart';
import 'package:intern_weather/features/Weather/presentation/bloc/weather_bloc.dart';
import 'package:intern_weather/features/Weather/presentation/widgets/fore_cast_chart.dart';

class ExploreForecast extends StatefulWidget {
  const ExploreForecast({super.key});

  @override
  State<ExploreForecast> createState() => _ExploreForecastState();
}

class _ExploreForecastState extends State<ExploreForecast> {
  List<String> forecastDays = [];
  final List<FlSpot> spots = [
    const FlSpot(0, 1.0),
    const FlSpot(1, 30.0),
    const FlSpot(2, 1.5),
    const FlSpot(3, 3.0),
    const FlSpot(5, 2.5),
  ];
  final DateTimeService _dateTimeService = DateTimeService();
  int selectedDayIndex = 0;

  @override
  void initState() {
    super.initState();
    print(_dateTimeService.formattedDate());
    forecastDays = [
      "Today", //_dateTimeService.formattedDayWithOffset(0),
      _dateTimeService.formattedDayWithOffset(1), 
      _dateTimeService.formattedDayWithOffset(2), 
      _dateTimeService.formattedDayWithOffset(3), 
      _dateTimeService.formattedDayWithOffset(4), 
    ];
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
          } else if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherFailure) {
            return Text('Error: ${state.message}');
          } else if (state is WeatherSuccess) {
            final forecastEntities = state.forecastEntity;
            if (forecastEntities == null || forecastEntities.isEmpty) {
              return Text('No forecast data available ${forecastEntities.toString()}');
            }
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "ForeCast Report",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 7.0, left: 7.0, bottom: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: forecastDays.length,
                      itemBuilder: (context, position) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDayIndex = position;
                            });
                          },
                          child: listForecast(
                            isSelected: selectedDayIndex == position,
                            dayName: forecastDays[position],
                            icon: getWeatherIcon(500),
                            temperature: "25°C",
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: forecastDays[selectedDayIndex],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ForeCastChart(
                    spots: spots,
                  ),
                ],
              ),
            );
          } else {
            print("Current state is ${state.toString()}");
            return Center(
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Something went Wrong 🤦‍♂️",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget listForecast({
    required bool isSelected,
    required String dayName,
    required String icon,
    required String temperature,
  }) {
    return Card(
      color: isSelected
          ? AppColorPalette.lightBlue.withOpacity(0.5)
          : AppColorPalette.iceColor.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: dayName.toString(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: isSelected
                          ? AppColorPalette.black
                          : AppColorPalette.cyan,
                    ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Image.asset(
              icon,
              width: 100,
              height: 100,
            ),
            const SizedBox(
              height: 3,
            ),
            RichText(
              text: TextSpan(
                text: temperature,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: isSelected
                          ? AppColorPalette.black
                          : AppColorPalette.cyan,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
