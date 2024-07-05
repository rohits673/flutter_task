import 'package:dartz/dartz.dart';
import 'package:flutter_task/data/repositories/user_repositories.dart';

import '../../core/failures/failures.dart';
import '../entities/user_entity.dart';

abstract class FetchUsersUseCase {
  Future<Either<Failure, List<UserEntity>>> call();
}

class FetchUsers implements FetchUsersUseCase {
  @override
  Future<Either<Failure, List<UserEntity>>> call() async {
    return await UserRepository().fetchUsers();
  }
}
