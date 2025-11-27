import 'package:community_feedback/features/notes/domain/entities/note_entity.dart';
import 'package:intl/intl.dart';

class NoteModel extends NoteEntity {
  const NoteModel({
    required super.id,
    required super.title,
    required super.description,
    super.image,
    required super.color,
    required super.reaction,
    required super.userId,
    required super.createdAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    String formattedDate;
    try {
      final dateStr = json['created_at'] as String?;
      if (dateStr != null) {
        final date = DateTime.parse(dateStr);
        formattedDate = DateFormat('dd/MM/yyyy').format(date);
      } else {
        formattedDate = '-';
      }
    } catch (e) {
      formattedDate = '-';
    }

    return NoteModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String?,
      color: json['color'] as String,
      reaction: ReactionsModel.fromJson(json['reactions']),
      userId: (json['user'] != null && json['user'] is Map)
          ? (json['user']['id'] as int? ?? 0)
          : 0,
      createdAt: formattedDate,
    );
  }
}

class ReactionsModel extends Reactions {
  const ReactionsModel({
    required super.like,
    required super.heart,
    required super.laugh,
    required super.surprised,
    required super.fire,
  });

  factory ReactionsModel.fromJson(Map<String, dynamic> json) {
    return ReactionsModel(
      like: json['like'] ?? 0,
      heart: json['heart'] ?? 0,
      laugh: json['laugh'] ?? 0,
      surprised: json['surprised'] ?? 0,
      fire: json['fire'] ?? 0,
    );
  }
}
