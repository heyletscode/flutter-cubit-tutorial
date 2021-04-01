import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/data/models/todo.dart';
import 'package:todo_app/data/repository.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final Repository repository;

  TodosCubit({this.repository}) : super(TodosInitial());

  void fetchTodos() {
    Timer(Duration(seconds: 3), () {
      repository.fetchTodos().then((todos) {
        emit(TodosLoaded(todos: todos));
      });
    });
  }

  void changeCompletion(Todo todo) {
    repository.changeCompletion(!todo.isCompleted, todo.id).then((isChanged) {
      if (isChanged) {
        todo.isCompleted = !todo.isCompleted;
        updateTodoList();
      }
    });
  }

  void updateTodoList() {
    final currentState = state;
    if (currentState is TodosLoaded)
      emit(TodosLoaded(todos: currentState.todos));
  }

  addTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todoList = currentState.todos;
      todoList.add(todo);
      emit(TodosLoaded(todos: todoList));
    }
  }

  void deleteTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todoList = currentState.todos.where((element) => element.id != todo.id).toList();
      emit(TodosLoaded(todos: todoList));
    }
  }
}
