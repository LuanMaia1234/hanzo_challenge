import 'package:equatable/equatable.dart';

import '../../domain/entities/todo_entity.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

class TodoInitialState extends TodoState {
  const TodoInitialState();
}

class TodoLoadingState extends TodoState {
  const TodoLoadingState();
}

class TodoSuccessState extends TodoState {
  const TodoSuccessState({
    required this.todos,
  });

  final List<TodoEntity> todos;

  @override
  List<Object?> get props => [todos];
}

class TodoErrorState extends TodoState {
  const TodoErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}