import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/notes/domain/entities/note_entity.dart';
import 'package:community_feedback/features/notes/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';

class GetListNotesUsecase {
  final NoteRepository repository;

  GetListNotesUsecase(this.repository);

  Future<Either<Failure, List<NoteEntity>>> call () async {
    return await repository.getListNotes();
  }
}