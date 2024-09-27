import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/emailvarification.dart';
import 'package:task_manager/ui/screen/singupsreen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class singinscreen extends StatefulWidget {
  const singinscreen({super.key});

  @override
  State<singinscreen> createState() => _singinscreenState();
}

class _singinscreenState extends State<singinscreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: screeenbackground(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(
                height: 82,
              ),
              Text(
                'Get started With',
                style: textTheme.displaySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 24,
              ),
              _buildsinginform(),
              const SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  TextButton(
                    onPressed:_ontapforgetpasswordbotton,
                    child: Text(
                      'Forget Password',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  _buldsingupsection(),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
void _ontapforgetpasswordbotton(){
Navigator.push(context, MaterialPageRoute(builder: (context)=> const emailvarification(), ),
);
}
void _ontapnextbutton(){

}
void _ontapsingup(){
Navigator.push(context, MaterialPageRoute(
    builder: (context) => const singupscreen(),
  )
  );
}

  Widget _buldsingupsection() {
    return RichText(
      text: TextSpan(
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 0.5),
          text: "Don't have an accoutn?",
          children: [
            TextSpan(
                text: 'Sing Up', style: TextStyle(color: Appcolors.themecolor),
            recognizer: TapGestureRecognizer()..onTap =_ontapsingup
            )
          ]),
    );
  }

  Widget _buildsinginform() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(hintText: 'Email'),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(hintText: 'Password'),
        ),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
            onPressed: _ontapnextbutton, child: Icon(Icons.arrow_circle_right_outlined)),
      ],
    );
  }
}
