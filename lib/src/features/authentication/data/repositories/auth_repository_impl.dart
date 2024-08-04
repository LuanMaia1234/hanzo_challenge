import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _dataSource.signUp(email: email, password: password);
      return Right(result);
    } on ExistedAccountException {
      return Left(ExistedAccountFailure('E-mail já está em uso'));
    } on WeekPasswordException {
      return Left(
        WeekPasswordFailure('Senha deve conter pelo menos seis caracteres'),
      );
    } catch (_) {
      return Left(ServerFailure('Error ao tentar realizar cadastro'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _dataSource.signIn(email: email, password: password);
      return Right(result);
    } on InvalidCredentialException {
      return Left(
        InvalidCredentialFailure(
          'Dados informados não correspondem com nossos registros.',
        ),
      );
    } catch (_) {
      return Left(ServerFailure('Error ao tentar realizar login'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getLoggedUser() async {
    try {
      final result = await _dataSource.getLoggedUser();
      return Right(result);
    } catch (_) {
      return Left(ServerFailure('Error ao tentar recuperar usuario logado'));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await _dataSource.signOut();
      return const Right(unit);
    } catch (_) {
      return Left(ServerFailure('Error ao tentar deslogar'));
    }
  }
}
