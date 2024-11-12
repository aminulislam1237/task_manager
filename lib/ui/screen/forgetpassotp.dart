import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'dart:convert'; // For JSON encoding/decoding
import 'package:task_manager/ui/screen/resetpasswordscreeen.dart';
import 'package:task_manager/ui/screen/sing_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';

class ForgetPassOtp extends StatefulWidget {
  final String? email;
  const ForgetPassOtp({super.key,  this.email});

  @override
  State<ForgetPassOtp> createState() => _ForgetPassOtpState();
}

class _ForgetPassOtpState extends State<ForgetPassOtp> {
  final TextEditingController _otpController = TextEditingController();

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
                  'Pin Verification',
                  style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),
                Text(
                  'A 6-digit verification OTP will be sent to your email address',
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

  void _onTapNextButton() async {
    String otp = _otpController.text.trim();
    if (otp.length == 6) {
      await _verifyOtp(otp);
    } else {
      // Show a message to enter a valid OTP
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit OTP')),
      );
    }
  }

  Future<void> _verifyOtp(String otp) async {

    try {
      var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MzEzMzU1MzcsImRhdGEiOiJhbWludWwuaXNsYW0yMDAyNTZAZ21haWwuY29tIiwiaWF0IjoxNzMxMjQ5MTM3fQ.6WjMcOezVjZHOFH2XtzFwWdfudQGrjXpAzSKpSUMQGk";
      final response = await get(
        Uri.parse('${urls.RecoverVerifyOtp}/${widget.email}/$otp'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Add your token here
        },
      );

      if (response.statusCode == 200) {
        // Handle successful OTP verification
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: widget.email??"",otp: otp,)),
        );
      } else {
        // Handle error response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'Verification failed')),
        );
      }
    } catch (e) {
      // Handle any exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } 
  }

  void _onTapSignUp() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const singinscreen()),
          (_) => false,
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

  Widget _buildSignupForm() {
    return Column(
      children: [
        PinCodeTextField(
          controller: _otpController,
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
          ),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          onCompleted: (v) {
            print("Completed");
          },
          appContext: context,
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
