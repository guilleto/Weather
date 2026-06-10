class Weather {
  final String cityName;
  final String countryCode;
  final double temperature;
  final double feelsLike;
  final String condition;
  final String conditionIcon;
  final int humidity;
  final double windSpeed;
  final DateTime fetchedAt;

  const Weather({
    required this.cityName,
    required this.countryCode,
    required this.temperature,
    required this.feelsLike,
    required this.condition,
    required this.conditionIcon,
    required this.humidity,
    required this.windSpeed,
    required this.fetchedAt,
  });
}
