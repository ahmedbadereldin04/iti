import 'package:flutter/material.dart';
import '../screens/home_page.dart';

class TasksTab extends StatefulWidget {
  final VoidCallback onUpdate;
  TasksTab({required this.onUpdate});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  final taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: taskController,
            decoration: InputDecoration(labelText: 'New Task'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                tasks.add(taskController.text);
                taskController.clear();
              });
              widget.onUpdate();
            },
            child: Text('Add Task'),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                final isCompleted = completedTasks.contains(task);
                return Card(
                  child: ListTile(
                    title: Text(
                      task,
                      style: TextStyle(
                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text('Created By: $fullName'),
                    trailing: Wrap(
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            setState(() {
                              completedTasks.add(task);
                            });
                            widget.onUpdate();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              completedTasks.remove(task);
                              tasks.removeAt(index);
                            });
                            widget.onUpdate();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}