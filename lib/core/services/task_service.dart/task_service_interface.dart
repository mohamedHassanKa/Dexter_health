import './task_service.dart';
import '../../models/task_model.dart';

abstract class FireStoreCrudInterface {
  Future<void> addTask(TaskModel task);
  getTasks();
  Future<void> updateTask(TaskModel task, docId);
  Future<void> deleteTask({required String docid});
  Future<void> updateTaskStatus(String status, docId);
}
