import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';

class NoteEntity extends Equatable {
  final int id;
  final String content;
  final String username;
  final String userProfileImage;
  final Color color;
  final DateTime createdAt;

  const NoteEntity({
    required this.id,
    required this.content,
    required this.username,
    required this.userProfileImage,
    required this.color,
    required this.createdAt,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    content,
    username,
    userProfileImage,
    color,
    createdAt,
  ];
}
