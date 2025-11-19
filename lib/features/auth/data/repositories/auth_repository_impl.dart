import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:community_feedback/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:community_feedback/features/auth/domain/entities/auth_entity.dart';
import 'package:community_feedback/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDatasource;

  AuthRepositoryImpl(this.remoteDataSource, this.authLocalDatasource);

  @override
  Future<Either<Failure, void>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      await remoteDataSource.register(
        name: name,
        email: email,
        password: password,
        passwordConfirm: passwordConfirmation,
      );

      return const Right(null);
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(
        ServerFailure(message: 'Terjadi kesalahan tidak terduga: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final authModel = await remoteDataSource.login(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );

      await authLocalDatasource.saveCurrentUserData(
        token: authModel.token,
        name: authModel.name,
        email: authModel.email,
      );
      return Right(authModel);
    } on Failure catch (f) {
      return Left(f);
    }
  }
}
