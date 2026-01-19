import 'package:flutter/material.dart';
import 'package:mock3/screens/detail_screen.dart';
import '../models/todo.dart';
import 'create_todo_screen.dart'; // อย่าลืม import หน้าใหม่เข้าไปด้วย

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ย้าย List มาไว้ใน State เพื่อให้เปลี่ยนแปลงค่าได้
  final List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Todo")),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: ListTile(
              onTap: () async {
                final Todo? result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(todo: todos[index])));
                if (result == null){
                  setState(() {
                    todos.removeAt(index);
                  });
                }else{
                  setState(() {
                    todos[index] = result;
                  });
                }
              },
              tileColor: const Color.fromARGB(255, 235, 235, 245),
              leading: const Icon(Icons.book),
              title: Text(
                todos[index].title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(todos[index].description),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // รอรับค่า Todo จากหน้า Create
          final Todo? result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateTodoScreen()),
          );

          // ถ้ามีข้อมูลส่งกลับมา ให้เพิ่มลง List และสั่งอัปเดตหน้าจอ
          if (result != null) {
            setState(() {
              todos.add(result);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}