import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/auth/domain/repositories/auth_repository.dart';
import 'package:community_feedback/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUsecase {
  final ProfileRepository profileRepository;

  const LogoutUsecase(this.profileRepository);

  Future<Either<Failure, void>> call() async {
    return await profileRepository.logout();
  }
}