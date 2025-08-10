import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo/todo_bloc/todo_bloc.dart';
import 'package:todo_bloc/bloc/todo/todo_event/todo_event.dart';
import 'package:todo_bloc/bloc/todo/todo_state/todo_state.dart';

class TodoScreen extends StatelessWidget {
  TodoScreen({super.key});

  final TextEditingController _todoController = TextEditingController();

  void _showTodoDialog({
    required BuildContext context,
    String initialText = '',
    required VoidCallback onSubmit,
  }) {
    _todoController.text = initialText;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  initialText.isEmpty ? "Add New Task" : "Edit Task",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _todoController,
                  decoration: InputDecoration(
                    hintText: "What needs to be done?",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                  ),
                  style: const TextStyle(fontSize: 16),
                  maxLines: 3,
                  minLines: 1,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _todoController.clear();
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "CANCEL",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        onSubmit();
                        _todoController.clear();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        "SAVE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "My Tasks",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.todos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 64,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No tasks yet",
                    style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Tap the + button to add a new task",
                    style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: state.todos.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  title: Text(
                    state.todos[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.grey[600]),
                        onPressed: () {
                          _showTodoDialog(
                            context: context,
                            initialText: state.todos[index],
                            onSubmit: () {
                              context.read<TodoBloc>().add(
                                UpdateTodoEvent(
                                  index: index,
                                  updatedTask: _todoController.text,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red[400]),
                        onPressed: () {
                          context.read<TodoBloc>().add(
                            DeleteTodoEvent(index: index),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTodoDialog(
            context: context,
            onSubmit: () {
              context.read<TodoBloc>().add(
                AddTodoEvent(task: _todoController.text),
              );
            },
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
