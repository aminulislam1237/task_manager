import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/TMappbar.dart';

class addnewtask extends StatefulWidget {
  const addnewtask({super.key});

  @override
  State<addnewtask> createState() => _addnewtaskState();
}

class _addnewtaskState extends State<addnewtask> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const TMappbar(),
      body:SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height:42 ,),
            const Text('Add new Task',style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            ),
            const SizedBox(height:24 ,),
            const TextField(
              decoration:InputDecoration(
                  hintText: 'Title'
              ),
            ),
            const SizedBox(height:8 ,),
            const TextField(
              maxLines: 5,
              decoration:InputDecoration(
                  hintText: 'Description',
              ),
            ),
            const SizedBox(height:16 ,),
            ElevatedButton(onPressed: () {}, child: const Icon(Icons.arrow_circle_right_outlined))
          ],
        ),
      ),
    );
  }
}
