import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.address,
    required super.avatar,
    required super.createdAt,
  });

  /// Convert from Map -> Object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      address: json["address"],
      avatar: json["avatar"],
      createdAt: json["createdAt"],
    );
  }

  /// Convert from Object -> Map
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "address": address,
      "avatar": avatar,
      "createdAt": createdAt,
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, address: $address)';
  }

  @override
  List<Object?> get props => [id, name, email, address, avatar, createdAt];
}
