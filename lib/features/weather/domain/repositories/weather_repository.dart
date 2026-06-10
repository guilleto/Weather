import '../entities/forecast.dart';
import '../entities/location.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getCurrentWeather(AppLocation location);
  Future<List<ForecastDay>> getForecast(AppLocation location);
}
