import 'package:community_feedback/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:community_feedback/features/profile/domain/usecases/change_email_usecase.dart';
import 'package:community_feedback/features/profile/domain/usecases/change_name_usecase.dart';
import 'package:community_feedback/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:community_feedback/features/profile/presentation/screens/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthLocalDataSource authLocalDataSource;
  final ChangePasswordUsecase _changePasswordUsecase;
  final ChangeEmailUseCase _changeEmailUseCase;
  final ChangeNameUseCase _changeNameUseCase;

  ProfileCubit({
    required this.authLocalDataSource,
    required ChangePasswordUsecase changePasswordUseCase,
    required ChangeEmailUseCase changeEmailUseCase,
    required ChangeNameUseCase changeNameUseCase,
  }) : _changePasswordUsecase = changePasswordUseCase,
       _changeEmailUseCase = changeEmailUseCase,
       _changeNameUseCase = changeNameUseCase,
       super(ProfileInitial());

  Future<void> loadUserProfile() async {
    emit(ProfileLoading());

    try {
      final name = await authLocalDataSource.getUserName();
      final email = await authLocalDataSource.getUserEmail();

      if (name != null && email != null) {
        emit(ProfileLoaded(name: name, email: email));
      } else {
        emit(const ProfileError('Data user tidak ditemukan di local storage'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> changeUserPassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(ProfileLoading());

    try {
      final result = await _changePasswordUsecase(
        currentPassword: currentPassword,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );

      result.fold(
        (failure) {
          emit(ProfileError(failure.message));
        },
        (success) {
          loadUserProfile();
          emit(ProfileSuccess());
        },
      );
    } catch (e) {
      emit(ProfileError("Terjadi kesalahan tak terduga: $e"));
    }
  }

  Future<void> changeUserEmail({required String newUserEmail}) async {
    emit(ProfileLoading());

    final result = await _changeEmailUseCase(newEmail: newUserEmail);

    result.fold(
      (failure) {
        emit(ProfileError(failure.message));
      },
      (success) {
        loadUserProfile();
        emit(ProfileSuccess());
      },
    );
  }

  Future<void> changeUserName({required String newUserName}) async {
    emit(ProfileLoading());

    final result = await _changeNameUseCase(newName: newUserName);

    result.fold(
      (failure) {
        emit(ProfileError(failure.message));
      },
      (success) {
        loadUserProfile();
        emit(ProfileSuccess());
      },
    );
  }
}
