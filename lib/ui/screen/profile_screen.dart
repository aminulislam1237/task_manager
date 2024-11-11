import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/utils/showsnackbarmessage.dart';
import 'package:task_manager/ui/widgets/TMappbar.dart';

class profilescreen extends StatefulWidget {
  const profilescreen({super.key});

  @override
  State<profilescreen> createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen> {
  final TextEditingController _eamilTEcontroller = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  XFile? _selectedImage;
  bool _updateProfileInprogress = false;

  @override
  void initState() {
    super.initState();
    _setUserData();
  }

  void _setUserData() {
    _eamilTEcontroller.text = Authcontroller.userData?.email ?? '';
    _firstNameTEController.text = Authcontroller.userData?.firstName ?? '';
    _lastNameTEController.text = Authcontroller.userData?.lastName ?? '';
    _phoneTEController.text = Authcontroller.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappbar(
        isprofilescreenopen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 48,
                ),
                Text(
                  'Update Profile',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 32,
                ),
                _buildphotopicker(),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  enabled: false,
                  controller: _eamilTEcontroller,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true)
                      return 'Email is required';
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _firstNameTEController,
                  decoration: const InputDecoration(hintText: 'First Name'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true)
                      return 'First Name is required';
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: const InputDecoration(hintText: 'Last Name'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true)
                      return 'Last Name is required';
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _phoneTEController,
                  decoration: const InputDecoration(hintText: 'Phone Number'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true)
                      return 'Phone Number is required';
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _passwordTEController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: _updateProfileInprogress == false,
                  replacement: const CircularProgressIndicator(),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          _updateProfile();
                        }
                      },
                      child: Icon(Icons.arrow_circle_right_outlined)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    _updateProfileInprogress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      'email': _eamilTEcontroller.text.trim(),
      'firstName': _firstNameTEController.text.trim(),
      'lastName': _lastNameTEController.text.trim(),
      'mobile': _phoneTEController.text.trim(),
    };
    if (_passwordTEController.text.isNotEmpty) {
      requestBody['password'] = _passwordTEController.text;
    }
    if (_selectedImage != null) {
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      String convertedImage = base64Encode(imageBytes);
      requestBody['Photo'] = convertedImage;
    }
    final networkResponse response = await networkcaller.postRequest(
        url: urls.UpdateProfile, body: requestBody);
    _updateProfileInprogress = false;
    setState(() {});
    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(requestBody);
      Authcontroller.saveUserData(userModel);
      showsnackBarMessage(context, 'Profile has been updated!');
    } else {
      showsnackBarMessage(context, response.errormassage);
    }
  }

  Widget _buildphotopicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )),
              alignment: Alignment.center,
              child: Text(
                'photo',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(_getSelectedPhotoTitle()),
          ],
        ),
      ),
    );
  }

  String _getSelectedPhotoTitle() {
    if (_selectedImage != null) {
      return _selectedImage!.name;
    }
    return 'Selected photo';
  }

  Future<void> _pickImage() async {
    ImagePicker _imagePicker = ImagePicker();

    XFile? pickImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      _selectedImage = pickImage;
      setState(() {});
    }
  }
}
