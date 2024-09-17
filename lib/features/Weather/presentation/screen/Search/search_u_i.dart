// OUT of clean arch
// due to shortage of time

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intern_weather/core/APIs/api_keys.dart';
import 'package:intern_weather/core/city_info/city_names.dart';
import 'package:intern_weather/core/colors/app_color_palette.dart';
import 'package:intern_weather/core/utils/design/auth_field.dart';
import 'package:intern_weather/core/utils/widget_for_weather/icon_selector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';

class SearchUI extends StatefulWidget {
  const SearchUI({super.key});

  @override
  State<SearchUI> createState() => _SearchUIState();
}

class _SearchUIState extends State<SearchUI> {
  List<Map<String, dynamic>> history = [];
  final List<String> cities = CityNames.names;
  List<String> filteredCities = [];
  bool showSuggestions = false;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();
  bool summitStatus = false;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> historyJsonList =
        prefs.getStringList('weather_search_history') ?? [];
    setState(() {
      history = historyJsonList
          .map((e) => json.decode(e) as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> _saveHistory(Map<String, dynamic> result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> historyJsonList =
        prefs.getStringList('weather_search_history') ?? [];

    // Check if this result already exists in the history
    bool exists = history.any((item) =>
        item['name'] == result['name'] &&
        item['temperature'] == result['temperature']);

    if (!exists) {
      String resultJson = json.encode(result);
      historyJsonList.add(resultJson);
      await prefs.setStringList('weather_search_history', historyJsonList);

      setState(() {
        history = historyJsonList
            .map((e) => json.decode(e) as Map<String, dynamic>)
            .toList();
      });
    }
  }

  void filterCity(String query) {
    setState(() {
      filteredCities = cities
          .where((city) => city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Center(
                child: Text(
                  "Curious About the Latest Weather? Let's Dive In!",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 8),
              child: Authfield(
                hintText: "Search by City Name",
                controller: searchController,
                fun: (fun) => filterCity(fun),
                tapFun: () {
                  setState(() {
                    showSuggestions = true;
                  });
                },
                tapOut: (_) => showSuggestions = false,
                onSaved: (value) {
                  setState(() {
                    showSuggestions = false;
                    _focusNode.unfocus();
                    summitStatus = true;
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    showSuggestions = false;
                    _focusNode.unfocus();
                    summitStatus = true;
                  });
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    showSuggestions = false;
                    _focusNode.unfocus();
                    summitStatus = true;
                  });
                },
                onFocus: _focusNode,
              ),
            ),
            // Display filtered city suggestions
            showSuggestions && filteredCities.isNotEmpty
                ? SizedBox(
                    height: 200,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ListView.builder(
                        shrinkWrap:
                            true, // Makes the list view only as big as its content
                        physics:
                            const NeverScrollableScrollPhysics(), // Disables scrolling
                        itemCount: showSuggestions ? filteredCities.length : 0,
                        itemBuilder: (context, position) {
                          return ListTile(
                            title: Text(filteredCities[position]),
                            onTap: () {
                              searchController.text = filteredCities[position];
                              setState(() {
                                showSuggestions = false;
                                _focusNode.unfocus();
                                summitStatus = true;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  )
                : summitStatus && searchController.text.isNotEmpty
                    ? FutureBuilder<Weather>(
                        future: _fetchWeather(searchController.text),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                'Error fetching weather data: ${snapshot.error}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            Weather weather = snapshot.data!;
                            Map<String, dynamic> result = {
                              'name': weather.areaName ?? 'Unknown Location',
                              'temperature': weather.temperature?.celsius
                                      ?.toStringAsFixed(1) ??
                                  'N/A',
                              'id':
                                  weather.weatherConditionCode?.toInt() ?? 800,
                            };
                            _saveHistory(result);
                            return searchHistory(
                              history: false,
                              icon:
                                  getWeatherIcon(weather.weatherConditionCode!),
                              placeName: weather.areaName ?? 'Unknown Location',
                              temperature: weather.temperature?.celsius
                                      ?.toStringAsFixed(1) ??
                                  'N/A',
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text('No results found'),
                            );
                          }
                        },
                      )
                    : Expanded(
                        child: Center(
                          child: RichText(
                            text: const TextSpan(
                                text: "Start Searching to Display Result"),
                          ),
                        ),
                      ),

            const Divider(thickness: 1),
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
              child: Text('Search History'),
            ),
            const SizedBox(height: 8),
            history.isNotEmpty
                ? Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: history.length,
                        itemBuilder: (context, index) {
                          final item = history[index];
                          return searchHistory(
                            history: true,
                            icon: getWeatherIcon(item['id']),
                            placeName: item['name'],
                            temperature: item['temperature'],
                          );
                        },
                      ),
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('No search history'),
                  ),
          ],
        ),
      ),
    );
  }

  Future<Weather> _fetchWeather(String cityName) async {
    if (cityName.isEmpty) {
      throw Exception("City name cannot be empty");
    }

    final WeatherFactory wf = WeatherFactory(ApiKeys.weatherAPIKey);
    Weather weather = await wf.currentWeatherByCityName(cityName);

    return weather;
  }

  Widget searchHistory({
    required bool history,
    required String icon,
    required String placeName,
    required String temperature,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: history
                ? AppColorPalette.grey.withOpacity(0.2)
                : AppColorPalette.cyan.withOpacity(0.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    icon,
                    height: 150,
                    width: 150,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: placeName,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: temperature,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
