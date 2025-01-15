import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_with_provider/model/todo.dart';

class ToDoProvider with ChangeNotifier {
  bool isLoading = false;

  final _todoController = TextEditingController();

  // Initialize `_todosList` with data from `ToDo.todoList()`
  final List<ToDo> _todosList = ToDo.todoList();

  // Public getter for `_todosList`
  List<ToDo> get todosList => _todosList;

  List<ToDo> _foundTodo = [];

  List<ToDo> get foundTodo => _foundTodo.isEmpty ? _todosList : _foundTodo;

  ToDoProvider() {
    _foundTodo = _todosList;
  }

  void toggleTodoStatus(ToDo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
  }

  void deleteTodoById(String id) {
    _todosList.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void addTodoItem(String toDo) {
    _todosList.add(ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: toDo,
    ));
    notifyListeners();
  }

void updateTodoItem(String id, {String? newTodoText, bool? newIsDone}) {
    final todoIndex = _todosList.indexWhere((todo) => todo.id == id);
    if (todoIndex != -1) {
      final todo = _todosList[todoIndex];
      todo.todoText = newTodoText ?? todo.todoText;
      todo.isDone = newIsDone ?? todo.isDone;
      notifyListeners();
    }
  }
  
  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      _foundTodo = _todosList;
    } else {
      _foundTodo = _todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
