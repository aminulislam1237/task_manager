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

class canclledTaskScreen extends StatefulWidget {
  const canclledTaskScreen({super.key});

  @override
  State<canclledTaskScreen> createState() => _canclledTaskScreenState();
}

class _canclledTaskScreenState extends State<canclledTaskScreen> {
  bool _getCancelledTasklistInProgress = false;
  List<TaskModel> _CancelledTasklist = [];


  @override
  void initState() {
    super.initState();
    _getcencelledTasklist();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getCancelledTasklistInProgress,
      replacement: centercircularprogressindicator(),
      child: RefreshIndicator(
        onRefresh: () async{
          _getcencelledTasklist();
        },
        child: ListView.separated(
          itemCount: _CancelledTasklist.length,
          itemBuilder: (context, index) {
             return Taskcard(taskModel: _CancelledTasklist[index],
             onRefreshList:_getcencelledTasklist,);
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

  Future<void> _getcencelledTasklist() async {
    _CancelledTasklist.clear();
    _getCancelledTasklistInProgress = true;
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
    _getCancelledTasklistInProgress = false;
    setState(() {});
  }
}
