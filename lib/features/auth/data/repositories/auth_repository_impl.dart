import '../../domain/entities/session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/session_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource _local;

  const AuthRepositoryImpl(this._local);

  // Mock credentials — no backend required per blueprint spec
  static const _validEmail = 'demo@weather.com';
  static const _validPassword = 'weather123';

  @override
  Future<Session> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (email.trim().toLowerCase() != _validEmail || password != _validPassword) {
      throw Exception('Invalid credentials. Use demo@weather.com / weather123');
    }

    final now = DateTime.now();
    final session = SessionModel(
      token: 'tok_${now.millisecondsSinceEpoch}',
      email: email.trim().toLowerCase(),
      createdAt: now,
      lastActivityAt: now,
    );
    await _local.saveSession(session);
    return session;
  }

  @override
  Future<void> logout() => _local.clearSession();

  @override
  Future<Session?> getSession() => _local.getSession();

  @override
  Future<void> updateActivity() async {
    final session = await _local.getSession();
    if (session == null) return;
    await _local.saveSession(session.copyWith(lastActivityAt: DateTime.now()));
  }
}
