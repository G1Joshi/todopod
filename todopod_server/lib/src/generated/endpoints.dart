/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: public_member_api_docs
// ignore_for_file: unnecessary_import
// ignore_for_file: unused_import

import 'dart:typed_data' as typed_data;
import 'package:serverpod/serverpod.dart';

import 'protocol.dart';

import '../endpoints/todo_endpoint.dart';

class Endpoints extends EndpointDispatch {
  @override
  void initializeEndpoints(Server server) {
    var endpoints = <String, Endpoint>{
      'todo': TodoEndpoint()..initialize(server, 'todo', null),
    };

    connectors['todo'] = EndpointConnector(
      name: 'todo',
      endpoint: endpoints['todo']!,
      methodConnectors: {
        'create': MethodConnector(
          name: 'create',
          params: {
            'todo':
                ParameterDescription(name: 'todo', type: Todo, nullable: false),
          },
          call: (Session session, Map<String, dynamic> params) async {
            return (endpoints['todo'] as TodoEndpoint).create(
              session,
              params['todo'],
            );
          },
        ),
        'read': MethodConnector(
          name: 'read',
          params: {},
          call: (Session session, Map<String, dynamic> params) async {
            return (endpoints['todo'] as TodoEndpoint).read(
              session,
            );
          },
        ),
        'update': MethodConnector(
          name: 'update',
          params: {
            'todo':
                ParameterDescription(name: 'todo', type: Todo, nullable: false),
          },
          call: (Session session, Map<String, dynamic> params) async {
            return (endpoints['todo'] as TodoEndpoint).update(
              session,
              params['todo'],
            );
          },
        ),
        'delete': MethodConnector(
          name: 'delete',
          params: {
            'id': ParameterDescription(name: 'id', type: int, nullable: false),
          },
          call: (Session session, Map<String, dynamic> params) async {
            return (endpoints['todo'] as TodoEndpoint).delete(
              session,
              params['id'],
            );
          },
        ),
      },
    );
  }

  @override
  void registerModules(Serverpod pod) {}
}
