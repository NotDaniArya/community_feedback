import 'dart:async';
import 'dart:math';

import 'package:community_feedback/features/notes/domain/entities/note_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../domain/usecases/note_usecase.dart';

enum NoteStatus { initial, loading, success, error }

class NoteState extends Equatable {
  final List<NoteEntity> notes;
  final NoteStatus status;
  final String errorMessage;

  const NoteState({
    this.notes = const [],
    this.status = NoteStatus.initial,
    this.errorMessage = '',
  });

  NoteState copyWith({
    List<NoteEntity>? notes,
    NoteStatus? status,
    String? errorMessage,
  }) {
    return NoteState(
      notes: notes ?? this.notes,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [notes, status, errorMessage];
}

class NoteNotifier extends StateNotifier<NoteState> {
  final WatchAllNotes _watchAllNotes;
  final AddNote _addNote;
  final DeleteNote _deleteNote;

  StreamSubscription? _notesSubscription;

  NoteNotifier({
    required WatchAllNotes watchAllNotes,
    required AddNote addNote,
    required DeleteNote deleteNote,
  }) : _watchAllNotes = watchAllNotes,
       _addNote = addNote,
       _deleteNote = deleteNote,
       super(const NoteState()) {
    watchNotes();
  }

  void watchNotes() {
    state = state.copyWith(status: NoteStatus.loading);
    _notesSubscription?.cancel();
    _notesSubscription = _watchAllNotes().listen((result) {
      result.fold(
        (failure) => state = state.copyWith(
          status: NoteStatus.error,
          errorMessage: 'Terjadi kesalahan',
        ),
        (notesData) => state = state.copyWith(
          status: NoteStatus.success,
          notes: notesData,
        ),
      );
    });
  }

  Future<void> addNote(String content) async {
    final random = Random();
    final hue = random.nextDouble() * 360;
    final randomPastelColor = HSLColor.fromAHSL(1.0, hue, 0.4, 0.85).toColor();
    final newNote = NoteEntity(
      id: 0,
      content: content,
      username: 'User Test',
      userProfileImage: 'https://i.pravatar.cc/150',
      color: randomPastelColor,
      createdAt: DateTime.now(),
    );

    await _addNote(newNote);
  }

  Future<void> deleteNote(int id) async {
    await _deleteNote(id);
  }

  @override
  void dispose() {
    _notesSubscription?.cancel();
    super.dispose();
  }
}
