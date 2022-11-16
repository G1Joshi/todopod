import 'package:todopod_client/todopod_client.dart';

import '../data.dart';

class TodoRepo {
  Future<void> create(Todo todo) async {
    await client.todo.create(todo);
  }

  Future<List<Todo>> read() {
    return client.todo.read();
  }

  Future<bool> update(Todo todo) async {
    return await client.todo.update(todo);
  }

  Future<int> delete(int id) async {
    return await client.todo.delete(id);
  }
}
