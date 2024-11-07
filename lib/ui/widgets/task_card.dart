import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/utils/showsnackbarmessage.dart';

class Taskcard extends StatefulWidget {
  final Function()? deletetask;
  const Taskcard({
    super.key,
    required this.taskModel,
    this.deletetask,
    required this.onRefreshList,
  });

  final TaskModel taskModel;
  final VoidCallback onRefreshList;

  @override
  State<Taskcard> createState() => _TaskcardState();
}

class _TaskcardState extends State<Taskcard> {
  String _seletedStatus = '';
  bool _ChangeStatusInProgress = false;

  @override
  void initState(){
    super.initState();
    _seletedStatus = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title ?? '',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              widget.taskModel.description ?? '',
            ),
            Text(
              "Date:${widget.taskModel.createdDate ?? ''}",
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildtaskstatuschip(),
                Wrap(
                  children: [
                    Visibility(
                      visible: _ChangeStatusInProgress==false,
                      replacement: const CircularProgressIndicator(),
                      child: IconButton(
                          onPressed: _onetabEditbutton, icon: Icon(Icons.edit)),
                    ),
                    IconButton(
                        onPressed: widget.deletetask, icon: Icon(Icons.delete)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onetabEditbutton() {
    print(_seletedStatus);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: ['New', 'Completed', 'Cancelled', 'Progress'].map((e) {
                return ListTile(
                  onTap: () {
                    _changeStatus(e);
                    Navigator.pop(context);
                  },
                  title: Text(e),
                  selected: _seletedStatus == e,
                  trailing: _seletedStatus == e ? Icon(Icons.check): null ,
                );
              }).toList(),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cencel')),
            ],
          );
        });
  }

  Widget _buildtaskstatuschip() {
    return Chip(
      label: Text(
        'new',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      side: BorderSide(color: Appcolors.themecolor),
    );
  }


  Future<void> _changeStatus( String newStatus) async {
   _ChangeStatusInProgress = true;
   setState(() {});
   final networkResponse response = await networkcaller.getRequest(
       url: urls.changeStatus(widget.taskModel.sId!, newStatus));
   if (response.isSuccess) {
     widget.onRefreshList();
     setState(() {});
   }else {
     _ChangeStatusInProgress =false;
     setState(() {
     });
     showsnackBarMessage(context, response.errormassage);
   }
  }
}
