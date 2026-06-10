import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({super.key, required this.iconCode, this.size = 64});

  final String iconCode;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://openweathermap.org/img/wn/$iconCode@2x.png',
      width: size,
      height: size,
      errorBuilder: (_, __, ___) => Icon(Icons.wb_cloudy_outlined, size: size),
    );
  }
}
