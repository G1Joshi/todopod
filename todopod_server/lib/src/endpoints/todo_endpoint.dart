import 'package:serverpod/serverpod.dart';

import '../generated/todo_class.dart';

class TodoEndpoint extends Endpoint {
  Future<void> create(Session session, Todo todo) async {
    return await Todo.insert(session, todo);
  }

  Future<List<Todo>> read(Session session) async {
    return await Todo.find(session);
  }

  Future<bool> update(Session session, Todo todo) async {
    return await Todo.update(session, todo);
  }

  Future<int> delete(Session session, int id) async {
    return await Todo.delete(session, where: (t) => t.id.equals(id));
  }
}
