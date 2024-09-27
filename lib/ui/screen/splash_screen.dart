import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/ui/screen/sing_in_screen.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {


  Future<void> _movetonextscreen() async {
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const singinscreen(),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _movetonextscreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screeenbackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/logo.svg',
                width: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
