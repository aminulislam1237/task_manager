import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/New_task_screen.dart';
import 'package:task_manager/ui/screen/add_new_task.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/Task_sammary_card.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildsummarysection(),
          Expanded(
              child: ListView.separated(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Taskcard();
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 8,
              );
            },
          ),
          ),
        ],
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

  void _ontapAddFab() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const addnewtask(),
      ),
    );
  }
}
