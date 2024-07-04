import 'package:flutter/material.dart';

class TaskItemWidget extends StatefulWidget {
  final String name;
  final VoidCallback onRemove;

  const TaskItemWidget({required this.name, required this.onRemove, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TaskItemWidgetState createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  bool marked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 5),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: const EdgeInsets.all(10),
      child: CheckboxListTile(
        title: Text(
          widget.name,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        value: marked,
        onChanged: (value) {
          setState(() {
            marked = value!;
            if (marked) {
              widget.onRemove();
            }
            marked = false;
          });
        },
      ),
    );
  }
}
