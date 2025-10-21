import 'dart:async';
import 'dart:math';

import 'package:community_feedback/features/notes/domain/entities/note_entity.dart';
import 'package:community_feedback/features/notes/domain/repositories/note_repository.dart';
import 'package:community_feedback/features/notes/presentation/cubit/notes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';

class NotesCubit extends Cubit<NotesState> {
  final NoteRepository _repository;
  StreamSubscription? _notesSubscription;

  NotesCubit(this._repository) : super(NotesLoading()) {
    _notesSubscription = _repository.watchAllNotes().listen((either) {
      either.fold((failure) {
        if (failure is CacheFailure) {
          emit(NotesError(failure.message));
        } else {
          emit(const NotesError('Terjadi kesalahan yang tidak diketahui.'));
        }
      }, (notes) => emit(NotesLoaded(notes)));
    });
  }

  void bringToFront(int noteId) {
    if (state is NotesLoaded) {
      final currentNotes = (state as NotesLoaded).notes;

      final noteToMove = currentNotes.firstWhere((note) => note.id == noteId);

      final reorderedNotes = List<NoteEntity>.from(currentNotes)
        ..remove(noteToMove)
        ..add(noteToMove);

      emit(NotesLoaded(reorderedNotes));
    }
  }

  Future<void> addNote({
    Offset? initialPosition,
    required String noteContent,
    required Color color,
  }) async {
    final random = Random();
    final newNote = NoteEntity(
      id: 0,
      content: noteContent,
      username: 'User Testing',
      userProfileImage: 'https://i.pravatar.cc/150',
      color: color,
      position:
          initialPosition ??
          Offset(random.nextDouble() * 200, random.nextDouble() * 400),
      createdAt: DateTime.now(),
    );
    await _repository.addNote(newNote);
  }

  Future<void> updateNotePosition(int id, Offset newPosition) async {
    await _repository.updateNotePosition(id, newPosition);
    print(newPosition.dx);
    print(newPosition.dy);
  }

  Future<void> deleteNote(int id) async {
    await _repository.deleteNote(id);
  }

  @override
  Future<void> close() {
    _notesSubscription?.cancel();
    return super.close();
  }
}
