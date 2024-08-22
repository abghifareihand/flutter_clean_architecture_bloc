import 'package:dartz/dartz.dart';
import '../repositories/user_repository.dart';
import '../entities/user.dart';
import '../../../../core/error/failure.dart';

class DeleteUser {
  final UserRepository userRepository;

  DeleteUser(this.userRepository);

  Future<Either<Failure, User>> execute(String id) {
    return userRepository.deleteUser(id);
  }
}
