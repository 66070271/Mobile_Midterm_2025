import 'package:flutter/material.dart';
import 'package:mock4/models/todo.dart';
import 'package:mock4/services/database_service.dart';


class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({super.key});

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final db = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create New Todo"),),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(label:Text("Title")),),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(label:Text("description")),
            ),
            ElevatedButton(
              onPressed: () async{
              final newTodo = Todo(
                id: DateTime.now().millisecondsSinceEpoch,
                title: titleController.text, 
                description: descriptionController.text);
              await db.insertTodo(newTodo);
              if(mounted) Navigator.pop(context);
            }, 
            child: Icon(Icons.save))
          ],
        ),
      ),
    );
  }
}