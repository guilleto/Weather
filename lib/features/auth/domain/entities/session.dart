class Session {
  final String token;
  final String email;
  final DateTime createdAt;
  final DateTime lastActivityAt;

  const Session({
    required this.token,
    required this.email,
    required this.createdAt,
    required this.lastActivityAt,
  });
}
