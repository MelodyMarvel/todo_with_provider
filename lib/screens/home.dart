import 'package:flutter/material.dart';
import 'package:todo_with_provider/constants/colors.dart';
import 'package:todo_with_provider/model/todo.dart';
import 'package:todo_with_provider/widgets/todo_item.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_provider/provider/todo_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: tdBGColor,
          appBar: _buildAppBar(),
          body: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    searchBox(),
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 50, bottom: 20),
                            child: const Text(
                              'All ToDos',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                          ),
                          for (ToDo todo in provider.foundTodo.reversed)
                            TodoItem(
                              todo: todo,
                              onTodoChanged: provider.toggleTodoStatus,
                              onDelete: provider.deleteTodoById,
                              onEdit: (todo) => _editTodoItem(context, provider, todo),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            bottom: 20, right: 20, left: 20),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: const Offset(0, 0),
                                blurRadius: 10.0,
                                spreadRadius: 0.0)
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _todoController,
                          decoration: const InputDecoration(
                              hintText: 'Add new todo item',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, right: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          provider.addTodoItem(_todoController.text);
                          _todoController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(60, 60),
                          elevation: 10,
                        ),
                        child: const Text(
                          '+',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/profile.png'),
            ),
          )
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) =>
            Provider.of<ToDoProvider>(context, listen: false).runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
          border: InputBorder.none,
          prefixIconConstraints: BoxConstraints(minHeight: 20, minWidth: 25),
        ),
      ),
    );
  }

  void _editTodoItem(BuildContext context, ToDoProvider provider, ToDo todo) {
    final TextEditingController editController =
        TextEditingController(text: todo.todoText);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Todo', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
          content: TextField(
            controller: editController,
            style: TextStyle(fontSize: 12),
            // decoration: const InputDecoration(labelText: 'Todo'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                provider.updateTodoItem(
                  todo.id!,
                  newTodoText: editController.text,
                );
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
