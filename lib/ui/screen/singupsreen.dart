import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/main_bottom_nav_bar_screeen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class singupscreen extends StatefulWidget {
  const singupscreen({super.key});

  @override
  State<singupscreen> createState() => _singinscreenState();
}

class _singinscreenState extends State<singupscreen> {
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
                'Join With Us',
                style: textTheme.displaySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 24,
              ),
              _buildsingupform(),
              const SizedBox(
                height: 24,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  _buildhaveaccountpsection(),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
void _ontapnextbutton(){

}
void _ontapsingup(){
Navigator.pop(context);
}

  Widget _buildhaveaccountpsection() {
    return RichText(
      text: TextSpan(
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 0.5),
          text: "Have accoutn?",
          children: [
            TextSpan(
                text: 'Sing Up', style: TextStyle(color: Appcolors.themecolor),
            recognizer: TapGestureRecognizer()..onTap =_ontapsingup
            )
          ]),
    );
  }

  Widget _buildsingupform() {
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
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'Frist name'),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'Last name'),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(hintText: 'Mobile number'),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(hintText: 'Password'),
        ),
        const SizedBox(
          height: 8,
        ),
        ElevatedButton(
            onPressed: _ontapnextbutton, child: Icon(Icons.arrow_circle_right_outlined)),
      ],
    );
  }
}
