import '../../domain/entities/forecast.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_local_datasource.dart';
import '../datasources/weather_remote_datasource.dart';
import '../models/forecast_model.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDatasource _remote;
  final WeatherLocalDatasource _local;

  const WeatherRepositoryImpl(this._remote, this._local);

  @override
  Future<Weather> getCurrentWeather(AppLocation location) async {
    final cached = await _local.getCachedWeather(location.latitude, location.longitude);
    if (cached != null) return cached;

    final fresh = await _remote.getCurrentWeather(location.latitude, location.longitude);
    await _local.cacheWeather(location.latitude, location.longitude, fresh);
    return fresh;
  }

  @override
  Future<List<ForecastDay>> getForecast(AppLocation location) async {
    final cached = await _local.getCachedForecast(location.latitude, location.longitude);
    if (cached != null) return cached;

    final fresh = await _remote.getForecast(location.latitude, location.longitude);
    final models = fresh.cast<ForecastDayModel>();
    await _local.cacheForecast(location.latitude, location.longitude, models);
    return fresh;
  }
}
