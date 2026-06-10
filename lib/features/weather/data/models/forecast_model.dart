import 'dart:convert';
import '../../domain/entities/forecast.dart';

class ForecastDayModel extends ForecastDay {
  const ForecastDayModel({
    required super.date,
    required super.tempMin,
    required super.tempMax,
    required super.condition,
    required super.conditionIcon,
  });

  factory ForecastDayModel.fromCacheJson(Map<String, dynamic> json) => ForecastDayModel(
        date: DateTime.parse(json['date'] as String),
        tempMin: (json['tempMin'] as num).toDouble(),
        tempMax: (json['tempMax'] as num).toDouble(),
        condition: json['condition'] as String,
        conditionIcon: json['conditionIcon'] as String,
      );

  Map<String, dynamic> toCacheJson() => {
        'date': date.toIso8601String(),
        'tempMin': tempMin,
        'tempMax': tempMax,
        'condition': condition,
        'conditionIcon': conditionIcon,
      };

  static List<ForecastDayModel> fromApiJson(Map<String, dynamic> json) {
    final list = (json['list'] as List).cast<Map<String, dynamic>>();

    // Group by day, keep min/max temperature and noon reading for condition
    final Map<String, List<Map<String, dynamic>>> byDay = {};
    for (final item in list) {
      final dt = DateTime.fromMillisecondsSinceEpoch((item['dt'] as int) * 1000);
      final dayKey = '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
      byDay.putIfAbsent(dayKey, () => []).add(item);
    }

    // Skip today, take next 5 days
    final today = DateTime.now();
    final todayKey = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    return byDay.entries
        .where((e) => e.key != todayKey)
        .take(5)
        .map((e) {
          final items = e.value;
          final temps = items.map((i) => (i['main'] as Map)['temp'] as num).toList();
          final representative = items.reduce((a, b) {
            final aHour = DateTime.fromMillisecondsSinceEpoch((a['dt'] as int) * 1000).hour;
            final bHour = DateTime.fromMillisecondsSinceEpoch((b['dt'] as int) * 1000).hour;
            return (aHour - 12).abs() < (bHour - 12).abs() ? a : b;
          });
          final weather = (representative['weather'] as List).first as Map<String, dynamic>;

          return ForecastDayModel(
            date: DateTime.parse(e.key),
            tempMin: temps.reduce((a, b) => a < b ? a : b).toDouble(),
            tempMax: temps.reduce((a, b) => a > b ? a : b).toDouble(),
            condition: weather['description'] as String,
            conditionIcon: weather['icon'] as String,
          );
        })
        .toList();
  }

  static String listToCacheString(List<ForecastDayModel> list) =>
      jsonEncode(list.map((e) => e.toCacheJson()).toList());

  static List<ForecastDayModel> listFromCacheString(String raw) =>
      (jsonDecode(raw) as List)
          .cast<Map<String, dynamic>>()
          .map(ForecastDayModel.fromCacheJson)
          .toList();
}
