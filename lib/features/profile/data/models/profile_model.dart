import 'package:community_feedback/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({required super.name, required super.email});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>;

    return ProfileModel(name: user['name'], email: user['email']);
  }
}
