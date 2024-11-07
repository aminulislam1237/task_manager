import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/Login_model.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screen/emailvarification.dart';
import 'package:task_manager/ui/screen/main_bottom_nav_bar_screeen.dart';
import 'package:task_manager/ui/screen/singupsreen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class singinscreen extends StatefulWidget {
  const singinscreen({super.key});

  @override
  State<singinscreen> createState() => _singinscreenState();
}

class _singinscreenState extends State<singinscreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailLTEController = TextEditingController();
  final TextEditingController _passwordLTEController = TextEditingController();
  bool _inprogress = false;

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
                    onPressed: _ontapforgetpasswordbotton,
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

  void _ontapforgetpasswordbotton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const emailvarification(),
      ),
    );
  }

  void _ontapnextbutton() {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    _singIn();
  }

  Future<void> _singIn() async {
    _inprogress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      'email': _emailLTEController.text.trim(),
      'password': _passwordLTEController.text,
    };
    final networkResponse response =
        await networkcaller.postRequest(url: urls.login, body: requestBody);
    _inprogress = false;
    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseDate);

      await Authcontroller.saveAccessToken(loginModel.token!);
      await Authcontroller.saveUserData(loginModel.data!);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => mainbottomNavBarScrreen()),
          (value) => false);
    } else {
      Error;
    }
  }

  void _ontapsingup() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const singupscreen(),
        ));
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
                text: 'Sing Up',
                style: TextStyle(color: Appcolors.themecolor),
                recognizer: TapGestureRecognizer()..onTap = _ontapsingup)
          ]),
    );
  }

  Widget _buildsinginform() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _emailLTEController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: 'Email'),
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter a valid Email';
                }
                return null;
              }),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
              controller: _passwordLTEController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter a your password ';
                }
                if (value!.length <= 6) {
                  return 'Enter a password more than 6 charter';
                }
                return null;
              }),
          const SizedBox(
            height: 24,
          ),
          Visibility(
            visible: !_inprogress,
            replacement: const CircularProgressIndicator(),
            child: ElevatedButton(
                onPressed: _ontapnextbutton,
                child: Icon(Icons.arrow_circle_right_outlined)),
          ),
        ],
      ),
    );
  }
}
