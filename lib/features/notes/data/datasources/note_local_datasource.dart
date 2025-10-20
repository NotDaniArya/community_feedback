import 'package:community_feedback/features/notes/data/datasources/app_database.dart';

abstract class NoteLocalDataSource {
  Stream<List<Note>> watchAllNotes();

  Future<void> addNote(NotesCompanion note);

  Future<void> deleteNote(int id);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final AppDatabase database;

  NoteLocalDataSourceImpl({required this.database});

  @override
  Future<void> addNote(NotesCompanion note) {
    return database.into(database.notes).insert(note);
  }

  @override
  Future<void> deleteNote(int id) {
    return (database.delete(
      database.notes,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Stream<List<Note>> watchAllNotes() {
    return database.select(database.notes).watch();
  }
}
