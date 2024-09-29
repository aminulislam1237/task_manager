import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class forgetpassotp extends StatefulWidget {
  const forgetpassotp({super.key});

  @override
  State<forgetpassotp> createState() => _singinscreenState();
}

class _singinscreenState extends State<forgetpassotp> {
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
                'Pin Varification',
                style: textTheme.displaySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 24,),
              Text(
                'A 6 digits verfication otp will be sent to your email address',
                style: textTheme.titleSmall
                    ?.copyWith(color: Colors.grey),
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
        PinCodeTextField(
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
          ),
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.blue.shade50,
          enableActiveFill: true,
          onCompleted: (v) {
            print("Completed");
          }, appContext: context,
          
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
