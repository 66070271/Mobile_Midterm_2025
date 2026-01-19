import 'package:flutter/material.dart';
import 'package:mock4/screens/detail_screen.dart';
import '../models/todo.dart';
import '../screens/create_todo_screen.dart';
import '../services/database_service.dart';
// 1. Import widget ที่เราแยกออกไป
import '../widgets/todo_item.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todos = [];
  final db = DatabaseService();

  void loadData() async {
    List<Todo> data = await db.todos();
    setState(() {
      todos = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Todo")),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          // 2. เรียกใช้งาน TodoItem แทนการเขียน ListTile ยาวๆ
          return TodoItem(
            todo: todos[index],
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(todo: todos[index]),
                ),
              );
              loadData();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateTodoScreen()),
          );
          loadData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}