
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:task_manager/counter_controller.dart';
import 'package:task_manager/home_screen.dart';
import 'package:task_manager/profile_screen.dart';
import 'package:task_manager/setting_screen.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinder(),
      initialRoute: '/',
      routes: {
        HomeScreen.name: (context) => const HomeScreen(),
        ProfileScreen.name: (context) => const ProfileScreen(),
        SettingsScreen.name: (context) => const SettingsScreen(),
      },
    );
  }
}

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(CounterController());
  }
}