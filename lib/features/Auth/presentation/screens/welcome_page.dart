import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intern_weather/core/utils/app_preference.dart';
import 'package:intern_weather/core/utils/design/auth_button.dart';
import 'package:intern_weather/core/utils/design/auth_field.dart';
import 'package:intern_weather/features/Weather/presentation/screen/weather_page.dart';
import 'package:intern_weather/main.dart';

class WelcomePage extends StatefulWidget {
  static route(page) => MaterialPageRoute(builder: (context) => page);
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final AppPreference pref = AppPreference();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(23.0),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Hello Welcome\n         Let's get Started",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Authfield(hintText: "Name", controller: nameController),
                  const SizedBox(
                    height: 20,
                  ),
                  Authbutton(
                      content: "Start",
                      onpressed: () {
                        if (formKey.currentState!.validate()) {
                          pref.setBool(
                            MyApp.keyLoginStatus,
                            true,
                          );
                          pref.setString(
                            MyApp.keyUserName,
                            nameController.text.toString(),
                          );
                          Navigator.pushReplacement(
                            context,
                            WelcomePage.route(
                              const WeatherPage(),
                            ),
                          );
                        }
                      }),
                  const SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
