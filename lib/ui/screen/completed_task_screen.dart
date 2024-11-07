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

class completedTaskscreen extends StatefulWidget {
  const completedTaskscreen({super.key});

  @override
  State<completedTaskscreen> createState() => _completedTaskscreenState();
}

class _completedTaskscreenState extends State<completedTaskscreen> {
  bool _getCompletedTasklistInProgress = false;
  List<TaskModel> _CompletedTasklist = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTasklist();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getCompletedTasklistInProgress,
      replacement: centercircularprogressindicator(),
      child: RefreshIndicator(
        onRefresh: () async{
          _getCompletedTasklist();
        },
        child: ListView.separated(
          itemCount: _CompletedTasklist.length,
          itemBuilder: (context, index) {
            return Taskcard(
              taskModel: _CompletedTasklist[index],
              onRefreshList: _getCompletedTasklist,
            );
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

  Future<void> _getCompletedTasklist() async {
    _CompletedTasklist.clear();
    _getCompletedTasklistInProgress = true;
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
    _getCompletedTasklistInProgress = false;
    setState(() {});
  }
}
