import '../entities/session.dart';

abstract class AuthRepository {
  Future<Session> login(String email, String password);
  Future<void> logout();
  Future<Session?> getSession();
  Future<void> updateActivity();
}
