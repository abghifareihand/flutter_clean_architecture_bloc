import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.avatar,
  });

  /// Convert from Map -> Object
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json["id"],
      email: json["email"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      avatar: json["avatar"],
    );
  }

  /// Convert from Object -> Map
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "avatar": avatar,
    };
  }

  @override
  List<Object?> get props => [id, email, firstName, lastName, avatar];
}
