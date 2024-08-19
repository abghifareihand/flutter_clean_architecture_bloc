import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_bloc/features/profile/data/models/profile_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource profileRemoteDatasource;
  final ProfileLocalDatasource profileLocalDatasource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.profileRemoteDatasource,
    required this.profileLocalDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Profile>>> getAllUser(int page) async {
    try {
      // Check internet
      bool isConnected = await networkInfo.isConnected();
      if (isConnected) {
        // Available internet (get remote datasource)
        log('INTERNET TERHUBUNG');
        List<ProfileModel> response = await profileRemoteDatasource.getAllUser(page);
        await profileLocalDatasource.saveAllUser(page, response);
        return Right(response);
      } else {
        // No internet (get local datasource)
        log('INTERNET TIDAK TERHUBUNG');
        List<ProfileModel> response = await profileLocalDatasource.getAllUser(page);
        return Right(response);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Profile>> getUser(int id) async {
    try {
      // Check internet
      bool isConnected = await networkInfo.isConnected();
      if (isConnected) {
        // Available internet (get remote datasource)
        final response = await profileRemoteDatasource.getUser(id);
        // Ketika sudah dapet data dari internet Kirim last data profile ke box (local)
        return Right(response);
      } else {
        // No internet (get local datasource)
        final response = await profileLocalDatasource.getUser(id);
        return Right(response);
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
