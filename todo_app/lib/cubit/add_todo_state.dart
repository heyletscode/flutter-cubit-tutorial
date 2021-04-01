part of 'add_todo_cubit.dart';

@immutable
abstract class AddTodoState {}

class AddTodoInitial extends AddTodoState {}
class AddTodoError extends AddTodoState {
  final String error;

  AddTodoError({this.error});
}

class AddingTodo extends AddTodoState {}
class TodoAdded extends AddTodoState {}