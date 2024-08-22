part of 'user_edit_bloc.dart';

abstract class UserEditState extends Equatable {
  const UserEditState();

  @override
  List<Object> get props => [];
}

final class UserEditInitial extends UserEditState {}

final class UserEditLoading extends UserEditState {}

final class UserEditLoaded extends UserEditState {
  final User user;

  const UserEditLoaded(this.user);

  @override
  List<Object> get props => [user];
}

final class UserEditError extends UserEditState {
  final String message;

  const UserEditError(this.message);

  @override
  List<Object> get props => [message];
}
