import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:todo_app/cubit/add_todo_cubit.dart';

class AddTodoScreen extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: BlocListener<AddTodoCubit, AddTodoState>(
        listener: (context, state) {
          if (state is TodoAdded) {
            Navigator.pop(context);
          } else if (state is AddTodoError) {
            Toast.show(
              state.error,
              context,
              duration: 3,
              backgroundColor: Colors.red,
              gravity: Toast.CENTER,
            );
          }
        },
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          controller: _controller,
          decoration: InputDecoration(hintText: "Enter todo message..."),
        ),
        SizedBox(height: 10.0),
        InkWell(
          onTap: () {
            final message = _controller.text;
            BlocProvider.of<AddTodoCubit>(context).addTodo(message);
          },
          child: _addBtn(context),
        )
      ],
    );
  }

  Widget _addBtn(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: BlocBuilder<AddTodoCubit, AddTodoState>(
          builder: (context, state) {
            if (state is AddingTodo) return CircularProgressIndicator();

            return Text(
              "Add Todo",
              style: TextStyle(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}
