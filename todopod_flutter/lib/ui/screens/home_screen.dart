import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../data/data.dart';
import '../../logic/logic.dart';
import '../../utils/utils.dart';
import '../ui.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  Priority? priority;

  @override
  Widget build(BuildContext context) {
    ref.listen<TodoResponse>(crudProvider, (previous, next) {
      String text;
      Color backgroundColor;
      if (next.errorMessage != null) {
        backgroundColor = Colors.red[300]!;
        text = next.errorMessage!;
      } else if (next.resultMessage != null) {
        backgroundColor = Colors.green[300]!;
        text = next.resultMessage!;
      } else {
        backgroundColor = Colors.grey[300]!;
        text = 'No server response yet.';
      }
      ref.invalidate(todoProvider);
      InfoBanner.showBanner(context, backgroundColor, text);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: ref.watch(todoProvider).when(
        data: (data) {
          if (data.isEmpty) {
            return const CenterText(
              'Todo Empty!!!\nPlease Add Some Todos First.',
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final todo = data[index];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) {
                              titleController.text = todo.title;
                              descriptionController.text = todo.description;
                              priority = Priority(
                                name: getPriority(todo.priority),
                                value: todo.priority,
                              );
                              formDialog(
                                context,
                                ref,
                                titleController,
                                descriptionController,
                                priority,
                                todo.id,
                                todo.createdAt,
                              );
                            },
                            backgroundColor:
                                getShade(Colors.blue, todo.priority),
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                          SlidableAction(
                            onPressed: (_) {
                              ref.read(crudProvider.notifier).delete(todo.id!);
                            },
                            backgroundColor:
                                getShade(Colors.red, todo.priority),
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: ColoredBox(
                        color: getShade(Colors.teal, todo.priority),
                        child: ListTile(
                          title: Text(todo.title),
                          subtitle: Text(todo.description),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
        error: (e, s) {
          return const CenterText('Something Went Wrong!!!');
        },
        loading: () {
          return const Loader();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => formDialog(
          context,
          ref,
          titleController,
          descriptionController,
          priority,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
