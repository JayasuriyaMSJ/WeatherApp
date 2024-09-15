import 'package:flutter/material.dart';
import 'package:intern_weather/core/colors/app_color_palette.dart';
import 'package:intern_weather/core/utils/design/app_navigation_bar.dart';

class WeatherUI extends StatefulWidget {
  const WeatherUI({super.key});

  @override
  State<WeatherUI> createState() => _WeatherUIState();
}

class _WeatherUIState extends State<WeatherUI> {
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
              Padding(
                padding:
                    const EdgeInsets.only(right: 7.0, left: 7.0, bottom: 7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Good Morning",
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
                        '23°C',
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
                  text: "Weather Description",
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
                      const SizedBox(
                        height: 20,
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
