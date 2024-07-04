import 'package:flutter/material.dart';
import './components/home_page.dart';

void main(List<String> args) {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My Todo App',
      home: HomePage(),
    );
  }
}
