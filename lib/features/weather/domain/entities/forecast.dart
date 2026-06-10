class ForecastDay {
  final DateTime date;
  final double tempMin;
  final double tempMax;
  final String condition;
  final String conditionIcon;

  const ForecastDay({
    required this.date,
    required this.tempMin,
    required this.tempMax,
    required this.condition,
    required this.conditionIcon,
  });
}
