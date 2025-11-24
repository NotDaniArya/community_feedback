import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ChangeEmailUseCase {
  final ProfileRepository repository;

  ChangeEmailUseCase(this.repository);

  Future<Either<Failure, void>> call({required String newEmail}) async {
    return await repository.changeEmail(newEmail: newEmail);
  }
}
