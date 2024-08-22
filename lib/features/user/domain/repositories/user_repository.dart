import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUserList();
  Future<Either<Failure, User>> getUserDetail(String id);
  Future<Either<Failure, User>> addUser(String name, String email, String address);
  Future<Either<Failure, User>> editUser(String id, String name, String email, String address);
  Future<Either<Failure, User>> deleteUser(String id);
}
