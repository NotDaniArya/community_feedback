import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String name;
  final String email;

  const ProfileEntity({required this.name, required this.email});

  @override
  // TODO: implement props
  List<Object?> get props => [name, email];
}
