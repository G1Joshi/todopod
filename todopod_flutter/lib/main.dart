import 'package:todopod_client/todopod_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

var client = Client('http://localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const MyHomePage(title: 'Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  int? _priority;

  String? _resultMessage;
  String? _errorMessage;

  void _showResult() {
    String text;
    Color backgroundColor;
    if (_errorMessage != null) {
      backgroundColor = Colors.red[300]!;
      text = _errorMessage!;
    } else if (_resultMessage != null) {
      backgroundColor = Colors.green[300]!;
      text = _resultMessage!;
    } else {
      backgroundColor = Colors.grey[300]!;
      text = 'No server response yet.';
    }
    setState(() {});
    _hideBanner();
    _showBanner(backgroundColor, text);
    Future.delayed(const Duration(seconds: 3), _hideBanner);
  }

  void _showBanner(Color backgroundColor, String text) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        leading: const Icon(Icons.info),
        backgroundColor: backgroundColor,
        content: Text(text),
        actions: [
          IconButton(onPressed: _hideBanner, icon: const Icon(Icons.close)),
        ],
      ),
    );
  }

  void _hideBanner() {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  }

  void _createTodo(Todo todo) async {
    try {
      await client.todo.create(todo);
      _resultMessage = 'Todo Added';
    } catch (e) {
      _errorMessage = '$e';
    }
    _showResult();
  }

  void _editTodo(Todo? todo) {
    if (todo == null) return;
    _titleController.text = todo.title;
    _descriptionController.text = todo.description;
    _showDialog(context, todo.id, todo.createdAt);
  }

  void _updateTodo(Todo todo) async {
    try {
      final result = await client.todo.update(todo);
      _resultMessage = result ? 'Todo Updated' : 'Todo Not Updated';
    } catch (e) {
      _errorMessage = '$e';
    }
    _showResult();
  }

  void _deleteTodo(int id) async {
    try {
      await client.todo.delete(id);
      _resultMessage = 'Todo Deleted';
    } catch (e) {
      _errorMessage = '$e';
    }
    _showResult();
  }

  Future<List<Todo>> _fetchTodos() async {
    return await client.todo.read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Todo>>(
        future: _fetchTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data ?? [];
            if (data.isEmpty) {
              return const Center(
                child: Text(
                  'Todo Empty!!!\nPlease Add Some Todos First.',
                  textAlign: TextAlign.center,
                ),
              );
            } else {
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
                                onPressed: (_) => _editTodo(todo),
                                backgroundColor: todo.priority == 1
                                    ? Colors.blue.shade200
                                    : todo.priority == 2
                                        ? Colors.blue.shade100
                                        : Colors.blue.shade50,
                                icon: Icons.edit,
                                label: 'Edit',
                              ),
                              SlidableAction(
                                onPressed: (_) => _deleteTodo(todo.id!),
                                backgroundColor: todo.priority == 1
                                    ? Colors.red.shade200
                                    : todo.priority == 2
                                        ? Colors.red.shade100
                                        : Colors.red.shade50,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: ColoredBox(
                            color: todo.priority == 1
                                ? Colors.teal.shade200
                                : todo.priority == 2
                                    ? Colors.teal.shade100
                                    : Colors.teal.shade50,
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
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something Went Wrong!!!'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> _showDialog(
    BuildContext context, [
    int? id,
    DateTime? createdAt,
  ]) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Todo'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
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
                controller: _descriptionController,
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
                items: [1, 2, 3]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                onChanged: (int? value) => _priority = value,
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
              if (_formKey.currentState!.validate()) {
                final todo = Todo(
                  id: id,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  priority: _priority ?? 1,
                  createdAt: createdAt ?? DateTime.now(),
                  updatedAt: DateTime.now(),
                );
                id != null ? _updateTodo(todo) : _createTodo(todo);
                Navigator.pop(context);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
