import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.firstname,
    required this.lastname,
    required this.email,
  });

  final String firstname;
  final String lastname;
  final String email;

  @override
  List<Object?> get props => [firstname, lastname, email];
}
