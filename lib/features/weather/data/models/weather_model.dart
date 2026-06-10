import 'dart:convert';
import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required super.cityName,
    required super.countryCode,
    required super.temperature,
    required super.feelsLike,
    required super.condition,
    required super.conditionIcon,
    required super.humidity,
    required super.windSpeed,
    required super.fetchedAt,
  });

  factory WeatherModel.fromApiJson(Map<String, dynamic> json) {
    final main = json['main'] as Map<String, dynamic>;
    final weather = (json['weather'] as List).first as Map<String, dynamic>;
    final wind = json['wind'] as Map<String, dynamic>;
    final sys = json['sys'] as Map<String, dynamic>;

    return WeatherModel(
      cityName: json['name'] as String,
      countryCode: sys['country'] as String,
      temperature: (main['temp'] as num).toDouble(),
      feelsLike: (main['feels_like'] as num).toDouble(),
      condition: weather['description'] as String,
      conditionIcon: weather['icon'] as String,
      humidity: (main['humidity'] as num).toInt(),
      windSpeed: (wind['speed'] as num).toDouble(),
      fetchedAt: DateTime.now(),
    );
  }

  factory WeatherModel.fromCacheJson(Map<String, dynamic> json) => WeatherModel(
        cityName: json['cityName'] as String,
        countryCode: json['countryCode'] as String,
        temperature: (json['temperature'] as num).toDouble(),
        feelsLike: (json['feelsLike'] as num).toDouble(),
        condition: json['condition'] as String,
        conditionIcon: json['conditionIcon'] as String,
        humidity: (json['humidity'] as num).toInt(),
        windSpeed: (json['windSpeed'] as num).toDouble(),
        fetchedAt: DateTime.parse(json['fetchedAt'] as String),
      );

  Map<String, dynamic> toCacheJson() => {
        'cityName': cityName,
        'countryCode': countryCode,
        'temperature': temperature,
        'feelsLike': feelsLike,
        'condition': condition,
        'conditionIcon': conditionIcon,
        'humidity': humidity,
        'windSpeed': windSpeed,
        'fetchedAt': fetchedAt.toIso8601String(),
      };

  String toCacheString() => jsonEncode(toCacheJson());

  factory WeatherModel.fromCacheString(String raw) =>
      WeatherModel.fromCacheJson(jsonDecode(raw) as Map<String, dynamic>);
}
