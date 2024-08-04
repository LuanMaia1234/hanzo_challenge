import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) async {
    return await _repository.signIn(email: email, password: password);
  }
}
