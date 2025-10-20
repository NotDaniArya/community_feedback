import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/note_entity.dart';
import '../repositories/note_repository.dart';

class WatchAllNotes {
  final NoteRepository repository;

  WatchAllNotes(this.repository);

  Stream<Either<Failure, List<NoteEntity>>> call() {
    return repository.watchAllNotes();
  }
}

class AddNote {
  final NoteRepository repository;

  AddNote(this.repository);

  Future<Either<Failure, void>> call(NoteEntity note) {
    return repository.addNote(note);
  }
}

class DeleteNote {
  final NoteRepository repository;

  DeleteNote(this.repository);

  Future<Either<Failure, void>> call(int id) {
    return repository.deleteNote(id);
  }
}
