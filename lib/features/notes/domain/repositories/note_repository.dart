import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/notes/domain/entities/note_entity.dart';
import 'package:dartz/dartz.dart';

abstract class NoteRepository {
  Stream<Either<Failure, List<NoteEntity>>> watchAllNotes();

  Future<Either<Failure, void>> addNote(NoteEntity note);

  Future<Either<Failure, void>> deleteNote(int id);
}
