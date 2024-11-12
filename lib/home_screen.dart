
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager/counter_controller.dart';
import 'package:task_manager/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String name = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<CounterController>(
              builder: (counterController) {
                return Text(
                  '${counterController.counter}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(SettingsScreen.name);
                // Get.offNamed(page) // Replacement
              },
              child: const Text('Settings'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.showSnackbar(
                  const GetSnackBar(
                    title: 'Title',
                    message: 'This is message',
                    duration: Duration(seconds: 3),
                    snackPosition: SnackPosition.TOP,
                  ),
                );
              },
              child: const Text('Show Snack Bar'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<CounterController>().increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}