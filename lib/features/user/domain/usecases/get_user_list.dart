import 'package:dartz/dartz.dart';
import '../repositories/user_repository.dart';
import '../entities/user.dart';
import '../../../../core/error/failure.dart';

class GetUserList {
  final UserRepository userRepository;

  GetUserList(this.userRepository);

  Future<Either<Failure, List<User>>> execute() {
    return userRepository.getUserList();
  }
}
