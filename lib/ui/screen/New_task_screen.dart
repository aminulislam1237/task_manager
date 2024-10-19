import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screen/New_task_screen.dart';
import 'package:task_manager/ui/screen/add_new_task.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
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
  List<TaskModel> _newTasklist =[];

void initState(){
  super.initState();
  _getnewTasklist();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async{
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
                  itemCount:_newTasklist.length,
                  itemBuilder: (context, index) {
                    return Taskcard(taskModel: _newTasklist[index],);
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
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            summmaryTask(
              count: 9,
              title: 'new',
            ),
            summmaryTask(
              count: 9,
              title: 'completed',
            ),
            summmaryTask(
              count: 9,
              title: 'Canclled',
            ),
            summmaryTask(
              count: 9,
              title: 'Progress',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _ontapAddFab() async {
   final bool?shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const addnewtask(),
      ),
    );
   if(shouldRefresh==true){
     _getnewTasklist();
   }
  }

  Future<void> _getnewTasklist() async {
    _newTasklist.clear();
    _getNewTasklistInProgress = true;
    setState(() {});
    final networkResponse response =
        await networkcaller.getRequest(url: urls.newtasklist);
    if(response.isSuccess){
    final TaskListModel taskListModel = TaskListModel.fromJson(response.responseDate);
    _newTasklist= taskListModel.tasklist??[];
    }else{
      showsnackBarMessage(context, response.errormassage,true);
    }
    _getNewTasklistInProgress = false;
    setState(() {});
  }
}
