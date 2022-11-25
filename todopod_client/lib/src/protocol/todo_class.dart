/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: unused_import
// ignore_for_file: unnecessary_import
// ignore_for_file: overridden_fields
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: depend_on_referenced_packages

import 'package:serverpod_client/serverpod_client.dart';
import 'dart:typed_data';
import 'protocol.dart';

class Todo extends SerializableEntity {
  @override
  String get className => 'Todo';

  int? id;
  late String title;
  late String description;
  late int priority;
  late bool isDone;

  Todo({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.isDone,
  });

  Todo.fromSerialization(Map<String, dynamic> serialization) {
    var _data = unwrapSerializationData(serialization);
    id = _data['id'];
    title = _data['title']!;
    description = _data['description']!;
    priority = _data['priority']!;
    isDone = _data['isDone']!;
  }

  @override
  Map<String, dynamic> serialize() {
    return wrapSerializationData({
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'isDone': isDone,
    });
  }
}
