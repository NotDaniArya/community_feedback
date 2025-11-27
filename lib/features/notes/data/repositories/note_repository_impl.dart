import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/notes/data/datasources/note_remote_datasource.dart';
import 'package:community_feedback/features/notes/domain/entities/note_entity.dart';
import 'package:community_feedback/features/notes/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteRemoteDataSource remoteDataSource;

  NoteRepositoryImpl( this.remoteDataSource);

  @override
  Future<Either<Failure, List<NoteEntity>>> getListNotes() async {
    try {
      final noteModel = await remoteDataSource.getListNotes();

      return Right(noteModel);
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
