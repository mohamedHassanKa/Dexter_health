import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dexter_health_ass/core/models/task_model.dart';
import 'task_service_interface.dart';

import 'package:dexter_health_ass/core/constants/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService implements FireStoreCrudInterface {
  TaskService();

  final _firestore = FirebaseFirestore.instance;
  @override
  Future<void> addTask(TaskModel task) async {
    var taskcollection = _firestore.collection('tasks');
    await taskcollection.add(task.tojson());
  }

  @override
  Future<void> deleteTask({required String docid}) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Stream<List<TaskModel>> getTasks() {
    return _firestore
        .collection('tasks')
        .where('assignedTo', isEqualTo: "QJ698xhBpZbDZskSaLlX")
        .snapshots(includeMetadataChanges: true)
        .map((snapshor) => snapshor.docs
            .map((doc) => TaskModel.fromjson(doc.data(), doc.id))
            .toList());
  }

  @override
  Future<void> updateTaskStatus(String status, docid) async {
    var taskcollection = _firestore.collection('tasks');

    await taskcollection.doc(docid).update({'status': status});
  }

  @override
  Future<void> updateTask(TaskModel task, docId) async {
    var taskcollection = _firestore.collection('tasks');

    await taskcollection.doc(docId).update(task.tojson());
  }
}
