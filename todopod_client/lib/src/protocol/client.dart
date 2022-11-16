/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: public_member_api_docs
// ignore_for_file: unused_import
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:typed_data' as typed_data;
import 'package:serverpod_client/serverpod_client.dart';
import 'protocol.dart';

class _EndpointTodo extends EndpointRef {
  @override
  String get name => 'todo';

  _EndpointTodo(EndpointCaller caller) : super(caller);

  Future<void> create(
    Todo todo,
  ) async {
    var retval = await caller.callServerEndpoint('todo', 'create', 'void', {
      'todo': todo,
    });
    return retval;
  }

  Future<List<Todo>> read() async {
    var retval =
        await caller.callServerEndpoint('todo', 'read', 'List<Todo>', {});
    return (retval as List).cast();
  }

  Future<bool> update(
    Todo todo,
  ) async {
    var retval = await caller.callServerEndpoint('todo', 'update', 'bool', {
      'todo': todo,
    });
    return retval;
  }

  Future<int> delete(
    int id,
  ) async {
    var retval = await caller.callServerEndpoint('todo', 'delete', 'int', {
      'id': id,
    });
    return retval;
  }
}

class Client extends ServerpodClient {
  late final _EndpointTodo todo;

  Client(String host,
      {SecurityContext? context,
      ServerpodClientErrorCallback? errorHandler,
      AuthenticationKeyManager? authenticationKeyManager})
      : super(host, Protocol.instance,
            context: context,
            errorHandler: errorHandler,
            authenticationKeyManager: authenticationKeyManager) {
    todo = _EndpointTodo(this);
  }

  @override
  Map<String, EndpointRef> get endpointRefLookup => {
        'todo': todo,
      };

  @override
  Map<String, ModuleEndpointCaller> get moduleLookup => {};
}
