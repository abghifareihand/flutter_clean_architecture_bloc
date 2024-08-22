import 'package:dartz/dartz.dart';
import '../repositories/user_repository.dart';
import '../entities/user.dart';
import '../../../../core/error/failure.dart';

class GetUserDetail {
  final UserRepository userRepository;

  GetUserDetail(this.userRepository);

  Future<Either<Failure, User>> execute(String id) {
    return userRepository.getUserDetail(id);
  }
}
