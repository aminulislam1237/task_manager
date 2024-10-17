import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/utils/showsnackbarmessage.dart';
import 'package:task_manager/ui/widgets/TMappbar.dart';

class addnewtask extends StatefulWidget {
  const addnewtask({super.key});

  @override
  State<addnewtask> createState() => _addnewtaskState();
}

final TextEditingController _titleTEController = TextEditingController();
final TextEditingController _descriptionTEController = TextEditingController();
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
bool _addNewtaskInProgress = false;

class _addnewtaskState extends State<addnewtask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMappbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 42,
              ),
              const Text(
                'Add new Task',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                controller: _titleTEController,
                decoration: const InputDecoration(hintText: 'Title'),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter a value';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _descriptionTEController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter a value';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Visibility(
                  visible: !_addNewtaskInProgress,
                  replacement: const CircularProgressIndicator(),
                  child: ElevatedButton(
                      onPressed: _ontapsubmitbutton,
                      child: const Icon(Icons.arrow_circle_right_outlined)))
            ],
          ),
        ),
      ),
    );
  }

  void _ontapsubmitbutton() {
    if (_formkey.currentState!.validate()) {
      _addNewtask();
    }
  }

  Future<void> _addNewtask() async {
    _addNewtaskInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      'title': _titleTEController.text.trim(),
      'description': _descriptionTEController.text.trim(),
      'status': 'New',
    };
    final networkResponse response = await networkcaller.postRequest(
        url: urls.addnewtask, body: requestBody);
    _addNewtaskInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextFilds();
      showsnackBarMessage(context, 'New task added');
    } else {
      showsnackBarMessage(context, response.errormassage, true);
    }
  }

  void _clearTextFilds() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }
}
