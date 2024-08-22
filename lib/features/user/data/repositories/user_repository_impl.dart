import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_bloc/core/error/failure.dart';
import 'package:flutter_clean_architecture_bloc/features/user/data/datasources/user_local_datasource.dart';
import 'package:flutter_clean_architecture_bloc/features/user/data/datasources/user_remote_datasource.dart';
import 'package:flutter_clean_architecture_bloc/features/user/data/models/user_model.dart';
import 'package:flutter_clean_architecture_bloc/features/user/domain/entities/user.dart';
import 'package:flutter_clean_architecture_bloc/features/user/domain/repositories/user_repository.dart';

import '../../../../core/network/network_info.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource userRemoteDatasource;
  final UserLocalDatasource userLocalDatasource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.userRemoteDatasource,
    required this.userLocalDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<User>>> getUserList() async {
    // try {
    //   bool isConnected = await networkInfo.isConnected();
    //   if (isConnected) {
    //     log('INTERNET TERHUBUNG');
    // List<UserModel> response = await userRemoteDatasource.getUserList();
    // await userLocalDatasource.saveUserList(response);
    // return Right(response);
    //   } else {
    //     log('INTERNET TIDAK TERHUBUNG');
    //     List<UserModel> response = await userLocalDatasource.getUserList();
    //     return Right(response);
    //   }
    // } catch (e) {
    //   return Left(ServerFailure(e.toString()));
    // }

    try {
      List<UserModel> response = await userRemoteDatasource.getUserList();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUserDetail(String id) async {
    try {
      final response = await userRemoteDatasource.getUserDetail(id);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> addUser(String name, String email, String address) async {
    try {
      final response = await userRemoteDatasource.addUser(name, email, address);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> editUser(String id, String name, String email, String address) async {
    try {
      final response = await userRemoteDatasource.editUser(id, name, email, address);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> deleteUser(String id) async {
    try {
      final response = await userRemoteDatasource.deleteUser(id);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
