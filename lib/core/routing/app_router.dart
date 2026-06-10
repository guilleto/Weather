import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/weather/presentation/screens/weather_dashboard_screen.dart';

class AppRouter {
  static GoRouter build(AuthProvider authProvider) {
    return GoRouter(
      initialLocation: '/splash',
      redirect: (context, state) {
        final path = state.uri.path;

        // Splash handles its own routing — let it run freely
        if (path == '/splash') return null;

        final isAuthenticated = authProvider.isAuthenticated;

        if (!isAuthenticated && path != '/login') return '/login';
        if (isAuthenticated && path == '/login') return '/weather';

        return null;
      },
      refreshListenable: authProvider,
      routes: [
        GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
        GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
        GoRoute(path: '/weather', builder: (_, __) => const WeatherDashboardScreen()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      ],
    );
  }
}
