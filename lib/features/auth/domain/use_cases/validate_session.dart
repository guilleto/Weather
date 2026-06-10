import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../repositories/auth_repository.dart';

class ValidateSession {
  final AuthRepository _repository;
  const ValidateSession(this._repository);

  Future<bool> call() async {
    final session = await _repository.getSession();
    if (session == null) return false;

    final timeoutMinutes = int.tryParse(dotenv.maybeGet('SESSION_TIMEOUT_MINUTES') ?? '30') ?? 30;
    final elapsed = DateTime.now().difference(session.lastActivityAt);
    if (elapsed > Duration(minutes: timeoutMinutes)) {
      await _repository.logout();
      return false;
    }

    await _repository.updateActivity();
    return true;
  }
}
