// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}
