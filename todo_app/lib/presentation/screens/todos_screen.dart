import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/constants/strings.dart';
import 'package:todo_app/cubit/todos_cubit.dart';
import 'package:todo_app/data/models/todo.dart';

class TodosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchTodos();

    return Scaffold(
        appBar: AppBar(
          title: Text("Todos"),
          actions: [
            InkWell(
              onTap: () => Navigator.pushNamed(context, ADD_TODO_ROUTE),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.add),
              ),
            )
          ],
        ),
        body: BlocBuilder<TodosCubit, TodosState>(
          builder: (context, state) {
            if (!(state is TodosLoaded))
              return Center(child: CircularProgressIndicator());

            final todos = (state as TodosLoaded).todos;

            return SingleChildScrollView(
              child: Column(
                children: todos.map((e) => _todo(e, context)).toList(),
              ),
            );
          },
        ));
  }

  Widget _todo(Todo todo, context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, EDIT_TODO_ROUTE, arguments: todo),
          child: Dismissible(
        key: Key("${todo.id}"),
        child: _todoTile(todo, context),
        confirmDismiss: (_) async {
          BlocProvider.of<TodosCubit>(context).changeCompletion(todo);
          return false;
        },
        background: Container(color: Colors.indigo,),
      ),
    );
  }

  Widget _todoTile(Todo todo, context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200],
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(todo.todoMessage),
          _completionIndicator(todo),
        ],
      ),
    );
  }

  Widget _completionIndicator(Todo todo) {
    return Container(
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          width: 4.0,
          color: todo.isCompleted ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
