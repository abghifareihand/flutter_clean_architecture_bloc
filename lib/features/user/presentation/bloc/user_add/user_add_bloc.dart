import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_bloc/features/user/domain/usecases/add_user.dart';

import '../../../domain/entities/user.dart';

part 'user_add_event.dart';
part 'user_add_state.dart';

class UserAddBloc extends Bloc<UserAddEvent, UserAddState> {
  final AddUser addUser;
  UserAddBloc({required this.addUser}) : super(UserAddInitial()) {
    on<AddUserEvent>((event, emit) async {
      emit(UserAddLoading());
      final result = await addUser.execute(event.name, event.email, event.address);
      result.fold(
        (error) => emit(UserAddError(error.message)),
        (data) => emit(UserAddLoaded(data)),
      );
    });
  }
}
