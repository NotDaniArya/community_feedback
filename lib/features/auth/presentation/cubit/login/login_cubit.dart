import 'package:community_feedback/features/auth/domain/usecases/login_usecase.dart';
import 'package:community_feedback/features/auth/presentation/cubit/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase _loginUsecase;

  LoginCubit(this._loginUsecase) : super(LoginInitial());

  Future<void> doLogin({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(LoginLoading());

    final result = await _loginUsecase(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );

    result.fold(
      (failure) {
        emit(LoginError(failure.message));
      },
      (userSession) {
        emit(LoginSuccess(userSession));
      },
    );
  }
}
