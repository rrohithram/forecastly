class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final String icon;

  Weather({
    required this.cityName, 
    required this.temperature, 
    required this.condition,
    required this.icon
  });

  factory Weather.fromJSON(Map<String, dynamic> json){
    return Weather(
    cityName: json['name'], 
    temperature: json['main']['temp'].toDouble(), 
    condition: json['weather'][0]['main'],
    icon: json['weather'][0]['icon']
    );
  }

  get mainCondition => null;

  static Future<Weather> fromJson(jsonDecode) {
    return Future.value(Weather.fromJSON(jsonDecode));
  }
}
