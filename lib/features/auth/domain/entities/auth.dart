import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String token;
  final String id;

  const Auth({required this.token, required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [token, id];
}
