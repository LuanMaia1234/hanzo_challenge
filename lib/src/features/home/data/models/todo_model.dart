import '../../domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel({
    required super.id,
    required super.title,
    required super.completed,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      completed: map['completed'],
    );
  }
}
