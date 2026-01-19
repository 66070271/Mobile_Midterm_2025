import 'package:flutter/material.dart';
import 'package:mock4/models/todo.dart';
import 'package:mock4/services/database_service.dart';

class EditTodoScreen extends StatefulWidget {
  final Todo todo;
  const EditTodoScreen({super.key,required this.todo});

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final db = DatabaseService();

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
        child:Form(
          key: _formKey,
          child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(label:Text("Title")),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please enter some title';
                }
                return null;
              },
              ),
              
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(label:Text("description")),
            ),
            ElevatedButton(
              onPressed: ()async{
            if (_formKey.currentState!.validate()) {
              final updatedtodo = Todo(
                id: widget.todo.id,
                title: titleController.text, 
                description: descriptionController.text);
              await db.updateTodo(updatedtodo);
              Navigator.pop(context,updatedtodo);
            }
            }, 
            child: Icon(Icons.save))
          ],
        ),
      ),
    ));
  }
}