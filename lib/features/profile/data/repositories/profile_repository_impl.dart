import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:community_feedback/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:community_feedback/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

   ProfileRepositoryImpl(this.remoteDataSource, this.authLocalDataSource);

  @override
  Future<Either<Failure, void>> changeEmail({required String newEmail}) async {
    try {
      await remoteDataSource.changeEmail(newEmail: newEmail);

      await authLocalDataSource.updateUserEmail(email: newEmail);

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
  Future<Either<Failure, void>> changeName({required String newName}) async {
    try {
      await remoteDataSource.changeName(newName: newName);

      await authLocalDataSource.updateUserName(name: newName);

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
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      await remoteDataSource.changePassword(
        currentPassword: currentPassword,
        password: password,
        passwordConfirmation: passwordConfirmation,
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
}
