import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/data/utils/urls.dart';
import 'dart:convert'; // For JSON encoding/decoding
import 'package:task_manager/ui/screen/forgetpassotp.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
// Make sure to import your urls file

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final TextEditingController _emailController = TextEditingController();

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
                  'Your Email Address',
                  style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),
                Text(
                  'A 6-digit verification pin will be sent to your email address',
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

  void _onTapNextButton() {
    String email = _emailController.text.trim();
    if (_validateEmail(email)) {
      _sendVerificationEmail(email);
    } else {
      // Show a message to enter a valid email
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
    }
  }

  bool _validateEmail(String email) {
    // Simple email validation
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
  }

  Future<void> _sendVerificationEmail(String email) async {
    final String apiUrl = '${urls.RecoverVerifyEmail}/$email'; // Append email as a query parameter
print(apiUrl);
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      print('Sending verification email to: $email');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Handle successful response
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  ForgetPassOtp(email:email),
          ),
        );
      } else {
        // Handle error response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        String message = responseData['message'] ?? 'Failed to send verification email';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      print('Error: $e'); // Log the error for debugging
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred, please try again')),
      );
    }
  }



  void _onTapSignUp() {
    Navigator.pop(context);
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

  Widget _buildSignupForm() {
    return Column(
      children: [
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _onTapNextButton,
          child: const Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );
  }
}
