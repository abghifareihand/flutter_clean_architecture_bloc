import 'package:dartz/dartz.dart';
import '../repositories/user_repository.dart';
import '../entities/user.dart';
import '../../../../core/error/failure.dart';

class AddUser {
  final UserRepository userRepository;

  AddUser(this.userRepository);

  Future<Either<Failure, User>> execute(String name, String email, String address) {
    return userRepository.addUser(name, email, address);
  }
}
