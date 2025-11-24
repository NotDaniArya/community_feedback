import 'package:community_feedback/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:community_feedback/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource authLocalDataSource;

  const AuthInterceptor(this.authLocalDataSource);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    const nonTokenPath = ['/api/login', '/api/register'];

    final isNonTokenPath = nonTokenPath.any(
      (path) => options.path.contains(path),
    );

    if (isNonTokenPath) {
      return handler.next(options);
    }

    try {
      final token = await authLocalDataSource.getUserToken();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      print('Error mengambil token dari interceptor: $e');
    }

    super.onRequest(options, handler);
  }
}
