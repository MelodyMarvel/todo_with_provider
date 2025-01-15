import 'package:flutter/material.dart';
import 'package:todo_with_provider/constants/colors.dart';
import 'package:todo_with_provider/model/todo.dart';

class TodoItem extends StatelessWidget {
    final ToDo todo;
    // ignore: prefer_typing_uninitialized_variables
    final onTodoChanged;
    final onDelete;
    final onEdit;

  const TodoItem({super.key, required this.todo, required this.onTodoChanged, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          // onTodoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            onTodoChanged(todo);
          },
          icon:Icon(
            todo.isDone? Icons.check_box:Icons.check_box_outline_blank, 
            color: tdBlue
            ),
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: todo.isDone? TextDecoration.lineThrough : null),
        ),
         trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () => onEdit(todo),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: tdred),
              onPressed: () => onDelete(todo.id!),
            ),
          ],
        ),
      ),
    );
  }
}
