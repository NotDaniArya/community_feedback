import 'package:community_feedback/features/notes/domain/repositories/note_repository.dart';
import 'package:community_feedback/features/notes/domain/usecases/get_list_notes_usecase.dart';
import 'package:community_feedback/features/notes/presentation/cubit/notes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesCubit extends Cubit<NotesState> {
  final GetListNotesUsecase _getListNotesUsecase;

  NotesCubit(this._getListNotesUsecase) : super(NotesInitial());

  Future<void> fetchNotes() async {
    emit(NotesLoading());

    final result = await _getListNotesUsecase();

    result.fold((failure) {
      emit(NotesError(failure.message));
    }, (notes){
      if (notes.isEmpty) {
        emit(const NotesLoaded([]));
      } else {
        emit(NotesLoaded(notes));
      }
    });
  }
}
