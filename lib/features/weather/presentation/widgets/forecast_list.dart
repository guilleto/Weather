import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/design_system/tokens/app_spacing.dart';
import '../../domain/entities/forecast.dart';
import 'weather_icon.dart';

class ForecastList extends StatelessWidget {
  const ForecastList({super.key, required this.forecast});

  final List<ForecastDay> forecast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('5-Day Forecast', style: theme.textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.m),
        ...forecast.map((day) => _ForecastTile(day: day)),
      ],
    );
  }
}

class _ForecastTile extends StatelessWidget {
  const _ForecastTile({required this.day});

  final ForecastDay day;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dayName = DateFormat('EEE, MMM d').format(day.date);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.s),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(dayName, style: theme.textTheme.bodyLarge),
            ),
            WeatherIcon(iconCode: day.conditionIcon, size: 36),
            const SizedBox(width: AppSpacing.s),
            Expanded(
              flex: 2,
              child: Text(
                day.condition,
                style: theme.textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '${day.tempMin.round()}° / ${day.tempMax.round()}°',
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
