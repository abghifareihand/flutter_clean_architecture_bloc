part of 'user_add_bloc.dart';

sealed class UserAddState extends Equatable {
  const UserAddState();

  @override
  List<Object> get props => [];
}

final class UserAddInitial extends UserAddState {}

final class UserAddLoading extends UserAddState {}

final class UserAddLoaded extends UserAddState {
  final User user;

  const UserAddLoaded(this.user);

  @override
  List<Object> get props => [user];
}

final class UserAddError extends UserAddState {
  final String message;

  const UserAddError(this.message);

  @override
  List<Object> get props => [message];
}
