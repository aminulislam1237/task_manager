import 'package:flutter/cupertino.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class completedTaskscreen extends StatelessWidget {
  const completedTaskscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Taskcard();
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 8,
        );
      },
    );
  }
}
