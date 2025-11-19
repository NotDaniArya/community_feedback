import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<Either<Failure, void>> call({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await repository.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}
