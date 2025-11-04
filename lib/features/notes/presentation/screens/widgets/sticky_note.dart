import 'package:community_feedback/features/notes/domain/entities/note_entity.dart';
import 'package:community_feedback/features/notes/presentation/screens/widgets/reaction_chip.dart';
import 'package:community_feedback/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/constant/sizes.dart';

class StickyNote extends StatelessWidget {
  final NoteEntity note;

  const StickyNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 320,
      margin: const EdgeInsets.all(TSizes.smallSpace),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: note.color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: TSizes.mediumSpace),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    note.username,
                    style: textTheme.labelMedium!.copyWith(
                      color: TColors.secondaryText,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(width: TSizes.largeSpace),

                Text(
                  DateFormat('d/MM/yyyy').format(note.createdAt),
                  style: textTheme.labelMedium!.copyWith(
                    color: TColors.secondaryText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.mediumSpace),
            Text(
              note.title,
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: TSizes.mediumSpace),
            Text(
              note.content,
              style: textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: TSizes.mediumSpace),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReactionChip(emoji: '❤️'),
                ReactionChip(emoji: '👍'),
                ReactionChip(emoji: '😂'),
                ReactionChip(emoji: '😮'),
                ReactionChip(emoji: '🔥'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
