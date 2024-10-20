import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/utils/showsnackbarmessage.dart';
import 'package:task_manager/ui/widgets/cente_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/task_card.dart';


class progresstaskscreen extends StatefulWidget {
  const progresstaskscreen({super.key});

  @override
  State<progresstaskscreen> createState() => _progresstaskscreenState();
}

class _progresstaskscreenState extends State<progresstaskscreen> {
  bool _getProgressTasklistInProgress = false;
  List<TaskModel> _ProgressTasklist = [];

  @override
  void initState() {
    super.initState();
    _getProgressTasklist();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _getProgressTasklistInProgress,
      replacement: const centercircularprogressindicator(),
      child: RefreshIndicator(
        onRefresh: () async {
          _getProgressTasklist();
        },
        child: ListView.separated(
          itemCount: 10,
          itemBuilder: (context, index) {
             Taskcard(taskModel:_ProgressTasklist[index],);
             return null;
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 8,
            );
          },
        ),
      ),
    );
  }

  Future<void> _getProgressTasklist() async {
    _ProgressTasklist.clear();
    _getProgressTasklistInProgress = true;
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
    _getProgressTasklistInProgress = false;
    setState(() {});
  }
}
