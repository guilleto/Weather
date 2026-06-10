import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'core/design_system/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'features/auth/data/datasources/auth_local_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/use_cases/login_user.dart';
import 'features/auth/domain/use_cases/logout_user.dart';
import 'features/auth/domain/use_cases/validate_session.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/settings/data/datasources/settings_local_datasource.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'features/settings/domain/use_cases/save_font_preference.dart';
import 'features/settings/domain/use_cases/save_theme_preference.dart';
import 'features/settings/presentation/providers/settings_provider.dart';
import 'features/weather/data/datasources/weather_local_datasource.dart';
import 'features/weather/data/datasources/weather_remote_datasource.dart';
import 'features/weather/data/repositories/weather_repository_impl.dart';
import 'features/weather/domain/use_cases/get_current_location.dart';
import 'features/weather/domain/use_cases/get_weather_forecast.dart';
import 'features/weather/presentation/providers/weather_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Build dependency graph
    final authDatasource = AuthLocalDatasource();
    final authRepo = AuthRepositoryImpl(authDatasource);
    final authProvider = AuthProvider(
      LoginUser(authRepo),
      LogoutUser(authRepo),
      ValidateSession(authRepo),
    );

    final settingsDatasource = SettingsLocalDatasource();
    final settingsRepo = SettingsRepositoryImpl(settingsDatasource);
    final settingsProvider = SettingsProvider(
      settingsRepo,
      SaveThemePreference(settingsRepo),
      SaveFontPreference(settingsRepo),
    );

    final weatherRepo = WeatherRepositoryImpl(
      WeatherRemoteDatasource(),
      WeatherLocalDatasource(),
    );
    final weatherProvider = WeatherProvider(
      GetCurrentLocation(),
      GetWeatherForecast(weatherRepo),
    );

    final router = AppRouter.build(authProvider);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settingsProvider),
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider.value(value: weatherProvider),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) => MaterialApp.router(
          title: 'OllyOlly Weather',
          theme: AppTheme.light(settings.fontFamily),
          darkTheme: AppTheme.dark(settings.fontFamily),
          themeMode: settings.themeMode,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
