import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc/features/user/domain/usecases/edit_user.dart';

import '../../../domain/entities/user.dart';

part 'user_edit_event.dart';
part 'user_edit_state.dart';

class UserEditBloc extends Bloc<UserEditEvent, UserEditState> {
  final EditUser editUser;
  UserEditBloc({required this.editUser}) : super(UserEditInitial()) {
    on<EditUserEvent>((event, emit) async {
      emit(UserEditLoading());
      final result = await editUser.execute(event.id, event.name, event.email, event.address);
      result.fold(
        (error) => emit(UserEditError(error.message)),
        (data) => emit(UserEditLoaded(data)),
      );
    });
  }
}
