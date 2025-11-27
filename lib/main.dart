import 'dart:math';

import 'package:community_feedback/core/networking/auth_interceptor.dart';
import 'package:community_feedback/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:community_feedback/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:community_feedback/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:community_feedback/features/auth/domain/repositories/auth_repository.dart';
import 'package:community_feedback/features/auth/domain/usecases/login_usecase.dart';
import 'package:community_feedback/features/auth/domain/usecases/register_usecase.dart';
import 'package:community_feedback/features/notes/data/datasources/note_remote_datasource.dart';
import 'package:community_feedback/features/notes/data/repositories/note_repository_impl.dart';
import 'package:community_feedback/features/notes/domain/repositories/note_repository.dart';
import 'package:community_feedback/features/notes/domain/usecases/get_list_notes_usecase.dart';
import 'package:community_feedback/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:community_feedback/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:community_feedback/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:community_feedback/features/profile/domain/repositories/profile_repository.dart';
import 'package:community_feedback/features/profile/domain/usecases/change_email_usecase.dart';
import 'package:community_feedback/features/profile/domain/usecases/change_name_usecase.dart';
import 'package:community_feedback/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:community_feedback/features/profile/domain/usecases/logout_usecase.dart';
import 'package:community_feedback/splash_screen.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/navigator_key.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

final theme = ThemeData().copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: TColors.primaryColor,
    brightness: Brightness.light,
  ),
  textTheme: GoogleFonts.plusJakartaSansTextTheme(),
);

final random = Random();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthLocalDataSource>(
          create: (context) => AuthLocalDataSourceImpl(
            sharedPreferences,
            const FlutterSecureStorage(),
          ),
        ),

        RepositoryProvider<Dio>(
          create: (context) {
            final options = BaseOptions(
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              },

              connectTimeout: const Duration(seconds: 60),
              receiveTimeout: const Duration(seconds: 60),
            );

            final dio = Dio(options);

            dio.interceptors.add(
              LogInterceptor(requestBody: true, responseBody: true),
            );

            dio.interceptors.add(
              AuthInterceptor(context.read<AuthLocalDataSource>()),
            );

            return dio;
          },
        ),

        RepositoryProvider<AuthRemoteDataSource>(
          create: (context) => AuthRemoteDataSourceImpl(context.read<Dio>()),
        ),

        RepositoryProvider<ProfileRemoteDataSource>(
          create: (context) => ProfileRemoteDataSourceImpl(context.read<Dio>()),
        ),

        RepositoryProvider<NoteRemoteDataSource>(
          create: (context) => NoteRemoteDataSourceImpl(context.read<Dio>()),
        ),

        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            context.read<AuthRemoteDataSource>(),
            context.read<AuthLocalDataSource>(),
          ),
        ),

        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepositoryImpl(
            context.read<ProfileRemoteDataSource>(),
            context.read<AuthLocalDataSource>(),
          ),
        ),

        RepositoryProvider<NoteRepository>(
          create: (context) =>
              NoteRepositoryImpl(context.read<NoteRemoteDataSource>()),
        ),

        RepositoryProvider<LoginUsecase>(
          create: (context) => LoginUsecase(context.read<AuthRepository>()),
        ),

        RepositoryProvider<RegisterUsecase>(
          create: (context) => RegisterUsecase(context.read<AuthRepository>()),
        ),

        RepositoryProvider<ChangePasswordUsecase>(
          create: (context) =>
              ChangePasswordUsecase(context.read<ProfileRepository>()),
        ),

        RepositoryProvider<ChangeEmailUseCase>(
          create: (context) =>
              ChangeEmailUseCase(context.read<ProfileRepository>()),
        ),

        RepositoryProvider<ChangeNameUseCase>(
          create: (context) =>
              ChangeNameUseCase(context.read<ProfileRepository>()),
        ),

        RepositoryProvider<LogoutUsecase>(
          create: (context) => LogoutUsecase(context.read<ProfileRepository>()),
        ),

        RepositoryProvider<GetListNotesUsecase>(
          create: (context) =>
              GetListNotesUsecase(context.read<NoteRepository>()),
        ),

        // RepositoryProvider<AppDatabase>(create: (context) => AppDatabase()),
        // RepositoryProvider<NoteLocalDataSource>(
        //   create: (context) =>
        //       NoteLocalDataSourceImpl(database: context.read<AppDatabase>()),
        // ),
        // RepositoryProvider<NoteRepository>(
        //   create: (context) => NoteRepositoryImpl(
        //     localDataSource: context.read<NoteLocalDataSource>(),
        //   ),
        // ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NotesCubit>(
            create: (context) => NotesCubit(
              context.read<GetListNotesUsecase>(), // Inject UseCase
            )..fetchNotes(), // Langsung fetch saat aplikasi mulai
          ),
        ],
        child: MaterialApp(
          title: 'Community Feedback',
          theme: theme,
          navigatorKey: navigatorKey,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
