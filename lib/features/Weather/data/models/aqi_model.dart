import 'dart:convert';

class AqiModel {
  int airQuality;
  Map<String, double> components;
  DateTime unixDateTime;

  AqiModel({
    required this.airQuality,
    required this.components,
    required this.unixDateTime,
  });

  AqiModel copyWith({
    int? airQuality,
    Map<String, double>? components,
    DateTime? unixDateTime,
  }) {
    return AqiModel(
      airQuality: airQuality ?? this.airQuality,
      components: components ?? this.components,
      unixDateTime: unixDateTime ?? this.unixDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'airQuality': airQuality,
      'components': components,
      'unixDateTime': unixDateTime.millisecondsSinceEpoch,
    };
  }

  factory AqiModel.fromMap(Map<String, dynamic> map) {
    return AqiModel(
      airQuality: map['main']['aqi'] as int,
      components: Map<String, double>.from(
        (map['components'] as Map<String, double>),
      ),
      unixDateTime: DateTime.fromMillisecondsSinceEpoch(map['dt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AqiModel.fromJson(String source) =>
      AqiModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
