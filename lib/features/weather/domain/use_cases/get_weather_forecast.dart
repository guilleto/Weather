import '../entities/forecast.dart';
import '../entities/location.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeatherForecast {
  final WeatherRepository _repository;
  const GetWeatherForecast(this._repository);

  Future<(Weather, List<ForecastDay>)> call(AppLocation location) async {
    final weather = await _repository.getCurrentWeather(location);
    final forecast = await _repository.getForecast(location);
    return (weather, forecast);
  }
}
