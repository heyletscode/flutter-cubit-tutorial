import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:todo_app/cubit/edit_todo_cubit.dart';
import 'package:todo_app/data/models/todo.dart';

class EditTodoScreen extends StatelessWidget {
  final Todo todo;
  EditTodoScreen({Key key, this.todo}) : super(key: key);

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = todo.todoMessage;

    return BlocListener<EditTodoCubit, EditTodoState>(
      listener: (context, state) {
        if (state is TodoEdited) {
          Navigator.pop(context);
        } else if (state is EditTodoError) {
          Toast.show(state.error, context,
              backgroundColor: Colors.red, duration: 3, gravity: Toast.CENTER);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Todo"),
          actions: [
            InkWell(
              onTap: () {
                BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.delete),
              ),
            )
          ],
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            autocorrect: true,
            decoration: InputDecoration(hintText: "Enter todo message..."),
          ),
          SizedBox(height: 10.0),
          InkWell(onTap: () {
            BlocProvider.of<EditTodoCubit>(context).updateTodo(todo, _controller.text);
          }, child: _updateBtn(context))
        ],
      ),
    );
  }

  Widget _updateBtn(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          "Update Todo",
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
      ),
    );
  }
}
