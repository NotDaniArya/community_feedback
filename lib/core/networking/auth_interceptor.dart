import 'package:community_feedback/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:community_feedback/features/auth/presentation/screens/login/login_screen.dart';
import 'package:community_feedback/features/profile/presentation/screens/cubit/profile_cubit.dart';
import 'package:community_feedback/utils/constant/navigator_key.dart';
import 'package:community_feedback/utils/helper_functions/helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

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

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      print('Token kedaluwarsa. Logout paksa...');

      await authLocalDataSource.deleteCurrentUserData();

      final context = navigatorKey.currentContext;
      if (context != null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );

        MyHelperFunction.showToast(
          context,
          'Session expired',
          'Your session expired, please login again!',
          ToastificationType.info,
        );
      }
    }

    super.onError(err, handler);
  }
}
