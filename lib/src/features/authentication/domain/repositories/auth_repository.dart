import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> getLoggedUser();

  Future<Either<Failure, Unit>> signOut();
}
