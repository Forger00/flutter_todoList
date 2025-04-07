import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';  // Import the flutter_svg package
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/screens/add_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TODO APP"), centerTitle: true),
      body: Column(
        children: [
          // Show the SVG image only when the todos list is empty
          if (todos.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                'images/empty.svg', // Path to your SVG file
                height: 200,  // Adjust the height if needed
                width: 200,   // Adjust the width if needed
              ),
            ),
          // Show the message or Todo list
          if (todos.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Your todo list is empty. Add something!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          // Show the todo list when there are todos
          if (todos.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  Todo todo = todos[index];
                  return ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.description),
                    trailing: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (value) {
                        setState(() {
                          todo.isCompleted = value!;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // Navigate to AddTodoScreen and await the result
          final newTodo = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AddTodoScreen(),
            ),
          );

          if (newTodo != null) {
            setState(() {
              // Add the new todo to the list
              todos.add(newTodo);
            });
          }
        },
      ),
    );
  }
}
