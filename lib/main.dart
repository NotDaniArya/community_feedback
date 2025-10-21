import 'dart:math';

import 'package:community_feedback/features/notes/data/datasources/note_local_datasource.dart';
import 'package:community_feedback/features/notes/data/repositories/note_repository_impl.dart';
import 'package:community_feedback/features/notes/domain/repositories/note_repository.dart';
import 'package:community_feedback/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:community_feedback/navigation_menu.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/notes/data/datasources/app_database.dart';

final theme = ThemeData().copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: TColors.primaryColor,
    brightness: Brightness.light,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(),
);

final random = Random();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
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
          home: const NavigationMenu(),
        ),
      ),
    );
  }
}
