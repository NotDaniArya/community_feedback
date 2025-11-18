import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/auth/domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  // Future<(void, Failure?)> register({
  //   required String name,
  //   required String email,
  //   required String password,
  //   required String passwordConfirmation,
  // });

  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
    required bool rememberMe,
  });

  // Future<(Auth?, Failure?)> getCurrentUser();
}
