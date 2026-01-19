import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import "../models/todo.dart";
import 'dart:async';
import 'package:flutter/widgets.dart';

class DatabaseService {
  Database? database;
  Future<Database> getDatabase() async{
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
    join(await getDatabasesPath(), 'todo_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE todo(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
      );
    },
    version: 1,
    );
    return database;
  }

  Future<void> insertTodo(Todo todo) async{
    final db = await getDatabase();
    await db.insert(
      'todo', 
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      );
  }

  Future<List<Todo>> todos() async{
    final db = await getDatabase();
    final List<Map<String, Object?>> todosmap = await db.query('todo');
    return [
      for (final {'id': id as int, 'title': title as String, 'description': description as String}
          in todosmap)
        Todo(id: id, title: title, description: description),
    ];
  }
  Future<void> updateTodo(Todo todo) async {
    // Get a reference to the database.
    final db = await getDatabase();

    // Update the given Dog.
    await db.update(
      'todo',
      todo.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [todo.id],
    );
  }
  Future<void> deleteTodo(int id) async {
    // Get a reference to the database.
    final db = await getDatabase();

    // Remove the Dog from the database.
    await db.delete(
      'todo',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}