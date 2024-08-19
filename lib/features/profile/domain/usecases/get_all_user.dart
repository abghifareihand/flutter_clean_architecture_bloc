import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class GetAllUser {
  final ProfileRepository profileRepository;

  GetAllUser(this.profileRepository);

  Future<Either<Failure, List<Profile>>> execute(int page) {
    return profileRepository.getAllUser(page);
  }
}
