class AqiEntity {
  int aqiInVal;
  Map<String, double> components;
  DateTime dateTime;
  
  AqiEntity({
    required this.aqiInVal,
    required this.components,
    required this.dateTime,
  });
}
