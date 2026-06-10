import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/design_system/tokens/app_spacing.dart';
import '../../domain/entities/weather.dart';
import 'weather_icon.dart';

class CurrentWeatherCard extends StatelessWidget {
  const CurrentWeatherCard({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final temp = weather.temperature.round();
    final feelsLike = weather.feelsLike.round();
    final updatedAt = DateFormat('MMM d, h:mm a').format(weather.fetchedAt);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(weather.cityName, style: theme.textTheme.headlineLarge),
                    Text(weather.countryCode, style: theme.textTheme.bodyMedium),
                  ],
                ),
                const Spacer(),
                WeatherIcon(iconCode: weather.conditionIcon, size: 72),
              ],
            ),
            const SizedBox(height: AppSpacing.m),
            Text('$temp°C', style: theme.textTheme.displayLarge),
            Text(
              weather.condition.toUpperCase(),
              style: theme.textTheme.bodyMedium?.copyWith(letterSpacing: 1.2),
            ),
            const SizedBox(height: AppSpacing.m),
            const Divider(),
            const SizedBox(height: AppSpacing.m),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Stat(icon: Icons.thermostat_outlined, label: 'Feels like', value: '$feelsLike°C'),
                _Stat(icon: Icons.water_drop_outlined, label: 'Humidity', value: '${weather.humidity}%'),
                _Stat(icon: Icons.air, label: 'Wind', value: '${weather.windSpeed.toStringAsFixed(1)} m/s'),
              ],
            ),
            const SizedBox(height: AppSpacing.m),
            Text(
              'Last updated: $updatedAt',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(height: AppSpacing.xs),
        Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
