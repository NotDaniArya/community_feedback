import 'package:community_feedback/features/auth/domain/entities/auth_entity.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final AuthEntity userSession;
  const LoginSuccess(this.userSession);

  @override
  // TODO: implement props
  List<Object?> get props => [userSession];
}

class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
