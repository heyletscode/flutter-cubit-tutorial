class Todo {
  String todoMessage;
  bool isCompleted;
  int id;

  Todo.fromJson(Map json) :
    todoMessage = json["todo"],
    isCompleted = json["isCompleted"] == "true",
    id = json["id"] as int;

}