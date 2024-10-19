import 'package:task_manager/data/models/task_model.dart';

class TaskListModel {
  String? status;
  List<TaskModel>? tasklist;

  TaskListModel({this.status, this.tasklist});

  TaskListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      tasklist = <TaskModel>[];
      json['data'].forEach((v) {
        tasklist!.add(TaskModel.fromJson(v));
      });
    }
  }
}

