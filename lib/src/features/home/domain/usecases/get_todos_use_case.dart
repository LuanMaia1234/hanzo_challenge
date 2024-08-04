import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

class GetTodosUseCase {
  final TodoRepository _repository;

  GetTodosUseCase(this._repository);

  Future<Either<Failure, List<TodoEntity>>> call() async {
    return await _repository.getList();
  }
}
