import 'package:flutter/material.dart';
import 'package:intern_weather/core/colors/app_color_palette.dart';

class ExploreForecast extends StatefulWidget {
  const ExploreForecast({super.key});

  @override
  State<ExploreForecast> createState() => _ExploreForecastState();
}

class _ExploreForecastState extends State<ExploreForecast> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
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
              padding:
                  const EdgeInsets.only(right: 7.0, left: 7.0, bottom: 7.0),
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
            )
          ],
        ),
      ),
    );
  }
}
