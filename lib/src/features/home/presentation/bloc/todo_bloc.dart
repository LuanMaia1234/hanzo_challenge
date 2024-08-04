import 'package:bloc/bloc.dart';

import '../../domain/usecases/get_todos_use_case.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodosUseCase _getTodosUseCase;

  TodoBloc(this._getTodosUseCase) : super(const TodoInitialState()) {
    on<GetTodosEvent>(_getTodos);
  }

  Future<void> _getTodos(
    GetTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(const TodoLoadingState());
    final result = await _getTodosUseCase();
    result.fold(
      (failure) => emit(TodoErrorState(message: failure.message)),
      (todos) => emit(TodoSuccessState(todos: todos)),
    );
  }
}
