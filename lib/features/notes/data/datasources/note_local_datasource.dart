import 'package:community_feedback/features/notes/data/datasources/app_database.dart';
import 'package:drift/drift.dart';

abstract class NoteLocalDataSource {
  Stream<List<Note>> watchAllNotes();

  Future<void> addNote(NotesCompanion note);

  Future<void> deleteNote(int id);

  Future<void> updateNotePosition(int id, double dx, double dy);
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
  Future<void> updateNotePosition(int id, double dx, double dy) {
    return (database.update(database.notes)..where((tbl) => tbl.id.equals(id)))
        .write(NotesCompanion(positionX: Value(dx), positionY: Value(dy)));
  }

  @override
  Stream<List<Note>> watchAllNotes() {
    return database.select(database.notes).watch();
  }
}
