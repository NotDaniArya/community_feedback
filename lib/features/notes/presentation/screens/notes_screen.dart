import 'package:community_feedback/features/notes/presentation/providers/note_providers.dart';
import 'package:community_feedback/features/notes/presentation/providers/note_state_notifier.dart';
import 'package:community_feedback/features/notes/presentation/screens/widgets/sticky_note.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:community_feedback/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteState = ref.watch(noteNotifierProvider);

    return Scaffold(
      backgroundColor: TColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(TSizes.mediumSpace),
          child: switch (noteState.status) {
            NoteStatus.loading || NoteStatus.initial => const Center(
              child: CircularProgressIndicator(),
            ),

            NoteStatus.error => Center(
              child: Text(
                'Terjadi Kesalahan: ${noteState.errorMessage},',
                textAlign: TextAlign.center,
              ),
            ),

            NoteStatus.success =>
              noteState.notes.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada notes.\nTekan tombol + untuk menambah',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : MasonryGridView.count(
                      itemCount: noteState.notes.length,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      itemBuilder: (context, index) {
                        final note = noteState.notes[index];

                        return StickyNotes(note: note);
                      },
                    ),
          },
        ),
      ),
    );
  }
}
