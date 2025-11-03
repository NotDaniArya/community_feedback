import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';

class NoteEntity extends Equatable {
  final int id;
  final String title;
  final String content;
  final String username;
  final String userProfileImage;
  final Color color;
  final Offset position;
  final DateTime createdAt;

  const NoteEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.username,
    required this.userProfileImage,
    required this.color,
    required this.position,
    required this.createdAt,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    title,
    content,
    username,
    userProfileImage,
    color,
    position,
    createdAt,
  ];
}
