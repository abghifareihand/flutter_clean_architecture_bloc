import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/delete_user.dart';

part 'user_delete_event.dart';
part 'user_delete_state.dart';

class UserDeleteBloc extends Bloc<UserDeleteEvent, UserDeleteState> {
  final DeleteUser deleteUser;
  UserDeleteBloc({required this.deleteUser}) : super(UserDeleteInitial()) {
    on<DeleteUserEvent>((event, emit) async {
      emit(UserDeleteLoading());
      final result = await deleteUser.execute(event.id);
      result.fold(
        (error) => emit(UserDeleteError(error.message)),
        (data) => emit(UserDeleteLoaded(data)),
      );
    });
  }
}
