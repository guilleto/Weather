# Architecture & Engineering Decisions

---

## Security Decision: Session Expiration After Inactivity

### Decision

Sessions expire after **30 minutes of inactivity**, configurable via the `SESSION_TIMEOUT_MINUTES` environment variable.

### Implementation

- On login, a session token and `lastActivityAt` timestamp are written to SharedPreferences.
- On each app launch, `ValidateSession` reads the stored session and computes `now - lastActivityAt`.
- If the elapsed time exceeds the configured timeout, the session is cleared and the user is redirected to the login screen.
- On a valid session, `lastActivityAt` is refreshed to extend the session.

### Additional Security Practices


| Practice                            | Implementation                                                                |
| ----------------------------------- | ----------------------------------------------------------------------------- |
| No plaintext passwords              | Passwords are never stored; only a timestamp-based session token is persisted |
| API keys from environment           | `WEATHER_API_KEY` is loaded via `flutter_dotenv` at startup                   |
| `.env` excluded from source control | `.env` is listed in `.gitignore`; only `.env.example` is committed            |
| No hardcoded sensitive values       | All configurable values come from `.env`                                      |


---

## Deliberate Tradeoff: Weather Caching

### Decision

Weather data is cached locally in SharedPreferences for **30 minutes** (configurable via `CACHE_TTL_MINUTES`).

### Benefits

- **Faster perceived load time** — cached responses return immediately without a network round-trip
- **Reduced API usage** — stays within the free tier of OpenWeatherMap for typical usage
- **Better offline resilience** — recent data remains available if the network is temporarily unavailable

### Costs

- **Data freshness** — weather shown may be up to 30 minutes old
- **No real-time updates** — rapidly changing conditions may not be reflected immediately

### Mitigation

- The dashboard card shows a **"Last updated"** timestamp so users are always aware of data age
- Pull-to-refresh is available to force an immediate data refresh and bypass the cache

---

## API Selection: OpenWeatherMap

### Rationale

- Free tier provides current weather + 5-day/3-hour forecast — sufficient for MVP requirements
- Simple REST API with JSON responses; no SDK dependency required
- Widely documented with stable endpoints
- Icon URLs are served directly from OpenWeatherMap CDN, avoiding the need to bundle weather icons

---

## State Management: Provider

### Rationale

- Lightweight and idiomatic Flutter solution — no code generation, no complex setup
- Direct integration with `BuildContext` via `Consumer<T>` and `context.read<T>()`
- `ChangeNotifier` maps cleanly to loading/success/error state machines per feature
- Avoids the complexity overhead of Riverpod or BLoC for an application of this scope

---

## Routing: GoRouter

### Rationale

- Official Flutter navigation package with declarative route definitions
- `redirect` callback enables clean authentication-gating of protected routes
- `refreshListenable` ensures route guards re-evaluate automatically when auth state changes

