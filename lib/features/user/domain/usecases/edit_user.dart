import 'package:dartz/dartz.dart';
import '../repositories/user_repository.dart';
import '../entities/user.dart';
import '../../../../core/error/failure.dart';

class EditUser {
  final UserRepository userRepository;

  EditUser(this.userRepository);

  Future<Either<Failure, User>> execute(String id, String name, String email, String address) {
    return userRepository.editUser(id, name, email, address);
  }
}
