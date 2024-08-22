part of 'user_detail_bloc.dart';

abstract class UserDetailState extends Equatable {
  const UserDetailState();

  @override
  List<Object> get props => [];
}

final class UserDetailInitial extends UserDetailState {}

final class UserDetailLoading extends UserDetailState {}

final class UserDetailLoaded extends UserDetailState {
  final User user;

  const UserDetailLoaded(this.user);

  @override
  List<Object> get props => [user];
}

final class UserDetailError extends UserDetailState {
  final String message;

  const UserDetailError(this.message);

  @override
  List<Object> get props => [message];
}
