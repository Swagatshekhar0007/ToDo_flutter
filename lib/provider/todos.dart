import 'package:flutter/cupertino.dart';
import 'package:todo_app_ui_ii_example/api/firebase_api.dart';
import 'package:todo_app_ui_ii_example/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

      void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });

  void addTodo(Todo todo) {
    FirebaseApi.createTodo(todo);
    _todos.add(todo);

    notifyListeners();
  }

  void removeTodo(Todo todo) {
    FirebaseApi.deleteTodo(todo);
    _todos.remove(todo);

    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    FirebaseApi.updateTodo(todo);
  }
}
