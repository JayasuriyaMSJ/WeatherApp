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
    setState(() {
      spots = List.from(widget.spots)..sort((a, b) => a.x.compareTo(b.x));
    });
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
                      interval: 1, // Updated interval to match time values
                      getTitlesWidget: (value, meta) {
                        return bottomTitleWidgets(value, meta);
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 5, // Adjust interval based on temperature
                      getTitlesWidget: (value, meta) {
                        return leftTitleWidgets(value, meta);
                      },
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
                maxX: 24,
                minY: 15,
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
    final hour = value.toInt();
    String timeLabel;

    if (hour == 0) {
      timeLabel = '12 \nAM';
    } else if (hour < 12) {
      timeLabel = '$hour \nAM';
    } else if (hour == 12) {
      timeLabel = '12 \nPM';
    } else {
      timeLabel = '${hour - 12} \nPM';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        timeLabel,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final temperature = value.toInt();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        "$temperature°",
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
