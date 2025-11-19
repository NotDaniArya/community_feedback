import 'dart:math';

import 'package:community_feedback/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:community_feedback/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:community_feedback/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:community_feedback/features/auth/domain/repositories/auth_repository.dart';
import 'package:community_feedback/features/auth/domain/usecases/login_usecase.dart';
import 'package:community_feedback/features/auth/domain/usecases/register_usecase.dart';
import 'package:community_feedback/features/notes/data/datasources/note_local_datasource.dart';
import 'package:community_feedback/features/notes/data/repositories/note_repository_impl.dart';
import 'package:community_feedback/features/notes/domain/repositories/note_repository.dart';
import 'package:community_feedback/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:community_feedback/splash_screen.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/notes/data/datasources/app_database.dart';

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

            return dio;
          },
        ),

        RepositoryProvider<AuthLocalDataSource>(
          create: (context) => AuthLocalDataSourceImpl(
            sharedPreferences,
            const FlutterSecureStorage(),
          ),
        ),

        RepositoryProvider<AuthRemoteDataSource>(
          create: (context) => AuthRemoteDataSourceImpl(context.read<Dio>()),
        ),

        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            context.read<AuthRemoteDataSource>(),
            context.read<AuthLocalDataSource>(),
          ),
        ),

        RepositoryProvider<LoginUsecase>(
          create: (context) => LoginUsecase(context.read<AuthRepository>()),
        ),

        RepositoryProvider<RegisterUsecase>(
          create: (context) => RegisterUsecase(context.read<AuthRepository>()),
        ),

        RepositoryProvider<AppDatabase>(create: (context) => AppDatabase()),
        RepositoryProvider<NoteLocalDataSource>(
          create: (context) =>
              NoteLocalDataSourceImpl(database: context.read<AppDatabase>()),
        ),
        RepositoryProvider<NoteRepository>(
          create: (context) => NoteRepositoryImpl(
            localDataSource: context.read<NoteLocalDataSource>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NotesCubit>(
            create: (context) => NotesCubit(context.read<NoteRepository>()),
          ),
        ],
        child: MaterialApp(
          title: 'Community Feedback',
          theme: theme,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
