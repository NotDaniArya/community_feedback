import 'package:community_feedback/features/auth/domain/usecases/register_usecase.dart';
import 'package:community_feedback/features/auth/presentation/cubit/register/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUsecase _registerUsecase;

  RegisterCubit(this._registerUsecase) : super(RegisterInitial());

  Future<void> doRegister({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(RegisterLoading());

    final result = await _registerUsecase(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );

    result.fold(
      (failure) {
        emit(RegisterError(failure.message));
      },
      (success) {
        emit(RegisterSuccess());
      },
    );
  }
}
