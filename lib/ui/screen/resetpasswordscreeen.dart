import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/data/utils/urls.dart';
import 'dart:convert'; // For jsonEncode
import 'package:task_manager/ui/screen/forgetpassotp.dart';
import 'package:task_manager/ui/screen/singupsreen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _comfrimedpasswordController = TextEditingController();

  Future<void> _recoverResetPassword() async {
    // Validate inputs
    if (_newpasswordController.text.isEmpty || _comfrimedpasswordController.text.isEmpty) {
      _showErrorDialog('Please fill in all fields.');
      return;
    }

    if (_newpasswordController.text != _comfrimedpasswordController.text) {
      _showErrorDialog('Passwords do not match.');
      return;
    }

    final Map<String, dynamic> body = {
      'email': _emailController.text,
      'otp': _otpController.text,
      'password': _newpasswordController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(urls.RecoverResetPassword),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Handle successful response
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForgetPassOtp()),
        );
      } else {
        // Handle error response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        // Show an error message
        _showErrorDialog(responseData['data'] ?? 'Reset failed. Please try again.');
      }
    } catch (e) {
      print(e);
      // Handle exceptions
      _showErrorDialog('An error occurred. Please try again.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

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
                const SizedBox(height: 82),
                Text(
                  'Set Password',
                  style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),
                Text(
                  'Minimum number of password should be 8 letters',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                _buildSignupForm(),
                const SizedBox(height: 24),
                _buildHaveAccountSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupForm() {
    return Column(
      children: [
        TextFormField(
          controller: _newpasswordController,
          obscureText: true,
          decoration: InputDecoration(hintText: 'New Password'),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _comfrimedpasswordController,
          obscureText: true,
          decoration: InputDecoration(hintText: 'Confirm Password'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _recoverResetPassword,
          child: const Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }

  Widget _buildHaveAccountSection() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: 0.5,
        ),
        text: "Have an account?",
        children: [
          TextSpan(
            text: ' Sign Up',
            style: TextStyle(color: Appcolors.themecolor),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignUp,
          ),
        ],
      ),
    );
  }

  void _onTapSignUp() {
    Navigator.pop(context,MaterialPageRoute(builder: (context) => const singupscreen()));
  }
}
