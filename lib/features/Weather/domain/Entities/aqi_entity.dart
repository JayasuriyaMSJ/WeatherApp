import 'dart:convert';

class AqiEntity {
  int aqiInVal;
  Map<String, double> components;
  DateTime dateTime;
  
  AqiEntity({
    required this.aqiInVal,
    required this.components,
    required this.dateTime,
  });

  // Convert AqiEntity to JSON map
  Map<String, dynamic> toJson() => {
        'aqiInVal': aqiInVal,
        'components': components,
        'dateTime': dateTime.toIso8601String(),
      };

  // Convert JSON map to AqiEntity
  factory AqiEntity.fromJson(Map<String, dynamic> json) => AqiEntity(
        aqiInVal: json['aqiInVal'],
        components: Map<String, double>.from(json['components']),
        dateTime: DateTime.parse(json['dateTime']),
      );
}
