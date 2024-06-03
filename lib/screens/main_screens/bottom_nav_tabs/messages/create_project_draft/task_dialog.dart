import 'package:flutter/material.dart';

class TaskDialog extends StatefulWidget {
  final Function(String, String, String) onAddTask;

  const TaskDialog({required this.onAddTask, Key? key}) : super(key: key);

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  final TextEditingController _taskPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Task'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _taskNameController,
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
            ),
            TextFormField(
              controller: _taskDescriptionController,
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
            ),
            TextFormField(
              controller: _taskPriceController,
              decoration: const InputDecoration(
                hintText: 'Price',
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onAddTask(
              _taskNameController.text,
              _taskDescriptionController.text,
              _taskPriceController.text,
            );
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
