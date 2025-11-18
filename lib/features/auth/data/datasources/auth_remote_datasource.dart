import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/auth/data/models/auth_model.dart';
import 'package:community_feedback/utils/constant/secrets.dart';
import 'package:community_feedback/utils/constant/texts.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  // Future<void> register({
  //   required String name,
  //   required String email,
  //   required String password,
  //   required String passwordConfirm,
  // });

  Future<AuthModel> login({
    required String email,
    required String password,
    required bool rememberMe,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  const AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final response = await dio.post(
        '${TSecrets.baseUrl}/api/login',
        data: {'email': email, 'password': password, 'remember_me': rememberMe},
      );

      if (response.statusCode == 200) {
        return AuthModel.fromJson(response.data);
      } else {
        throw Failure.fromDioException(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
          ),
        );
      }
    } on DioException catch (e) {
      throw Failure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
}
