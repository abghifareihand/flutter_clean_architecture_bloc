part of 'user_edit_bloc.dart';

abstract class UserEditEvent extends Equatable {
  const UserEditEvent();

  @override
  List<Object> get props => [];
}

class EditUserEvent extends UserEditEvent {
  final String id;
  final String name;
  final String email;
  final String address;

  const EditUserEvent(
    this.id,
    this.name,
    this.email,
    this.address,
  );

  @override
  List<Object> get props => [id, name, email, address];
}
