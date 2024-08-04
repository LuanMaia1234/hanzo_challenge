import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/todo_entity.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<TodoEntity>>> getList();
}
