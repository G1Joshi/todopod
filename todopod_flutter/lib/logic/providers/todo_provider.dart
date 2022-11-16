import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todopod_client/todopod_client.dart';

import '../../data/data.dart';
import '../logic.dart';

final todoProvider = FutureProvider<List<Todo>>((ref) async {
  final TodoRepo todoRepo = ref.watch(todoRepoProvider);
  final List<Todo> todos = await todoRepo.read();
  return todos;
});
