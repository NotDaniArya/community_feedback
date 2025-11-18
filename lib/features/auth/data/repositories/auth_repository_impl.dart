import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:community_feedback/features/auth/domain/entities/auth_entity.dart';
import 'package:community_feedback/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  // final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  // @override
  // Future<(void, Failure?)> register({
  //   required String name,
  //   required String email,
  //   required String password,
  //   required String passwordConfirm,
  // }) async {
  //   try {
  //     await remoteDataSource.register(
  //       name: name,
  //       email: email,
  //       password: password,
  //       passwordConfirm: passwordConfirm,
  //     );
  //     return (null, null);
  //   } catch (e) {
  //     return (null, Failure('Register gagal: ${e.toString()}'));
  //   }
  // }

  @override
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final authModel = await remoteDataSource.login(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );

      return Right(authModel);
    } on Failure catch (f) {
      return Left(f);
    }
  }
}
