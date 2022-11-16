import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todopod_client/todopod_client.dart';

import '../../../data/data.dart';
import '../../../logic/logic.dart';

void formDialog(
  BuildContext context,
  WidgetRef ref,
  TextEditingController titleController,
  TextEditingController descriptionController,
  Priority? priority, [
  int? id,
  DateTime? createdAt,
]) {
  final formKey = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add Todo'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              validator: (value) => value == '' ? 'Please enter title' : null,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: descriptionController,
              validator: (value) =>
                  value == '' ? 'Please enter description' : null,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              validator: (value) =>
                  value == null ? 'Please select priority' : null,
              value: priority,
              items: Priority.priorities
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      ))
                  .toList(),
              onChanged: (Priority? value) => priority = value,
              decoration: InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              final todo = Todo(
                id: id,
                title: titleController.text,
                description: descriptionController.text,
                priority: priority?.value ?? 1,
                createdAt: createdAt ?? DateTime.now(),
                updatedAt: DateTime.now(),
              );
              if (id != null) {
                ref.read(crudProvider.notifier).update(todo);
              } else {
                ref.read(crudProvider.notifier).create(todo);
              }
              Navigator.pop(context);
              titleController.clear();
              descriptionController.clear();
              priority = null;
            }
          },
          child: const Text('Submit'),
        ),
      ],
    ),
  );
}
