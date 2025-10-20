import 'package:community_feedback/features/notes/data/datasources/app_database.dart';
import 'package:community_feedback/features/notes/data/datasources/note_local_datasource.dart';
import 'package:community_feedback/features/notes/data/repositories/note_repository_impl.dart';
import 'package:community_feedback/features/notes/domain/repositories/note_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../domain/usecases/note_usecase.dart';
import 'note_state_notifier.dart';

final databaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

final noteLocalDataSourceProvider = Provider<NoteLocalDataSource>((ref) {
  final database = ref.watch(databaseProvider);
  return NoteLocalDataSourceImpl(database: database);
});

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  final localDataSource = ref.watch(noteLocalDataSourceProvider);
  return NoteRepositoryImpl(localDataSource: localDataSource);
});

final watchAllNotesUseCaseProvider = Provider<WatchAllNotes>((ref) {
  final repository = ref.watch(noteRepositoryProvider);
  return WatchAllNotes(repository);
});

final addNoteUseCaseProvider = Provider<AddNote>((ref) {
  final repository = ref.watch(noteRepositoryProvider);
  return AddNote(repository);
});

final deleteNoteUseCaseProvider = Provider<DeleteNote>((ref) {
  final repository = ref.watch(noteRepositoryProvider);
  return DeleteNote(repository);
});

final noteNotifierProvider =
    StateNotifierProvider.autoDispose<NoteNotifier, NoteState>((ref) {
      final watchAllNotes = ref.watch(watchAllNotesUseCaseProvider);
      final addNote = ref.watch(addNoteUseCaseProvider);
      final deleteNote = ref.watch(deleteNoteUseCaseProvider);

      return NoteNotifier(
        watchAllNotes: watchAllNotes,
        addNote: addNote,
        deleteNote: deleteNote,
      );
    });
