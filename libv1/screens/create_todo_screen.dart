import 'package:flutter/material.dart';
import 'package:mock3/models/todo.dart';

class CreateTodoScreen extends StatefulWidget {
  const CreateTodoScreen({super.key});

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
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
              onPressed: (){
              final newTodo = Todo(
                title: titleController.text, 
                description: descriptionController.text);
              Navigator.pop(context,newTodo);
            }, 
            child: Icon(Icons.save))
          ],
        ),
      ),
    );
  }
}