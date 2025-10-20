import 'dart:ui';

import 'package:community_feedback/core/error/failures.dart';
import 'package:community_feedback/features/notes/data/datasources/app_database.dart';
import 'package:community_feedback/features/notes/data/datasources/note_local_datasource.dart';
import 'package:community_feedback/features/notes/domain/entities/note_entity.dart';
import 'package:community_feedback/features/notes/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource localDataSource;

  NoteRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> addNote(NoteEntity note) async {
    try {
      final noteCompanion = _mapEntityToCompanion(note);
      await localDataSource.addNote(noteCompanion);

      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure(message: 'Gagal menambahkan Note.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(int id) async {
    try {
      await localDataSource.deleteNote(id);

      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure(message: 'Gagal menghapus note'));
    }
  }

  @override
  Future<Either<Failure, void>> updateNotePosition(
    int id,
    Offset newPosition,
  ) async {
    try {
      await localDataSource.updateNotePosition(
        id,
        newPosition.dx,
        newPosition.dy,
      );

      return const Right(null);
    } catch (e) {
      return const Left(
        CacheFailure(message: 'Gagal memperbarui posisi catatan'),
      );
    }
  }

  @override
  Stream<Either<Failure, List<NoteEntity>>> watchAllNotes() {
    try {
      return localDataSource.watchAllNotes().map((notesFromDb) {
        final entities = notesFromDb
            .map((note) => _mapDataToEntity(note))
            .toList();

        return Right(entities);
      });
    } catch (e) {
      return Stream.value(
        const Left(CacheFailure(message: 'Gagal memantau perubahan note')),
      );
    }
  }

  NoteEntity _mapDataToEntity(Note data) {
    return NoteEntity(
      id: data.id,
      content: data.content,
      username: data.username,
      userProfileImage: data.userProfileImage,
      color: Color(int.parse('0x${data.color}')),
      position: Offset(data.positionX, data.positionY),
      createdAt: data.createdAt,
    );
  }

  NotesCompanion _mapEntityToCompanion(NoteEntity entity) {
    return NotesCompanion(
      content: Value(entity.content),
      username: Value(entity.username),
      userProfileImage: Value(entity.userProfileImage),
      color: Value(entity.color.value.toRadixString(16)),
      positionX: Value(entity.position.dx),
      positionY: Value(entity.position.dy),
      createdAt: Value(entity.createdAt),
    );
  }
}
