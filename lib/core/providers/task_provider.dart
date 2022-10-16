import 'package:dexter_health_ass/ui/screens/add_task/add_task_screen.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/foundation.dart';
import 'package:dexter_health_ass/core/models/task_model.dart';
import '../services/task_service.dart/task_service.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider(this._taskService);
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final TaskService? _taskService;
  Stream<List<TaskModel>>? _taskList;
  get tasklist => _taskList;

  void setStateAndNotifyListener(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  Future<void> AddTask({
    required title,
    required note,
    required date,
    required starttime,
    required endtime,
    required assignedTo,
    required id,
    required status,
  }) async {
    setStateAndNotifyListener(true);

    TaskModel task = TaskModel(
        title: title,
        note: note,
        date: date,
        starttime: starttime,
        endtime: endtime,
        assignedTo: assignedTo,
        id: id,
        status: status);
    await _taskService?.addTask(task);
    setStateAndNotifyListener(false);
  }

  getTaskList() {
    return _taskList = _taskService?.getTasks();
  }

  Future<void> updateTaskStatus({
    required docId,
    required status,
  }) async {
    await _taskService?.updateTaskStatus(
        status == 'done' ? 'undone' : 'done', docId);
    print(docId);
  }

  Future<void> updateTask({
    required title,
    required note,
    required date,
    required starttime,
    required endtime,
    required assignedTo,
    required id,
    required status,
  }) async {
    TaskModel task = TaskModel(
        title: title,
        note: note,
        date: date,
        starttime: starttime,
        endtime: endtime,
        assignedTo: assignedTo,
        id: id,
        status: status);
    await _taskService?.updateTask(task, task.id);
  }
}
