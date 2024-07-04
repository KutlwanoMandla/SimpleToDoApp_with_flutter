import 'package:flutter/material.dart';
import './task_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List<TaskItemWidget> tasks = [];
  late TextEditingController controller;
  String name = "";

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Todo App',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: (tasks.isEmpty)
          ? NoTaskWidget()
          : Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return tasks[index];
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final name = await openDialog();

          if (name == null || name.isEmpty) return;

          setState(() {
            this.name = name;
          });
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),


      ),
    );
  }

  // show a dialog to create a new task
  Future<String?> openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Create task'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "Enter name of Task",
            ),
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: submit,
              child: const Text("SUBMIT"),
            ),
          ],
        ),
      );

  // creating a task button
  void submit() {
    Navigator.of(context).pop(controller.text);

    setState(() {
      final name = controller.text;
      tasks.add(
        TaskItemWidget(
          name: name,
          onRemove: () => removeTask(name),
        ),
      );
    });

    controller.clear();
  }

  // removing/ marking a task complete
  void removeTask(String taskName) {
    setState(() {
      tasks.removeWhere((task) => task.name == taskName);
    });
  }

  // ignore: non_constant_identifier_names
  Widget NoTaskWidget() {
    return Center(
      child: Transform.rotate(
        angle: -45,
        child: const Text(
          'No Task Added!',
          style: TextStyle(
            fontSize: 40,
            color: Color.fromARGB(255, 239, 8, 12),
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ),
    );
  }
}
