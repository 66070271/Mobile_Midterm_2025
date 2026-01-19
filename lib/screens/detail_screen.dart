import 'package:flutter/material.dart';
import 'package:mock4/models/todo.dart';
import 'package:mock4/screens/edit_todo_screen.dart';
import 'package:mock4/services/database_service.dart';

class DetailScreen extends StatefulWidget {
  final Todo todo;
  const DetailScreen({super.key,required this.todo});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Todo currentTodo;
  final db = DatabaseService();
  @override
  void initState(){
    super.initState();
    currentTodo = widget.todo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context,currentTodo);
        }, icon: Icon(Icons.arrow_back)),
        title: Row(
          children: [
            Text(currentTodo.title),
            SizedBox(width: 10,),
            ElevatedButton(onPressed: ()async {
              final Todo? result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditTodoScreen(todo: currentTodo)));
              if(result != null){
                setState(() {
                  currentTodo = result;
                });
              }
            },style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber
            ),child: Icon(Icons.edit),),
            SizedBox(width: 10,),
            ElevatedButton(onPressed: ()async{
              await db.deleteTodo(currentTodo.id!);
              if(mounted)Navigator.pop(context);
            },style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 230, 65, 23)
            ) ,child: Icon(Icons.delete),)
          ],
        ),
        ),
      body: Padding(padding: EdgeInsetsGeometry.all(16),
        child: Text(
          currentTodo.description,
          style: TextStyle(fontSize: 20),),
      ),
      
    );
  }
}