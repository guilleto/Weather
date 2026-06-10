# OllyOlly Weather

A production-grade Flutter weather application supporting Flutter Web and Mobile Web.

---

## Project Overview

OllyOlly Weather allows users to authenticate and view real-time weather information for their current location. The application demonstrates clean architecture, state management, responsive design, security awareness, and product thinking.

---

## Setup Instructions

### Prerequisites

- Flutter SDK >= 3.9.0
- Dart SDK >= 3.9.0
- OpenWeatherMap API key (free tier works — sign up at https://openweathermap.org)

### 1. Clone and Install Dependencies

```bash
git clone <repo-url>
cd weather_olly
flutter pub get
```

### 2. Environment Configuration

Copy the example env file and fill in your values:

```bash
cp .env.example .env
```

Edit `.env`:

```
WEATHER_API_KEY=your_openweathermap_api_key_here
WEATHER_BASE_URL=https://api.openweathermap.org/data/2.5
SESSION_TIMEOUT_MINUTES=30
CACHE_TTL_MINUTES=30
```

**The `.env` file is git-ignored and must never be committed.**

### 3. Running the Application

```bash
# Mobile (Android/iOS)
flutter run

# Flutter Web
flutter run -d chrome

# Release web build
flutter build web
```

### Demo Credentials

```
Email:    demo@weather.com
Password: weather123
```

---

## Architecture Overview

The application follows **Clean Architecture** with a pragmatic approach suited to the application's size.

```
lib/
├── core/
│   ├── design_system/        # Tokens, themes
│   ├── responsive/           # Breakpoints, responsive layout
│   └── routing/              # GoRouter configuration
└── features/
    ├── auth/                 # Authentication feature
    │   ├── data/             # Session storage, mock auth
    │   ├── domain/           # Session entity, use cases
    │   └── presentation/     # LoginScreen, AuthProvider
    ├── weather/              # Weather feature
    │   ├── data/             # OpenWeatherMap API, local cache
    │   ├── domain/           # Weather/Forecast entities, use cases
    │   └── presentation/     # WeatherDashboard, WeatherProvider
    ├── settings/             # Settings feature
    │   ├── data/             # SharedPreferences persistence
    │   ├── domain/           # Use cases for theme/font preferences
    │   └── presentation/     # SettingsScreen, SettingsProvider
    └── splash/               # Splash screen (init + routing)
```

### Dependency Rule

```
Presentation -> Domain <- Data
```

Data and Presentation layers both depend on Domain. Domain is independent of everything.

### State Management

Provider is used for all state management:

- `AuthProvider` — authentication state, login/logout
- `WeatherProvider` — location, weather data, forecast
- `SettingsProvider` — theme mode, font family

---

## Supported Platforms

- Flutter Web (Chrome)
- Mobile Web
- Android
- iOS
