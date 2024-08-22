part of 'user_add_bloc.dart';

abstract class UserAddEvent extends Equatable {
  const UserAddEvent();

  @override
  List<Object> get props => [];
}

class AddUserEvent extends UserAddEvent {
  final String name;
  final String email;
  final String address;

  const AddUserEvent(
    this.name,
    this.email,
    this.address,
  );

  @override
  List<Object> get props => [name, email, address];
}
