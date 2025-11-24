import 'package:community_feedback/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  });

  Future<Either<Failure, void>> changeEmail({
    required String newEmail
  });

  Future<Either<Failure, void>> changeName({
    required String newName
  });
}
