import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/utils/constant/secrets.dart';
import 'package:community_feedback/utils/constant/texts.dart';
import 'package:dio/dio.dart';

abstract class ProfileRemoteDataSource {
  Future<void> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  });

  Future<void> changeEmail({required String newEmail});

  Future<void> changeName({required String newName});

  Future<void> logout();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;

  const ProfileRemoteDataSourceImpl(this.dio);

  @override
  Future<void> changeEmail({required String newEmail}) async {
    try {
      await dio.put(
        '${TSecrets.baseUrl}/api/profile',
        data: {"email": newEmail},
      );
    } on DioException catch (e) {
      throw Failure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<void> changeName({required String newName}) async {
    try {
      await dio.put('${TSecrets.baseUrl}/api/profile', data: {"name": newName});
    } on DioException catch (e) {
      throw Failure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      await dio.put(
        '${TSecrets.baseUrl}/api/password',
        data: {
          "current_password": currentPassword,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );
    } on DioException catch (e) {
      throw Failure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post('${TSecrets.baseUrl}/api/logout');
    } on DioException catch (e) {
      throw Failure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
}
