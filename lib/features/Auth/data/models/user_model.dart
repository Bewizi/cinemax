import 'package:cinemax/features/Auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.firstname,
    required super.lastname,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handling potential differences in backend keys (full_name vs fullName)
    return UserModel(
      firstname: (json['firstname'] ?? json['firstame']) as String? ?? '',
      lastname: (json['lastname'] ?? json['lastame']) as String? ?? '',
      email: json['email'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
    };
  }

  UserEntity toEntity() => UserEntity(
    firstname: firstname,
    lastname: lastname,
    email: email,
  );
}
