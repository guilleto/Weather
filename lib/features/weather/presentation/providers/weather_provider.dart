import 'package:flutter/foundation.dart';
import '../../domain/entities/forecast.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/weather.dart';
import '../../domain/use_cases/get_current_location.dart';
import '../../domain/use_cases/get_weather_forecast.dart';

enum WeatherState { idle, loading, success, error }

class WeatherProvider extends ChangeNotifier {
  final GetCurrentLocation _getLocation;
  final GetWeatherForecast _getForecast;

  WeatherProvider(this._getLocation, this._getForecast);

  WeatherState _state = WeatherState.idle;
  Weather? _weather;
  List<ForecastDay> _forecast = [];
  String? _errorMessage;
  AppLocation? _lastLocation;

  WeatherState get state => _state;
  Weather? get weather => _weather;
  List<ForecastDay> get forecast => _forecast;
  String? get errorMessage => _errorMessage;

  Future<void> load({bool forceRefresh = false}) async {
    _state = WeatherState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _lastLocation = await _getLocation();
      final (weather, forecast) = await _getForecast(_lastLocation!);
      _weather = weather;
      _forecast = forecast;
      _state = WeatherState.success;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _state = WeatherState.error;
    }
    notifyListeners();
  }

  Future<void> refresh() => load(forceRefresh: true);
}
