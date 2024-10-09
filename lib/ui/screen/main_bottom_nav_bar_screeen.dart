import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/New_task_screen.dart';
import 'package:task_manager/ui/screen/cancelled_task_screen.dart';
import 'package:task_manager/ui/screen/completed_task_screen.dart';
import 'package:task_manager/ui/screen/progress_task_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/ui/widgets/TMappbar.dart';

class mainbottomNavBarScrreen extends StatefulWidget {
  const mainbottomNavBarScrreen({super.key});

  @override
  State<mainbottomNavBarScrreen> createState() =>
      _mainbottomNavBarScrreenState();
}

class _mainbottomNavBarScrreenState extends State<mainbottomNavBarScrreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    completedTaskscreen(),
    canclledTaskScreen(),
    progresstaskscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMappbar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            _selectedIndex = index;
            setState(() {});
          },
          destinations: const [
            const NavigationDestination(
                icon: Icon(Icons.new_label), label: 'New'),
            NavigationDestination(
                icon: Icon(Icons.check_box), label: 'Completed'),
            NavigationDestination(icon: Icon(Icons.close), label: 'Cenclled'),
            NavigationDestination(
                icon: Icon(Icons.assessment_outlined), label: 'Progress'),
          ]),
    );
  }
}
