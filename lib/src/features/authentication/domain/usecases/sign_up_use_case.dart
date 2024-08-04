import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) async {
    return await _repository.signUp(email: email, password: password);
  }
}
