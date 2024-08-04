import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<Either<Failure, Unit>> call() async {
    return await _repository.signOut();
  }
}
