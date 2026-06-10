import 'package:flutter/foundation.dart';
import '../../domain/entities/session.dart';
import '../../domain/use_cases/login_user.dart';
import '../../domain/use_cases/logout_user.dart';
import '../../domain/use_cases/validate_session.dart';

enum AuthState { idle, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final LoginUser _loginUser;
  final LogoutUser _logoutUser;
  final ValidateSession _validateSession;

  AuthProvider(this._loginUser, this._logoutUser, this._validateSession);

  AuthState _state = AuthState.idle;
  Session? _session;
  String? _errorMessage;

  AuthState get state => _state;
  Session? get session => _session;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _state == AuthState.authenticated;

  Future<bool> checkSession() async {
    _state = AuthState.loading;
    notifyListeners();

    final valid = await _validateSession();
    _state = valid ? AuthState.authenticated : AuthState.unauthenticated;
    notifyListeners();
    return valid;
  }

  Future<bool> login(String email, String password) async {
    _state = AuthState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _session = await _loginUser(email, password);
      _state = AuthState.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _state = AuthState.error;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _logoutUser();
    _session = null;
    _state = AuthState.unauthenticated;
    notifyListeners();
  }
}
