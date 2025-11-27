import 'dart:ui';

import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/notes/domain/entities/note_entity.dart';
import 'package:dartz/dartz.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<NoteEntity>>> getListNotes();

  // Future<Either<Failure, void>> addNote(NoteEntity note);

  // Future<Either<Failure, void>> deleteNote(int id);

  // Future<Either<Failure, void>> updateNotePosition(int id, Offset newPosition);
}
