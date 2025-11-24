import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ChangeNameUseCase {
  final ProfileRepository repository;

  ChangeNameUseCase(this.repository);

  Future<Either<Failure, void>> call({required String newName}) async {
    return await repository.changeName(newName: newName);
  }
}
