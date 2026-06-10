import '../entities/session.dart';
import '../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository _repository;
  const LoginUser(this._repository);

  Future<Session> call(String email, String password) {
    return _repository.login(email, password);
  }
}
