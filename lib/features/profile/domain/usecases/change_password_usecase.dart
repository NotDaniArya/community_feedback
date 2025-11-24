import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ChangePasswordUsecase {
  final ProfileRepository repository;

  ChangePasswordUsecase(this.repository);

  Future<Either<Failure, void>> call({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await repository.changePassword(
      currentPassword: currentPassword,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}
