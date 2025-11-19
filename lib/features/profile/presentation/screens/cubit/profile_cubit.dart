import 'package:community_feedback/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:community_feedback/features/profile/presentation/screens/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthLocalDataSource authLocalDataSource;

  ProfileCubit(this.authLocalDataSource): super(ProfileInitial());

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
}