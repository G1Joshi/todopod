import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todopod_client/todopod_client.dart';

import '../../data/data.dart';
import '../logic.dart';

final crudProvider = StateNotifierProvider<CrudProvider, TodoResponse>((ref) {
  final repository = ref.watch(todoRepoProvider);
  return CrudProvider(repository);
});

class CrudProvider extends StateNotifier<TodoResponse> {
  CrudProvider(this.repository) : super(TodoResponse());
  TodoRepo repository;

  void create(Todo todo) async {
    try {
      await repository.create(todo);
      state = TodoResponse(resultMessage: 'Todo Added');
    } catch (e) {
      state = TodoResponse(errorMessage: '$e');
    }
  }

  void update(Todo todo) async {
    try {
      final result = await repository.update(todo);
      state = TodoResponse(
          resultMessage: result ? 'Todo Updated' : 'Todo Not Updated');
    } catch (e) {
      state = TodoResponse(errorMessage: '$e');
    }
  }

  void delete(int id) async {
    try {
      final result = await repository.delete(id);
      state = TodoResponse(resultMessage: '$result Todo Deleted');
    } catch (e) {
      state = TodoResponse(errorMessage: '$e');
    }
  }
}
