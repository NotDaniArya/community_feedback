import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String token;

  const AuthEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, email, token];
}
