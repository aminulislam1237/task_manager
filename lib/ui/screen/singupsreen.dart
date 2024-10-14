import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/screen/main_bottom_nav_bar_screeen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/cente_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class singupscreen extends StatefulWidget {
  const singupscreen({super.key});

  @override
  State<singupscreen> createState() => _singinscreenState();
}

class _singinscreenState extends State<singupscreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailLTEController = TextEditingController();
  final TextEditingController _fristnameLTEController = TextEditingController();
  final TextEditingController _lastnameLTEController = TextEditingController();
  final TextEditingController _mobileLTEController = TextEditingController();
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

  Future<void> _ontapnextbutton() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    Future<void> _singup() async {}
    _inprogress = true;
    setState(() {});
    Map<String, dynamic> requestbody ={
      "email":_emailLTEController.text.trim(),
      "firstName":_fristnameLTEController.text.trim(),
      "lastName":_lastnameLTEController.text.trim(),
      "mobile":_mobileLTEController.text.trim(),
      "password":_passwordLTEController.text,
    };

    networkResponse response = await networkcaller.postRequest(
        url: urls.registration,body: requestbody,);
    _inprogress = false;
    setState(() {});
    if (response.isSuccess) {
      _cleartextfields();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('New user created')));
    }
    else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.errormassage)));
    }
  }

  void _ontapsingup() {
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
                text: 'Sing Up',
                style: TextStyle(color: Appcolors.themecolor),
                recognizer: TapGestureRecognizer()..onTap = _ontapsingup)
          ]),
    );
  }

  Widget _buildsingupform() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailLTEController,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: 'Email'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter valid email';
              }
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _fristnameLTEController,
            keyboardType: TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: 'Frist name'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter frist Name';
              }
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _lastnameLTEController,
            keyboardType: TextInputType.text,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: 'Last name'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter valid Last Name';
              }
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _mobileLTEController,
            keyboardType: TextInputType.phone,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: 'Mobile number'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter valid mobile number';
              }
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _passwordLTEController,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(hintText: 'Password'),
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return 'Enter valid password';
              }
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Visibility(
            visible: !_inprogress,
            replacement: centercircularprogressindicator(),
            child: ElevatedButton(
                onPressed: _ontapnextbutton,
                child: Icon(Icons.arrow_circle_right_outlined)),
          ),
        ],
      ),
    );
  }


  void _cleartextfields(){
    _emailLTEController.clear();
    _fristnameLTEController.clear();
    _lastnameLTEController.clear();
    _mobileLTEController.clear();
    _passwordLTEController.clear();
  }

  @override
  void dispose() {
    _emailLTEController.dispose();
    _fristnameLTEController.dispose();
    _lastnameLTEController.dispose();
    _mobileLTEController.dispose();
    _passwordLTEController.dispose();
    super.dispose();
  }
}
