import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../main.dart';
import '../../../../../utils/constant/sizes.dart';
import '../../../domain/entities/note_entity.dart';
import '../../providers/note_providers.dart';

class StickyNotes extends ConsumerWidget {
  const StickyNotes({super.key, required this.note});

  final NoteEntity note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final randomRotate = (random.nextDouble() * 0.08) - 0.04;
    return Container(
      margin: const EdgeInsets.all(TSizes.smallSpace),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Transform.rotate(
            angle: randomRotate,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: note.color,
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
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(note.userProfileImage),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          note.username,
                          style: textTheme.labelMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    note.content,
                    style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        ref
                            .read(noteNotifierProvider.notifier)
                            .deleteNote(note.id);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: -10,
            left: 0,
            right: 0,
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.thumbtack,
                size: 24,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
