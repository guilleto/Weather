import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/forecast_model.dart';
import '../models/weather_model.dart';

class WeatherRemoteDatasource {
  String get _baseUrl => dotenv.get('WEATHER_BASE_URL');
  String get _apiKey => dotenv.get('WEATHER_API_KEY');

  Future<WeatherModel> getCurrentWeather(double lat, double lon) async {
    final uri = Uri.parse('$_baseUrl/weather').replace(queryParameters: {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': _apiKey,
      'units': 'metric',
    });

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Weather API error ${response.statusCode}: ${response.body}');
    }
    return WeatherModel.fromApiJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<List<ForecastDayModel>> getForecast(double lat, double lon) async {
    final uri = Uri.parse('$_baseUrl/forecast').replace(queryParameters: {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': _apiKey,
      'units': 'metric',
    });

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Forecast API error ${response.statusCode}: ${response.body}');
    }
    return ForecastDayModel.fromApiJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
