import 'package:flutter/material.dart';
import 'package:mock3/models/todo.dart';

class EditTodoScreen extends StatefulWidget {
  final Todo todo;
  const EditTodoScreen({super.key,required this.todo});

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState(){
    super.initState();
    titleController = TextEditingController(text: widget.todo.title);
    descriptionController = TextEditingController(text: widget.todo.description);
  }
  @override
  void dispose(){
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String todoTitle = widget.todo.title;
    return Scaffold(
      appBar: AppBar(title: Text("Edit $todoTitle"),),
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
              final updatedtodo = Todo(
                title: titleController.text, 
                description: descriptionController.text);
              Navigator.pop(context,updatedtodo);
            }, 
            child: Icon(Icons.save))
          ],
        ),
      ),
    );
  }
}