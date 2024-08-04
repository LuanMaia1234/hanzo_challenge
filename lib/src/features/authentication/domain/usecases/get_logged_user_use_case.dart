import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetLoggedUserUseCase {
  final AuthRepository _repository;

  GetLoggedUserUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call() async {
    return await _repository.getLoggedUser();
  }
}
