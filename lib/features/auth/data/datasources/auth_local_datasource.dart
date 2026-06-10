import 'package:shared_preferences/shared_preferences.dart';
import '../models/session_model.dart';

class AuthLocalDatasource {
  static const _sessionKey = 'session_data';

  Future<void> saveSession(SessionModel session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, session.toJsonString());
  }

  Future<SessionModel?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_sessionKey);
    if (raw == null) return null;
    return SessionModel.fromJsonString(raw);
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }
}
