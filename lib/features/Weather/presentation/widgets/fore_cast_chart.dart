import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intern_weather/core/colors/app_color_palette.dart';

class ForeCastChart extends StatefulWidget {
  final List<FlSpot> spots;
  const ForeCastChart({super.key, required this.spots});

  @override
  State<ForeCastChart> createState() => _ForeCastChartState();
}

class _ForeCastChartState extends State<ForeCastChart> {
  late final List<FlSpot> spots;

  @override
  void initState() {
    super.initState();
    spots = widget.spots; // Initialize the spots from the widget
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 756,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(
                  show: true,
                ),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 1,
                      getTitlesWidget: bottomTitleWidgets,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 5,
                      getTitlesWidget: leftTitleWidgets,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                  border: Border.all(
                    color: AppColorPalette.lightBackground,
                    width: 2,
                  ),
                ),
                minX: 0,
                maxX: 8,
                minY: 0,
                maxY: 40,
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: AppColorPalette.blue,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(show: true),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final titles = [
      '0:00 ',
      '3:00 ',
      '6:00 ',
      '9:00 ',
      '12:00 ',
      '15:00 ',
      '18:00 ',
      '21:00 ',
      '24:00 '
    ];
    // final title = (value.toInt() >= 0 && value.toInt() < titles.length)
    //     ? titles[value.toInt()]
    //     : '';
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        "${titles[value.toInt()]}\n hrs",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final temperature = value.toInt();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        "$temperature°",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
