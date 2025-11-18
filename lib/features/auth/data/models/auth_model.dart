import 'package:community_feedback/features/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required super.id,
    required super.token,
    required super.name,
    required super.email,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>;

    return AuthModel(
      id: user['id'] as int,
      name: user['name'] as String,
      email: user['email'] as String ,
      token: json['token'] as String,
    );
  }
}
