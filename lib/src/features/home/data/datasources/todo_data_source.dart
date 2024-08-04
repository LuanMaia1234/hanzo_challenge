import '../models/todo_model.dart';

abstract class TodoDataSource {
  Future<List<TodoModel>> getList();
}