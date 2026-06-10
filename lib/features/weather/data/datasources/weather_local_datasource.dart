import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/forecast_model.dart';
import '../models/weather_model.dart';

class WeatherLocalDatasource {
  String _weatherKey(double lat, double lon) =>
      'weather_${lat.toStringAsFixed(2)}_${lon.toStringAsFixed(2)}';

  String _forecastKey(double lat, double lon) =>
      'forecast_${lat.toStringAsFixed(2)}_${lon.toStringAsFixed(2)}';

  String _tsKey(String dataKey) => '${dataKey}_ts';

  Duration get _cacheTtl {
    final minutes = int.tryParse(dotenv.maybeGet('CACHE_TTL_MINUTES') ?? '30') ?? 30;
    return Duration(minutes: minutes);
  }

  Future<WeatherModel?> getCachedWeather(double lat, double lon) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _weatherKey(lat, lon);
    final ts = prefs.getString(_tsKey(key));
    if (ts == null) return null;

    final age = DateTime.now().difference(DateTime.parse(ts));
    if (age > _cacheTtl) return null;

    final raw = prefs.getString(key);
    if (raw == null) return null;
    return WeatherModel.fromCacheString(raw);
  }

  Future<void> cacheWeather(double lat, double lon, WeatherModel weather) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _weatherKey(lat, lon);
    await prefs.setString(key, weather.toCacheString());
    await prefs.setString(_tsKey(key), DateTime.now().toIso8601String());
  }

  Future<List<ForecastDayModel>?> getCachedForecast(double lat, double lon) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _forecastKey(lat, lon);
    final ts = prefs.getString(_tsKey(key));
    if (ts == null) return null;

    final age = DateTime.now().difference(DateTime.parse(ts));
    if (age > _cacheTtl) return null;

    final raw = prefs.getString(key);
    if (raw == null) return null;
    return ForecastDayModel.listFromCacheString(raw);
  }

  Future<void> cacheForecast(double lat, double lon, List<ForecastDayModel> forecast) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _forecastKey(lat, lon);
    await prefs.setString(key, ForecastDayModel.listToCacheString(forecast));
    await prefs.setString(_tsKey(key), DateTime.now().toIso8601String());
  }
}
