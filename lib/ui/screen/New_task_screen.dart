import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screen/add_new_task.dart';
import 'package:task_manager/ui/utils/showsnackbarmessage.dart';
import 'package:task_manager/ui/widgets/Task_sammary_card.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTasklistInProgress = false;
  List<TaskModel> _newTasklist = [];
  List<TaskModel> _CompletedTasklist = [];
  List<TaskModel> _CancelledTasklist = [];
  List<TaskModel> _ProgressTasklist = [];

  @override
  void initState() {
    super.initState();
    _getnewTasklist();
    _getCompletedTasklist();
    _getcencelledTasklist();
    _getProgressTasklist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getnewTasklist();
        },
        child: Column(
          children: [
            _buildsummarysection(),
            Expanded(
              child: Visibility(
                visible: !_getNewTasklistInProgress,
                replacement: CircularProgressIndicator(),
                child: ListView.separated(
                  itemCount: _newTasklist.length,
                  itemBuilder: (context, index) {
                    return Taskcard(
                      taskModel: _newTasklist[index],
                      onRefreshList: _getnewTasklist,
                      deletetask: () {
                        _getDeleteTasklist(_newTasklist[index].sId ?? '');
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _ontapAddFab,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildsummarysection() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            summmaryTask(
              count: _newTasklist.length,
              title: 'new',
            ),
            summmaryTask(
              count: _CompletedTasklist.length,
              title: 'completed',
            ),
            summmaryTask(
              count: _CancelledTasklist.length,
              title: 'Canclled',
            ),
            summmaryTask(
              count: _ProgressTasklist.length,
              title: 'Progress',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _ontapAddFab() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const addnewtask(),
      ),
    );
    if (shouldRefresh == true) {
      _getnewTasklist();
    }
  }

  Future<void> _getnewTasklist() async {
    _newTasklist.clear();
    _getNewTasklistInProgress = true;
    setState(() {});
    final networkResponse response =
        await networkcaller.getRequest(url: urls.newtasklist);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseDate);
      _newTasklist = taskListModel.tasklist ?? [];
    } else {
      showsnackBarMessage(context, response.errormassage, true);
    }
    _getNewTasklistInProgress = false;
    setState(() {});
  }

  Future<void> _getCompletedTasklist() async {
    _CompletedTasklist.clear();
    setState(() {});
    final networkResponse response =
        await networkcaller.getRequest(url: urls.completedtasklist);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseDate);
      _CompletedTasklist = taskListModel.tasklist ?? [];
    } else {
      showsnackBarMessage(context, response.errormassage, true);
    }
    setState(() {});
  }

  Future<void> _getcencelledTasklist() async {
    _CancelledTasklist.clear();
    setState(() {});
    final networkResponse response =
        await networkcaller.getRequest(url: urls.cancelledtasklist);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseDate);
      _CancelledTasklist = taskListModel.tasklist ?? [];
    } else {
      showsnackBarMessage(context, response.errormassage, true);
    }
    setState(() {});
  }

  Future<void> _getProgressTasklist() async {
    _ProgressTasklist.clear();
    setState(() {});
    final networkResponse response =
        await networkcaller.getRequest(url: urls.progresstasklist);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseDate);
      _ProgressTasklist = taskListModel.tasklist ?? [];
    } else {
      showsnackBarMessage(context, response.errormassage, true);
    }
    setState(() {});
  }

  Future<void> _getDeleteTasklist(String taskID) async {
    setState(() {});
    final networkResponse response =
        await networkcaller.getRequest(url: urls.DeleteTasklist + "/$taskID");
    if (response.isSuccess) {
      _getnewTasklist();
    } else {
      showsnackBarMessage(context, response.errormassage, true);
    }
    setState(() {});
  }
}
