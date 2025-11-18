import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/auth/domain/entities/auth_entity.dart';
import 'package:community_feedback/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<Either<Failure, AuthEntity>> call({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    return await repository.login(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }
}
