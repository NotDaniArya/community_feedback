import 'package:community_feedback/features/notes/domain/entities/note_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/notes_cubit.dart';

class StickyNote extends StatelessWidget {
  final NoteEntity note;

  const StickyNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Material diperlukan untuk shadow
      child: Container(
        width: 200,
        height: 200,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: note.color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(note.userProfileImage),
                ),
                const SizedBox(width: 8),
                Text(
                  note.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    size: 18,
                    color: Colors.black54,
                  ),
                  onPressed: () =>
                      context.read<NotesCubit>().deleteNote(note.id),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: Text(note.content, style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
