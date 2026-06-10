import 'dart:convert';
import '../../domain/entities/session.dart';

class SessionModel extends Session {
  const SessionModel({
    required super.token,
    required super.email,
    required super.createdAt,
    required super.lastActivityAt,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
        token: json['token'] as String,
        email: json['email'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        lastActivityAt: DateTime.parse(json['lastActivityAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'email': email,
        'createdAt': createdAt.toIso8601String(),
        'lastActivityAt': lastActivityAt.toIso8601String(),
      };

  String toJsonString() => jsonEncode(toJson());

  factory SessionModel.fromJsonString(String raw) =>
      SessionModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);

  SessionModel copyWith({DateTime? lastActivityAt}) => SessionModel(
        token: token,
        email: email,
        createdAt: createdAt,
        lastActivityAt: lastActivityAt ?? this.lastActivityAt,
      );
}
