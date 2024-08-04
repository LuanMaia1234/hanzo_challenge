import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_data_source.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoDataSource _dataSource;

  TodoRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<TodoEntity>>> getList() async {
    try {
      final result = await _dataSource.getList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Error ao buscar lista de tarefas'));
    }
  }
}
