import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';

class NoteEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String? image;
  final String color;
  final Reactions reaction;
  final int userId;
  final String userName;
  final String createdAt;

  const NoteEntity({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    required this.color,
    required this.reaction,
    required this.userId,
    required this.userName,
    required this.createdAt,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    title,
    description,
    image,
    color,
    reaction,
    userId,
    userName,
    createdAt,
  ];
}

class Reactions extends Equatable {
  final int like;
  final int heart;
  final int laugh;
  final int surprised;
  final int fire;

  const Reactions({
    required this.like,
    required this.heart,
    required this.laugh,
    required this.surprised,
    required this.fire,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [like, heart, laugh, surprised, fire];
}
