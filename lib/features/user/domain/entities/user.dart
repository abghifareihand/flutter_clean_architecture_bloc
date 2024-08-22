import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String address;
  final String avatar;
  final String createdAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.avatar,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, email, address, avatar, createdAt];
}
