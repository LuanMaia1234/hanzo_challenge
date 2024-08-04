import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/todo_model.dart';
import 'todo_data_source.dart';

class TodoDataSourceImpl implements TodoDataSource {
  final Dio _dioClient;

  TodoDataSourceImpl(this._dioClient);

  @override
  Future<List<TodoModel>> getList() async {
    final result = await _dioClient.get('todos');
    if (result.statusCode == 200) {
      final List<TodoModel> list =
          (result.data as List).map((json) => TodoModel.fromMap(json)).toList();
      return list;
    }
    throw ServerException();
  }
}
